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

@interface iQiyiPlayer ()

@property (nonatomic, strong) UIButton * backBTN;//返回键
@property (nonatomic, strong) AVPlayer * player; //播放器对象
@property (nonatomic, strong) AVPlayerItem * playerItem; //播放资源类
@property (nonatomic, strong) AVPlayerLayer * playerLayer; //播放层
@property (nonatomic, strong) NSTimer * timer;//计时器

@end

@implementation iQiyiPlayer

- (void)dealloc {
    
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
        self.backgroundColor = [UIColor blackColor];
        [self initializeThePlayer];
    }
    return self;
}

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

- (void) unLockTheScreen {
    
}

- (void) setVideoURL:(NSURL *)videoURL {
    _videoURL = videoURL;
    
    // 1.如果已经下载过这个video了，那么直接播放本地视频
    // 2.播放开始之前（加载中）设置站位图
    UIImage * image = [UIImage imageNamed:@""];
    self.layer.contents = (id) image.CGImage;
    
    // 3.每次加载视频URL都设置重播为NO
    // 4.添加通知
    // 5.根据屏幕方向设置相关UI
    // 6.设置player相关参数
    [self configPlayer];
    // 7.UI搭建
    [self layoutAllSubviews];
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
//    self.isMaskShowing = YES;
    //延迟隐藏Controller
//    [self autoFadeOutControlBar];
    
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(playerTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //添加手势
//    [self createGesture];
    
    //获取系统音量
//    [self configureVolume];
    
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

/**
 *  UI搭建（返回、进度条、时间、快进、快退、亮度、音量控制）
 */
- (void) layoutAllSubviews {
    [self layoutBackwardButton]; //返回键
    [self layoutProgressView];   //进度条
    [self addGestures];          //手势控制
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    
    //屏幕方向一发生变化就会调用这里
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [self layoutIfNeeded];
}

//返回键搭建
- (void) layoutBackwardButton {
    _backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBTN setFrame:CGRectMake(30, 20, 36, 44)];
    [_backBTN setImage:[UIImage imageNamed:@"common_actionbar_back1"] forState:UIControlStateNormal];
//    [_backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.left.mas_equalTo(5);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//    }];
    [self addSubview:_backBTN];
    [_backBTN addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

//进度条
- (void) layoutProgressView {

}

//添加手势
- (void) addGestures {
    //1.快进
    //2.快退
    //3.亮度
    //4.音量
}

//


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



@end
