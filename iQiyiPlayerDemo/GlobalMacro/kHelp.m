//
//  kHelp.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/19.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "kHelp.h"

@implementation kHelp

+ (instancetype)shareInstance {
    static kHelp * help = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        help = [[kHelp alloc] init];
    });
    return help;
}

//根据自定义约束size，简单计算文本高度
-(CGRect)calculateText:(NSString *)text withConstraintSize:(CGSize)constraintSize font:(UIFont *)font {
    
    CGRect rect;
    if(text && [text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        rect = [text boundingRectWithSize:constraintSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:0];
    } else {
        
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        rect.size   = size;
        
    }
    return rect;
}

@end
