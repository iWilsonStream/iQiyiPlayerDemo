//
//  iQiyiPlayer.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "iQiyiPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerSubviewsConsole.h"
#import "PlayerBrightnessView.h"

static const CGFloat iQiyiPlayerAnimationTimeDuration             = 7.0f;
static const CGFloat iQiyiPlayerConsoleBarAutoFadeOutTimeDuration = 0.5f;

//水平移动和垂直移动的枚举值
typedef NS_ENUM(NSUInteger, PanGestureDirection) {
    PanGestureDirectionHorizontal, //横向手势
    PanGestureDirectionVertical    //纵向手势
};

typedef NS_ENUM(NSUInteger, PlayerSate) {
    PlayerSateFailed,     //播放失败
    PlayerSateBuffering,  //缓冲中
    PlayerSatePlaying,    //播放中
    PlayerSateStopped,    //停止
    PlayersatePause       //暂停
};

@interface iQiyiPlayer () <UIGestureRecognizerDelegate>

//播放器对象
@property (nonatomic, strong) AVPlayer * player;
//播放资源类
@property (nonatomic, strong) AVPlayerItem * playerItem;
//播放层
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
//手势类型（横向、纵向）
@property (nonatomic, assign) PanGestureDirection panDirection;
//播放状态
@property (nonatomic, assign) PlayerSate state;
//视频控制控件
@property (nonatomic, strong) PlayerSubviewsConsole * consoleView;
//音量控制器
@property (nonatomic, strong) UISlider * volumeViewSlider;
//计时器
@property (nonatomic, strong) NSTimer * timer;
//用来保存快进的总时长
@property (nonatomic, assign) CGFloat sumTime;
//是否全屏
@property (nonatomic, assign) BOOL isFullScreen;
//是否锁定屏幕方向
@property (nonatomic, assign) BOOL isLocked;
//是否在调解音量
@property (nonatomic, assign) BOOL isVolume;
//是否显示视频控制控件
@property (nonatomic, assign) BOOL isMaskShowing;
//是否被用户暂停
@property (nonatomic, assign) BOOL isPauseByUser;
//是否是本地视频
@property (nonatomic, assign) BOOL isLocalVideo;
//上次播放位置值
@property (nonatomic, assign) CGFloat sliderLastValue;
//是否再次设置URL播放器
@property (nonatomic, assign) BOOL repeatToPlay;
//是否播放完毕
@property (nonatomic, assign) BOOL playDidEnd;
//返回键
@property (nonatomic, strong) UIButton * backBTN;

@end

@implementation iQiyiPlayer

#pragma mark - 构建及销毁相关
- (void)dealloc {
    self.playerItem = nil;
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype) sharedPlayerView {
    static iQiyiPlayer * player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [iQiyiPlayer new];
    });
    return player;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeThePlayer];
    }
    return self;
}

- (PlayerSubviewsConsole *)consoleView {
    if(!_consoleView) {
        _consoleView = [[PlayerSubviewsConsole alloc] init];
        [self addSubview:_consoleView];
        [_consoleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.bottom.equalTo(self);
        }];
    }
    return _consoleView;
}

#pragma mark - 界面相关
/**
 *  storyboard、xib加载playerView会调用此方法
 */
- (void)awakeFromNib
{
    [self initializeThePlayer];
}

- (void) initializeThePlayer {
    //每次播放视频都解锁屏幕锁定
    [self unLockTheScreen];
}

/**
 *  屏幕锁定  开！
 */
