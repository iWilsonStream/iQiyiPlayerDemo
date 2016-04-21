//
//  PlayerBrightnessView.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/20.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerBrightnessView : UIView

// 调用单例纪录播放状态是否锁定了屏幕方向
@property (nonatomic, assign) BOOL isLockScreen;
// cell上添加player的时候，不允许横屏，只运行竖屏状态
@property (nonatomic, assign) BOOL isAllowLandScape;

+ (instancetype) shareBrightnessView;

@end
