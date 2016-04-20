//
//  PlayerSubviewsConsole.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/20.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSubviewsConsole : UIView

/** 开始播放按钮 **/
@property (nonatomic, strong, readonly) UIButton * startBtn;
/** 当前播放时长label **/
@property (nonatomic, strong, readonly) UILabel  * currentTimeLabel;
/** 视频总时长label **/
@property (nonatomic, strong, readonly) UILabel  * totalTimeLabel;
/** 缓冲进度条 **/
@property (nonatomic, strong, readonly) UIProgressView * progressView;
/** 滑杆 **/
@property (nonatomic, strong, readonly) UISlider * videoSlider;
/** 全屏按钮 **/
@property (nonatomic, strong, readonly) UIButton * fullScreenBtn;
/** 锁定屏幕方向按钮 **/
@property (nonatomic, strong, readonly) UIButton * lockBtn;
/** 快进快退label **/
@property (nonatomic, strong, readonly) UILabel  * horizontalLabel;
/** 系统菊花 **/
@property (nonatomic, strong, readonly) UIActivityIndicatorView * activity;
/** 返回按钮 **/
@property (nonatomic, strong, readonly) UIButton * backBtn;
/** 重播按钮 **/
@property (nonatomic, strong, readonly) UIButton * repeatBtn;
/** bottomView **/
@property (nonatomic, strong, readonly) UIImageView * bottomImageView;
/** topView **/
@property (nonatomic, strong, readonly) UIImageView * topImageView;
/** 缓存按钮 **/
@property (nonatomic, strong, readonly) UIButton * downLoadBtn;

/** 重置ControlView **/
- (void) resetConsoleView;
/** 显示Top、bottom、lockBtn **/
- (void) showConsoleView;
/** 隐藏Top、bottom、lockBtn **/
- (void) hideConsoleView;

@end
