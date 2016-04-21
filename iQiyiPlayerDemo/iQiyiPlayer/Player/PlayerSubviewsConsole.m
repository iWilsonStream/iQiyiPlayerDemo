//
//  PlayerSubviewsConsole.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/20.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PlayerSubviewsConsole.h"

@interface PlayerSubviewsConsole ()

/** 开始播放按钮 **/
@property (nonatomic, strong) UIButton * startBtn;
/** 当前播放时长label **/
@property (nonatomic, strong) UILabel  * currentTimeLabel;
/** 视频总时长label **/
@property (nonatomic, strong) UILabel  * totalTimeLabel;
/** 缓冲进度条 **/
@property (nonatomic, strong) UIProgressView * progressView;
/** 滑杆 **/
@property (nonatomic, strong) UISlider * videoSlider;
/** 全屏按钮 **/
@property (nonatomic, strong) UIButton * fullScreenBtn;
/** 锁定屏幕方向按钮 **/
@property (nonatomic, strong) UIButton * lockBtn;
/** 快进快退label **/
@property (nonatomic, strong) UILabel  * horizontalLabel;
/** 系统菊花 **/
@property (nonatomic, strong) UIActivityIndicatorView * activity;
/** 返回按钮 **/
@property (nonatomic, strong) UIButton * backBtn;
/** 重播按钮 **/
@property (nonatomic, strong) UIButton * repeatBtn;
/** bottomView **/
@property (nonatomic, strong) UIImageView * bottomImageView;
/** topView **/
@property (nonatomic, strong) UIImageView * topImageView;
/** 缓存按钮 **/
@property (nonatomic, strong) UIButton * downLoadBtn;

@end

@implementation PlayerSubviewsConsole

- (instancetype) init {
    if(self = [super init]) {
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomImageView];
        [self.bottomImageView addSubview:self.startBtn];
        [self.bottomImageView addSubview:self.currentTimeLabel];
        [self.bottomImageView addSubview:self.progressView];
        [self.bottomImageView addSubview:self.videoSlider];
        [self.bottomImageView addSubview:self.fullScreenBtn];
        [self.bottomImageView addSubview:self.totalTimeLabel];
        
//        self.bottomImageView.backgroundColor = [UIColor whiteColor];
        
        [self.topImageView addSubview:self.downLoadBtn];
        
        [self addSubview:self.lockBtn];
        [self addSubview:self.backBtn];
        [self addSubview:self.activity];
        [self addSubview:self.repeatBtn];
        [self addSubview:self.horizontalLabel];
        
        //添加子控件的约束
        [self makeSubviewsConstraints];
//        [self.activity stopAnimation];
        self.horizontalLabel.hidden = YES;
        self.repeatBtn.hidden = YES;
        self.downLoadBtn.hidden = YES;
        // 初始化时重置ControlView
        [self resetConsoleView];
    }
    return self;
}

- (void) makeSubviewsConstraints {
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self);
        make.height.mas_equalTo(80);
    }];
    
    [self.downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.trailing.equalTo(self.topImageView.mas_trailing).offset(-10);
        make.centerX.equalTo(self.backBtn.mas_centerY);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomImageView.mas_leading).offset(5);
        make.bottom.equalTo(self.bottomImageView.mas_bottom).offset(-5);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.startBtn.mas_trailing).offset(-3);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.trailing.equalTo(self.bottomImageView.mas_trailing).offset(-5);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.fullScreenBtn.mas_leading).offset(3);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentTimeLabel.mas_trailing).offset(4);
        make.trailing.equalTo(self.totalTimeLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
    
    [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentTimeLabel.mas_trailing).offset(4);
        make.trailing.equalTo(self.totalTimeLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.currentTimeLabel.mas_centerY).offset(-0.25);
    }];
    
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.horizontalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self);
    }];
    
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
    }];
    
    [self.repeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void) resetConsoleView {
    self.videoSlider.value = 0;
    self.progressView.progress = 0;
    self.currentTimeLabel.text = @"00:00";
    self.totalTimeLabel.text = @"00:00";
    self.horizontalLabel.hidden = YES;
    self.repeatBtn.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void) showConsoleView {
    self.topImageView.alpha = 1;
    self.bottomImageView.alpha = 1;
    self.lockBtn.alpha = 1;
}

- (void) hideConsoleView {
    self.topImageView.alpha = 0;
    self.bottomImageView.alpha = 0;
    self.lockBtn.alpha = 0;
}

#pragma mark - getter
- (UIButton *)backBtn {
    if(!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"play_back_full"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UIImageView *)topImageView {
    if(!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.image = [UIImage imageNamed:@"top_shadow"];
    }
    return _topImageView;
}

- (UIImageView *)bottomImageView {
    if(!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.userInteractionEnabled = YES;
        _bottomImageView.image = [UIImage imageNamed:@"bottom_shadow"];
    }
    return _bottomImageView;
}

- (UIButton *)lockBtn {
    if(!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:[UIImage imageNamed:@"unlock-nor"] forState:UIControlStateNormal];
        [_lockBtn setImage:[UIImage imageNamed:@"lock-nor"] forState:UIControlStateSelected];
    }
    return _lockBtn;
}

- (UIButton *)startBtn {
    if(!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:[UIImage imageNamed:@"kr-video-player-play"] forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@"kr-video-player-pause"] forState:UIControlStateSelected];
    }
    return _startBtn;
}

- (UILabel *)currentTimeLabel {
    if(!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:12.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}

- (UIProgressView *)progressView {
    if(!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = RGBWithAlpha(1, 1, 1, 0.3);
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (UISlider *)videoSlider {
    if(!_videoSlider) {
        _videoSlider = [[UISlider alloc] init];
        [_videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        
        _videoSlider.minimumTrackTintColor = RGB(255, 255, 255);
        _videoSlider.maximumTrackTintColor = RGBWithAlpha(0.3, 0.3, 0.3, 0.6);
    }
    return _videoSlider;
}

- (UILabel *)totalTimeLabel {
    if(!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:12.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

- (UIButton *)fullScreenBtn {
    if(!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"kr-video-player-shrinkscreen"] forState:UIControlStateSelected];
    }
    return _fullScreenBtn;
}

- (UILabel *)horizontalLabel {
    if(!_horizontalLabel) {
        _horizontalLabel = [[UILabel alloc] init];
        _horizontalLabel.textColor = [UIColor whiteColor];
        _horizontalLabel.textAlignment = NSTextAlignmentCenter;
        //设置快进快退label
        _horizontalLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Management_Mask"]];
    }
    return _horizontalLabel;
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activity;
}

- (UIButton *)repeatBtn
{
    if (!_repeatBtn) {
        _repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repeatBtn setImage:[UIImage imageNamed:@"repeat_video"] forState:UIControlStateNormal];
    }
    return _repeatBtn;
}

- (UIButton *)downLoadBtn
{
    if (!_downLoadBtn) {
        _downLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downLoadBtn setImage:[UIImage imageNamed:@"player_downLoad"] forState:UIControlStateNormal];
        [_downLoadBtn setImage:[UIImage imageNamed:@"player_not_downLoad"] forState:UIControlStateDisabled];
    }
    return _downLoadBtn;
}

@end
