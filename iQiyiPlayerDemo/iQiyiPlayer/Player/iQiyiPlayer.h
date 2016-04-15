//
//  iQiyiPlayer.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <UIKit/UIKit.h>

// 放回按钮回调函数
typedef void (^PlayerBackwardBlock)(void);

// playerLayer填充模式
typedef NS_ENUM(NSInteger, PlayerLayerGravityMode) {
    PlayerLayerGravityModeResize,          //非均匀模式。两个维度完全填充至整个视图区域
    PlayerLayerGravityModeResizeAspect,    //等比例填充，直到一个维度达到视图区域边界
    PlayerLayerGravityModeResizeAspectFill //等比例填充，直到填充满整个视图区域，其中一个维度的部分区域将被裁减
};

@interface iQiyiPlayer : UIView

@property (nonatomic, strong) NSURL * videoURL;
@property (nonatomic, copy) PlayerBackwardBlock backBlock;
@property (nonatomic, assign) PlayerLayerGravityMode playerLayerGravityMode;
@property (nonatomic, assign) BOOL hasDownload;
@property (nonatomic, assign) NSInteger seekTime;

/**
 *  取消延时隐藏controlView的方法,在ViewController的delloc方法中调用
 *  用于解决：刚打开视频播放器，就关闭该页面，maskView的延时隐藏还未执行。
 */
- (void)cancelAutoFadeOutControlBar;

/**
 *  单例，用于列表cell上多个视频
 *
 *  @return ZFPlayer
 */
+ (instancetype)sharedPlayerView;

/**
 *  重置player
 */
- (void)resetPlayer;

/**
 *  在当前页面，设置新的Player的URL调用此方法
 */
- (void)resetToPlayNewURL;

/**
 *  播放
 */
- (void)play;

/**
 * 暂停
 */
- (void)pause;

@end
