//
//  PraiseConsole.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PraiseConsole.h"

@interface PraiseConsole ()

//点赞按钮
@property (nonatomic, strong) UIButton * praiseBtn;
//差评按钮
@property (nonatomic, strong) UIButton * depraiseBtn;
//点赞人数
@property (nonatomic, strong) UILabel * praiseLabl;
//差评人数
@property (nonatomic, strong) UILabel * depraiseLabl;

@end

@implementation PraiseConsole

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self layoutAllSubviews];
    }
    return self;
}

- (void) layoutAllSubviews {
    __weak typeof(self) weakSelf = self;
    //1.点赞按钮
    UIButton * praise = [UIButton buttonWithType:UIButtonTypeCustom];
    [praise setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    [self addSubview:praise];
    [praise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    self.praiseBtn = praise;
    
    //2.点赞人数
    UILabel * praiseLabl = [UILabel new];
    praiseLabl.backgroundColor = [UIColor clearColor];
    praiseLabl.font = kMinFont;
    praiseLabl.textColor = kDefaultColor;
    praiseLabl.text = @"5.5万";
    [self addSubview:praiseLabl];
    [praiseLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.praiseBtn.mas_right).offset(5);
        make.top.mas_equalTo(weakSelf.mas_top).offset(2);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    self.praiseLabl = praiseLabl;
    
    //3.差评按钮
    UIButton * depraise = [UIButton buttonWithType:UIButtonTypeCustom];
    [depraise setImage:[UIImage imageNamed:@"depraise"] forState:UIControlStateNormal];
    [self addSubview:depraise];
    [depraise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.praiseLabl.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.praiseBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    self.depraiseBtn = depraise;
    
    //4.差评人数
    UILabel * depraiseLabl = [UILabel new];
    depraiseLabl.backgroundColor = [UIColor clearColor];
    depraiseLabl.font = kMinFont;
    depraiseLabl.textColor = kDefaultColor;
    depraiseLabl.text = @"2209";
    [self addSubview:depraiseLabl];
    [depraiseLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.depraiseBtn.mas_right).offset(5);
        make.top.mas_equalTo(weakSelf.mas_top).offset(2);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    self.depraiseLabl = depraiseLabl;
}

@end
