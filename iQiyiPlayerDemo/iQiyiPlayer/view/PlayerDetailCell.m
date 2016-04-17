//
//  PlayerDetailCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PlayerDetailCell.h"

@implementation PlayerDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        UIView * view = [UIView new];
//        view.backgroundColor = [UIColor clearColor];
//        self.backgroundView = view;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [UIColor clearColor].CGColor);
    CGContextFillRect(contextRef, rect);//上分割线
    CGContextSetStrokeColorWithColor(contextRef, kLightGrayColor.CGColor);
    CGContextStrokeRect(contextRef, CGRectMake(5, -1, rect.size.width - 10, 1));//下分割线
    CGContextSetStrokeColorWithColor(contextRef, kLightGrayColor.CGColor);
    CGContextStrokeRect(contextRef, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}

@end
