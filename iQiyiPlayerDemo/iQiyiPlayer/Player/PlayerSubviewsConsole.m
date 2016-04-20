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

}

- (void) resetConsoleView {
    
}

- (void) showConsoleView {

}

- (void) hideConsoleView {

}

#pragma mark - getter
- (UIButton *)backBtn {
    if(!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UIImageView *)topImageView {
    if(!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.image = [UIImage imageNamed:@""];
    }
    return _topImageView;
}

- (UIImageView *)bottomImageView {
    if(!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.userInteractionEnabled = YES;
        _bottomImageView.image = [UIImage imageNamed:@""];
    }
    return _bottomImageView;
}

- (UIButton *)lockBtn {
    if(!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_lockBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    }
    return _lockBtn;
}

- (UIButton *)startBtn {
    if(!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
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
        [_fullScreenBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_fullScreenBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    }
    return _fullScreenBtn;
}

- (UILabel *)horizontalLabel {
    if(!_horizontalLabel) {
        _horizontalLabel = [[UILabel alloc] init];
        _horizontalLabel.textColor = [UIColor whiteColor];
        _horizontalLabel.textAlignment = NSTextAlignmentCenter;
        //设置快进快退label
        _horizontalLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
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
        [_repeatBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _repeatBtn;
}

- (UIButton *)downLoadBtn
{
    if (!_downLoadBtn) {
        _downLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downLoadBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_downLoadBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateDisabled];
    }
    return _downLoadBtn;
}

@end
