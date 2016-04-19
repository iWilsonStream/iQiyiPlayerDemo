//
//  kHelp.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/19.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface kHelp : NSObject
//单例构建
+ (instancetype)shareInstance;
//根据自定义约束size，简单计算文本高度
- (CGRect)calculateText:(NSString *)text
     withConstraintSize:(CGSize)constraintSize
                   font:(UIFont *)font;

@end
