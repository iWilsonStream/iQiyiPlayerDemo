//
//  Config.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kTitleFont  [UIFont boldSystemFontOfSize:15.f]
#define kContentFont [UIFont fontWithName:@"Arial" size:13.f]
#define kMinFont     [UIFont fontWithName:@"Arial" size:11.f]
#define kTitleTextColor [UIColor blackColor]
#define kDefaultColor RGB(168, 167, 185)
#define kLightGrayColor RGB(235,235,241)
#define kGreenColor RGB(27,181,9)

typedef void (^configureCellBlock) (id item, id cell, NSUInteger indexRow);
//typedef void (^cascadeConfigureCellBlock);

#endif /* Config_h */