- (void) unLockTheScreen {
    // 调用AppDelegate单例纪录播放状态是否锁屏
    PlayerBrightness.isLockScreen = NO;
    self.consoleView.lockBtn.selected = NO;
    self.isLocked = NO;
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void) setVideoURL:(NSURL *)videoURL {
    _videoURL = videoURL;
    
    // 1.如果已经下载过这个video了，那么直接播放本地视频
    // 2.播放开始之前（加载中）设置站位图
    UIImage * image = [UIImage imageNamed:@"loading_bgView"];
    self.layer.contents = (id) image.CGImage;
    
    // 3.每次加载视频URL都设置重播为NO
    self.repeatToPlay = NO;
    self.playDidEnd   = NO;
    
    // 4.添加通知
    [self addNotifications];
    
    // 5.根据屏幕方向设置相关UI
    [self onDeviceOrientationChange];
    
    // 6.设置player相关参数
    [self configPlayer];
}

- (void) configPlayer {
    // 初始化playerItem
    self.playerItem = [AVPlayerItem playerItemWithURL:self.videoURL];
    
    //每次重新创建player，替换replaceCurrentItemWithPlayerItem，该方法会阻塞现线程
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    //初始化playerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    //此处为默认视频填充模式
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加playerlayer到self.layer
    [self.layer insertSublayer:self.playerLayer above:0];
    
    //初始化显示controlView为YES
    self.isMaskShowing = YES;
    //延迟隐藏Controller
    [self autoFadeOutConsoleBar];
    
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(playerTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //添加手势
    [self createGesture];
    
    //获取系统音量
    [self configureVolume];
    
    // 本地文件不设置ZFPlayerStateBuffering状态
//    if ([self.videoURL.scheme isEqualToString:@"file"]) {
//        self.state = ZFPlayerStatePlaying;
//        self.isLocalVideo = YES;
//        self.controlView.downLoadBtn.enabled = NO;
//    } else {
//        self.state = ZFPlayerStateBuffering;
//        self.isLocalVideo = NO;
//    }
    
    //开始播放
    [self play];
//    self.controlView.startBtn.selected = YES;
//    self.isPauseByUser                 = NO;
    
    //强制让系统调用layoutSubviews 两个方法必须同时写
    [self setNeedsLayout];//是标记异步刷新 但是会很慢
    [self layoutIfNeeded];//加上此代码立刻刷新
}

//获取系统音量
- (void) configureVolume {
    MPVolumeView * volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for(UIView * view in [volumeView subviews]) {
        if([view.class.description isEqualToString:@"MPVolumeSlider"]) {
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    //使用这个category的应用不会随着手机静音键打开而静音，可在手机静音下播放声音
    NSError * setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    
    if(!success) {
        /* handle the error in setCategoryError*/
    }
    
    //监听耳机插入和拔掉的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallBack:) name:AVAudioSessionRouteChangeNotification object:nil];
}

/**
 *  耳机插入、拔出事件
 */
- (void) audioRouteChangeListenerCallBack:(NSNotification *)notifi {
    NSDictionary * interuptionDict = notifi.userInfo;
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:{//耳机插入时
            
        }
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable: {//耳机拔出时
            
        }
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange: {
            //called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
        }
            break;
            
        default:
            break;
    }
}

/**
 *  重置player
 */
- (void) resetPlayer {
    self.playDidEnd = NO;
    self.playerItem = nil;
    //视频跳转秒数置0
    self.seekTime = 0;
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //关闭定时器
    [self.timer invalidate];
    //暂停
    [self pause];
    //移除原来的layer
    [self.playerLayer removeFromSuperlayer];
    //替换playeritem
    [self.player replaceCurrentItemWithPlayerItem:nil];
    //把player置为nil
    self.player = nil;
    //重置控制层view
    [self.consoleView resetConsoleView];
    //非重播时，移除当前playerView
    if(!self.repeatToPlay) {
//        [self removeFromSuperview];
    }
    //底部播放video改为NO
    
}

/**
 *  在当前页面，设置新的player的URL调用此方法
 */
- (void) resetToPlayNewURL {
    self.repeatToPlay = YES;
    [self resetPlayer];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    //只要屏幕旋转就显示控制层
    self.isMaskShowing = NO;
    //延迟隐藏consoleView
    [self animateShow];

    //4s,屏幕宽高比不是16:9的问题，player加到控制器上的时候
    if(iPhone4_4S) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(kScreenSize.width * 2 / 3);
        }];
    }
