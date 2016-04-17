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

typedef void (^configureCellBlock) (id item, id cell, NSUInteger indexRow);
//typedef void (^cascadeConfigureCellBlock);

#endif /* Config_h */
