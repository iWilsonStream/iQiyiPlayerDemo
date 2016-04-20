//
//  Config.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#ifndef Config_h
#define Config_h

//current mode size
#define ModelSize [[UIScreen mainScreen] currentMode].size
//judge current mode
#define CurrMode [UIScreen instancesRespondToSelector:@selector(currentMode)]
//iphone4/4s
#define iPhone4_4S (CurrMode? CGSizeEqualToSize(CGSizeMake(640, 960), ModelSize) : NO)
//iphone5/5s/5c
#define iPhone5_5S_5C (CurrMode? CGSizeEqualToSize(CGSizeMake(640, 1136), ModelSize) : NO)
//iphone6/6s
#define iPhone6_6S (CurrMode? CGSizeEqualToSize(CGSizeMake(750, 1334), ModelSize) : NO)
//iphone6plus/iphone6sPlus
#define iPhone6plus_6Splus (CurrMode? CGSizeEqualToSize(CGSizeMake(1242, 2208), ModelSize) : NO)
//iphone6放大模式
#define iPhone6ZoomMode (CurrMode?CGSizeEqualToSize(CGSizeMake(640, 1136),ModelSize):NO)
//iphone6plus放大模式
#define iPhone6plusZoomMode (CurrMode? CGSizeEqualToSize(CGSizeMake(1125, 2001),ModelSize):NO)
//RGB
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//RGB with alpha
#define RGBWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//ScreenSize
#define kScreenSize [UIScreen mainScreen].bounds.size
//Title grade font
#define kTitleFont  [UIFont boldSystemFontOfSize:15.f]
//content grade font
#define kContentFont [UIFont fontWithName:@"Arial" size:13.f]
//minum font
#define kMinFont     [UIFont fontWithName:@"Arial" size:11.f]
//title grade color
#define kTitleTextColor [UIColor blackColor]
//default color
#define kDefaultColor RGB(168, 167, 185)
//light gray color
#define kLightGrayColor RGB(235,235,241)
//green color
#define kGreenColor RGB(27,181,9)
//cell selected view background color
#define kCellSelectedViewBackgroundColor RGB(249, 249, 249)
//standard img widht
#define kStandardImgWidth iPhone6plus_6Splus ? 165 : ((iPhone6_6S || iPhone6plusZoomMode)? 145 : 120)

//帮助方法宏定义
#define Help [kHelp shareInstance]

typedef void (^configureCellBlock) (id item, id cell, NSUInteger indexRow);
//typedef void (^cascadeConfigureCellBlock);

#endif /* Config_h */