//    //屏幕方向一发生变化就会调用这里
//    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [self layoutIfNeeded];
}

#pragma mark - 操作相关
- (void) createGesture {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateRecognized) {
//        if(!self.isFullScreen) {
//            [self fullScreenAction:self.consoleView.fullScreenBtn];
//            return;
//        }
        if(self.isMaskShowing) {
            [self hideConsoleView];
        } else {
            [self animateShow];
        }
    }
}

- (void)hideConsoleView {
    if(!self.isMaskShowing) {
        return;
    }
    [UIView animateWithDuration:iQiyiPlayerConsoleBarAutoFadeOutTimeDuration animations:^{
        [self.consoleView hideConsoleView];
        if(self.isFullScreen) {//全屏状态
            self.consoleView.backBtn.alpha = 0;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        } else if (!self.isFullScreen) {//视频在底部bottom
            self.consoleView.backBtn.alpha = 1;
        } else {
            self.consoleView.backBtn.alpha = 0;
        }
    } completion:^(BOOL finished) {
        self.isMaskShowing = NO;
    }];
}

//退到后台
- (void) appDidEnterBackground {
    [self pause];
    self.state = PlayersatePause;
    [self cancelAutoFadeOutControlBar];
}

/**
 *  取消延时隐藏ConsoleView的方法
 */
- (void) cancelAutoFadeOutControlBar {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void) autoFadeOutConsoleBar {
    if(!self.isMaskShowing) {
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideConsoleView) object:nil];
    [self performSelector:@selector(hideConsoleView) withObject:nil afterDelay:iQiyiPlayerAnimationTimeDuration];
}

//进入前台
- (void) appDidEnterForeground {
    self.isMaskShowing = NO;
    // 延迟隐藏console
    [self animateShow];
    if(!self.isPauseByUser) {
        self.state = PlayerSatePlaying;
        self.consoleView.startBtn.selected = YES;
        self.isPauseByUser = NO;
        [self play];
    }
}

- (void) animateShow {
    if(self.isMaskShowing) {
        return;
    }
    
    [UIView animateWithDuration:iQiyiPlayerConsoleBarAutoFadeOutTimeDuration animations:^{
        self.consoleView.backBtn.alpha = 1;
        // 视频在底部bottom的小屏，非全屏状态
//        if(!self.isFullScreen) {
//            [self.consoleView hideConsoleView];
//        } else if (self.playDidEnd) {//播放完了
//            [self.consoleView hideConsoleView];
//        } else {
            [self.consoleView showConsoleView];
//        }
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    } completion:^(BOOL finished) {
        self.isMaskShowing = YES;
        [self autoFadeOutConsoleBar];
    }];
}

//滑动杆按下
- (void) progressSliderTouchBegan:(UISlider *)slider {
    [self cancelAutoFadeOutControlBar];
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        //暂停timer
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

//滑动杆滑动中
- (void) progressSliderValueChanged:(UISlider *)slider {
    //拖动改变视频播放进度
    if(self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        NSString * style = @"";
        CGFloat value = slider.value - self.sliderLastValue;
        if(value > 0) {//快进
            style = @">>";
        } else if (value < 0) {//快退
            style = @"<<";
        }
        self.sliderLastValue = slider.value;
        
        [self pause];
        
        CGFloat total = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
        
        //计算出拖动的当前秒数
        NSInteger dragedSeconds = floorf(total * slider.value);
        //转换成CMTime才能给player来控制播放进度
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        //拖拽的时长
        NSInteger proMin = (NSInteger)CMTimeGetSeconds(dragedCMTime) / 60;
        NSInteger proSec = (NSInteger)CMTimeGetSeconds(dragedCMTime) % 60;
        
        //duration 总时长
        NSInteger durMin = (NSInteger)total / 60;//总秒数
        NSInteger durSec = (NSInteger)total % 60;//总分钟
        
        NSString * currentTime = [NSString stringWithFormat:@"%02zd:%02zd",proMin,proSec];
        NSString * totalTime   = [NSString stringWithFormat:@"%02zd:%02zd",durMin,durSec];
        
        if(total > 0) {
            //当总时长 > 0时候才能拖动slider
            self.consoleView.currentTimeLabel.text = currentTime;
            self.consoleView.horizontalLabel.hidden = NO;
            self.consoleView.horizontalLabel.text   = [NSString stringWithFormat:@"%@ %@ /%@",style, currentTime, totalTime];
        } else {
            //此时设置slider值为0
            slider.value = 0;
        }
    } else {//player状态加载失败
        //此时设置slider值为0
        slider.value = 0;
    }
}

//滑动杆滑动结束
- (void) progressSliderTouchEnd:(UISlider *)slider {
    if(self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        //继续开启timer
        [self.timer setFireDate:[NSDate date]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
           dispatch_get_main_queue(), ^{
               self.consoleView.horizontalLabel.hidden = YES;
        });
        // 结束滑动的时候把开始播放按钮改为播放状态
        self.consoleView.startBtn.selected = YES;
        self.isPauseByUser = NO;
        
        //滑动结束时隐藏consoleView
        [self autoFadeOutConsoleBar];
        //视频总时间长度
        CGFloat total = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
        //计算出拖动的当前秒数
        NSInteger dragedSeconds = floorf(total * slider.value);
        [self seekToTime:dragedSeconds];
    }
}

/**
 *  从xx秒开始播放视频跳转方法
 *  @param dragedSeconds 跳转的秒数
 */
- (void)seekToTime:(NSInteger)dragedSeconds {
    if(self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        //seekTime:completionHandler:不能精确定位
        //如果需要精确定位，可以使用seekToTime:toleranceBefore:toleranceAfter:completionHandler:
        //转换成CMTime才能给player来控制播放进度
        CMTime draggedCMTime = CMTimeMake(dragedSeconds, 1);
        [self.player seekToTime:draggedCMTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
            //如果点击了暂停按钮
            if(self.isPauseByUser) {
                return ;
            }
            [self play];
            if(!self.playerItem.isPlaybackLikelyToKeepUp && !self.isLocalVideo) {
                self.state = PlayerSateBuffering;
            }
        }];
    }
}

//开始播放通知调用
- (void) startPlayAction:(NSNotification *)notifi {
    NSLog(@"开始播放");
}

//全屏按钮点击
- (void) fullScreenAction:(UIButton *)sender {
    
}

//锁屏
- (void) lockScreenAction:(NSNotification *)notifi {
    NSLog(@"点击锁屏按钮了");
}

//重播
- (void) repeatPlay:(NSNotification *)notifi {
    NSLog(@"点击了重播按钮");
}

//下载
- (void) downloadVideo:(NSNotification *)notifi {
    NSLog(@"点击了下载");
}

/**
 *  播放
 */
- (void) play {
    [_player play];
}

/**
 *  暂停
 */
- (void) pause {
    [_player pause];
}

- (void) playerTimerAction {
    if(_playerItem.duration.timescale != 0) {
        //音乐总时长
        self.consoleView.videoSlider.maximumValue = 1;
        //当前进度
        self.consoleView.videoSlider.value = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);
        
        //当前时长进度progress
        NSInteger proMin = (NSInteger)CMTimeGetSeconds([_player currentTime]) / 60;//当前分钟
        NSInteger proSec = (NSInteger)CMTimeGetSeconds([_player currentTime]) % 60;//当前秒钟
        
        //duration 总时长
        NSInteger durMin = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale / 60;//总分钟
        NSInteger durSec = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale % 60;//总秒
        
        self.consoleView.currentTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",proMin,proSec];
        self.consoleView.totalTimeLabel.text   = [NSString stringWithFormat:@"%02zd:%02zd",durMin,durSec];
    }
}

/**
 *  返回按钮事件
 */
- (void)backButtonAction {
    [_player pause];
    if(self.backBlock) {
        self.backBlock();
    }
}

- (void)panDirection:(UIPanGestureRecognizer *)panGesture {
   //根据在view上Pan的位置，确定是条音量还是亮度
    CGPoint locationPoint = [panGesture locationInView:self];
    
    //我们要影响水平移动和垂直移动
    //根据上次和本次移动的位置，算出一个速率的point
    CGPoint velocityPoint = [panGesture velocityInView:self];
    
    //判断是垂直移动还是水平移动
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {//开始移动
            //使用绝对值来判断移动方向
            CGFloat x = fabs(velocityPoint.x);
            CGFloat y = fabs(velocityPoint.y);
            if(x > y) {//水平移动
                self.panDirection = PanGestureDirectionHorizontal;
                //取消隐藏
                self.consoleView.horizontalLabel.hidden = NO;
                //给sumTime初始值
                CMTime time = self.player.currentTime;
                self.sumTime = time.value / time.timescale;
                
                //暂停视频播放
                [self pause];
                //暂停timer
                [self.timer setFireDate:[NSDate distantFuture]];
            } else if (x < y) {//垂直移动
                self.panDirection = PanGestureDirectionHorizontal;
                //开始滑动的时候，状态改为正在控制音量
                if(locationPoint.x > self.bounds.size.width / 2) {//屏幕右边为控制音量
                    self.isVolume = YES;
                } else {
                    self.isVolume = NO;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: { //正在移动
            switch (self.panDirection) {
                case PanGestureDirectionHorizontal: {//横向移动快进快退
                    [self horizontalMoved:velocityPoint.x];
                }
                    break;
                case PanGestureDirectionVertical: {//垂直
                    [self verticalMoved:velocityPoint.y];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {//移动终止
            //移动结束也需要判断垂直或平移
            //比如水平移动结束时，要快进到指定的位置，如果这里没有判断，当我们调节万音量之后，会出现屏幕跳动的bug
            switch (self.panDirection) {
                case PanGestureDirectionHorizontal: {//水平移动手势
                    //继续播放
                    [self play];
                    [self.timer setFireDate:[NSDate date]];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //隐藏视图
                        self.consoleView.horizontalLabel.hidden = YES;
                    });
                    
                    //快进、快退时候把开始播放按钮改为播放状态
                    self.consoleView.startBtn.selected = YES;
                    self.isPauseByUser = NO;
                    
                    [self seekToTime:self.sumTime];
                    //把sumTime置空，以备下一次快进快退调用
                    self.sumTime = 0;
                }
                    break;
                case PanGestureDirectionVertical: {//垂直移动手势
                    //垂直移动结束后，把状态改为不在控制音量
                    self.isVolume = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.consoleView.horizontalLabel.hidden = YES;
                    });
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

//横向移动手势
- (void)horizontalMoved:(CGFloat)value {
    //快进快退的方法
    NSString * actionType = @"";
    if(value < 0) {//快退
        actionType = @"<<";
    } else if (value > 0) {//快进
        actionType = @">>";
    }
    //每次滑动需要叠加时间
    self.sumTime += value / 200;
    
    //需要限定sumTime的范围
    CMTime totalTime = self.playerItem.duration;
    CGFloat totalMovieDuration = (CGFloat)totalTime.value / totalTime.timescale;//影片总秒数
    if(self.sumTime > totalMovieDuration) {//过滤掉异常值
        self.sumTime = totalMovieDuration;
    } else if (self.sumTime < 0) {
        self.sumTime = 0;
    }
    
    //当前快进的时间
    NSString * nowTime = [self getDurationStringWithTime:(int)self.sumTime];
    //总时间
    NSString * durationTime = [self getDurationStringWithTime:(int)totalMovieDuration];
    //给label赋值
    self.consoleView.horizontalLabel.text = [NSString stringWithFormat:@"%@ %@ / %@",actionType,nowTime,durationTime];
}

/**
 *  根据时长算出时长的字符串
 *  @param time 传入时长（int）
 *  @return 返回时长字符串
 */
- (NSString *)getDurationStringWithTime:(int)time {
    //获取分钟
    NSString * min = [NSString stringWithFormat:@"%02d",time / 60];
    //获取秒数
    NSString * sec = [NSString stringWithFormat:@"%02d",time % 60];
    
    return [NSString stringWithFormat:@"%@:%@",min,sec];
}

//纵向移动手势
- (void)verticalMoved:(CGFloat)value {
    
}

#pragma mark - 屏幕旋转相关
/**
 *  强制屏幕旋转
 *  @param orientation 屏幕方向
 */
- (void) interfaceOrientation:(UIInterfaceOrientation)orientation {
    
}

- (void) onDeviceOrientationChange {
    
}

#pragma mark - 通知相关
- (void) addNotifications {
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // slider开始滑动事件
    [self.consoleView.videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    // slider滑动中事件
    [self.consoleView.videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    // slider结束滑动事件
    [self.consoleView.videoSlider addTarget:self action:@selector(progressSliderTouchEnd:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside | UIControlEventTouchCancel];
    
    // 播放按钮点击事件
    [self.consoleView.startBtn addTarget:self action:@selector(startPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.consoleView.backBtn setImage:[UIImage imageNamed:@"play_back_full"] forState:UIControlStateNormal];
    
    // 返回按钮点击事件
    [self.consoleView.backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    // 全屏按钮点击事件
    [self.consoleView.fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
    // 锁定屏幕方向事件
    [self.consoleView.lockBtn addTarget:self action:@selector(lockScreenAction:) forControlEvents:UIControlEventTouchUpInside];
    // 重播
    [self.consoleView.repeatBtn addTarget:self action:@selector(repeatPlay:) forControlEvents:UIControlEventTouchUpInside];
    // 下载
    [self.consoleView.downLoadBtn addTarget:self action:@selector(downloadVideo:) forControlEvents:UIControlEventTouchUpInside];
    //检测设备方向
    [self listeningRotation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(object == self.player.currentItem) {
        if([keyPath isEqualToString:@"status"]) {
            if(self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                self.state = PlayerSatePlaying;
                //加载完成后，在添加平移手势
                //添加平移手势，用来控制音量、亮度、快进快退
                UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDirection:)];
                pan.delegate = self;
                [self addGestureRecognizer:pan];
                
                //跳转到xx秒
                if(self.seekTime) {
                    [self seekToTime:self.seekTime];
                }
            } else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
                self.state = PlayerSateFailed;
                NSError * error = [self.player.currentItem error];
                NSLog(@"视频加载失败===%@",error.description);
                self.consoleView.horizontalLabel.hidden = NO;
                self.consoleView.horizontalLabel.text = @"视频加载失败";
            }
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            //计算缓冲进度
            NSTimeInterval timeInterval = [self bufferingProgress];
            CMTime duration = self.playerItem.duration;
            CGFloat totalDuration = CMTimeGetSeconds(duration);
            [self.consoleView.progressView setProgress:timeInterval / totalDuration animated:NO];
        } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            //当缓冲是空的时候
            if(self.playerItem.playbackBufferEmpty) {
                self.state = PlayerSateBuffering;
                [self badBufferingCondition];
            }
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            //当缓冲条件好的的时候
            if(self.playerItem.playbackLikelyToKeepUp) {
                self.state = PlayerSatePlaying;
            }
        }
    } else {
        
    }
}

//计算点击区域
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.consoleView];
    //屏幕下方slider区域  在cell上播放视频 && 不是全屏状态   播放完了（不需要相应pan手势）
    if((point.y > self.bounds.size.height - 40 ) || self.playDidEnd) {
        return NO;
    }
    return YES;
}

- (void) listeningRotation {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

/**
 *  播放完了
 *
 *  @param notification
 */
- (void) moviePlayDidEnd:(NSNotification *)notifi {
    self.state = PlayerSateStopped;
    if(!self.isFullScreen) {
        self.repeatToPlay = NO;
        self.playDidEnd   = NO;
        [self resetPlayer];
    } else {
        self.consoleView.backgroundColor = RGBWithAlpha(0, 0, 0, 0.6);
        self.playDidEnd = YES;
        self.consoleView.repeatBtn.hidden = NO;
        //初始化显示console为YES
        self.isMaskShowing = NO;
        [self animateShow];
    }
}

#pragma mark - 计算缓冲相关
/**
 *  视频在缓冲  计算缓冲进度
 *
 *  @return 缓冲进度
 */
- (NSTimeInterval)bufferingProgress {
    NSArray * loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    //获取到缓冲区域
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    //获取到开始缓冲的时间位置
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    //获取到缓冲的总时长
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    //计算出缓冲的区域
    NSTimeInterval result = startSeconds + durationSeconds;
    
    return result;
}

/**
 *  缓冲条件差时
 */
- (void) badBufferingCondition {
    self.state = PlayerSateBuffering;
    //playbackBufferEmpty会反复进入这个方法，因此在bufferingOneSecond延时播放执行完之前再调用这个方法
    __block BOOL isBuffering = NO;
    if(isBuffering) {
        return;
    }
    isBuffering = YES;
    
    //需要先暂停一会儿之后再播放，否则网络状况不好的时候在走，声音却播放不出来
    [self pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //如果此时用户已经暂停了，则不需要开启播放了
        if(self.isPauseByUser) {
            isBuffering = NO;
            return ;
        }
        [self play];
        //如果执行了play还是没有播放，则说明还没缓冲好，则再次缓存一段时间
        if(!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self badBufferingCondition];
        }
    });
}

#pragma mark - setter
/**
 *  设置播放状态
 *  @param state PlayerSate
 */
- (void)setState:(PlayerSate)state {
    _state = state;
    if(state == PlayerSatePlaying) {
        //改为黑色背景,不然展位图会显示
        UIImage * image = [self buttonImageFromColor:[UIColor blackColor]];
        self.layer.contents = (id) image.CGImage;
    } else if (state == PlayerSateFailed) {
        self.consoleView.downLoadBtn.enabled = NO;
    }
    
    //控制菊花的显示与隐藏
    if(state == PlayerSateBuffering) {
        [self.consoleView.activity startAnimating];
    } else {
        [self.consoleView.activity stopAnimating];
    }
}

- (UIImage *)buttonImageFromColor:(UIColor *)color {
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/**
 *  根据playerItem，来添加移除观察者
 *  @param playerItem
 */
- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    if(_playerItem == playerItem) return;
    
    if(_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [_playerItem removeObserver:self forKeyPath:@"status"];
//        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    if(playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        //缓冲区空了，需要等待数据加载
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        //缓冲区有足够数据可以播放了
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

/**
 *  设置playerLayer填充模式
 *
 *  @param playerLayerGravity
 */
- (void)setPlayerLayerGravityMode:(PlayerLayerGravityMode)playerLayerGravityMode {
    _playerLayerGravityMode = playerLayerGravityMode;
    // AVLayerVideoGravityResize,           // 非均匀模式。两个维度完全填充至整个视图区域
    // AVLayerVideoGravityResizeAspect,     // 等比例填充，直到一个维度到达区域边界
    // AVLayerVideoGravityResizeAspectFill  // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被
    switch (playerLayerGravityMode) {
        case PlayerLayerGravityModeResize:
            self.playerLayer.videoGravity = AVLayerVideoGravityResize;
            break;
        case PlayerLayerGravityModeResizeAspect:
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            break;
        case PlayerLayerGravityModeResizeAspectFill:
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            break;
        default:
            break;
    }
}

@end
