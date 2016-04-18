//
//  FithSectionCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "FithSectionCell.h"

@interface FithSectionCell ()

//分类名称
@property (nonatomic, strong) UILabel * categoryNameLabl;
//内容图标
@property (nonatomic, strong) UIImageView * iconImg;
//内容标题
@property (nonatomic, strong) UILabel * titleLabl;
//内容
@property (nonatomic, strong) UILabel * contentLabl;
//内容标签1
@property (nonatomic, strong) UIImageView * flag1;
//内容标签2
@property (nonatomic, strong) UIImageView * flag2;
//作者
@property (nonatomic, strong) UILabel * author;
//立即阅读按钮
@property (nonatomic, strong) UIButton * readBtn;
//更多按钮
@property (nonatomic, strong) UIButton * moreBtn;

@end

@implementation FithSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void) layoutAllSubviews {
    __weak typeof(self)weakSelf = self;
    //1.分类名称
    UILabel * categoryName = [UILabel new];
    categoryName.text = @"爱奇艺文学";
    categoryName.font = kContentFont;
    categoryName.textColor = kTitleTextColor;
    categoryName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:categoryName];
    [categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(weakSelf.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    self.categoryNameLabl = categoryName;
    
    //2.内容图标
    UIImageView * iconImg = [UIImageView new];
    iconImg.image = [UIImage imageNamed:@"icon2.png"];
    [self.contentView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.categoryNameLabl.mas_bottom);
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(57, 74));
    }];
    self.iconImg = iconImg;
    
    
    //3.内容标题
    UILabel * titleLabl = [UILabel new];
    titleLabl.text = @"TFBoys之吃定王俊凯";
    titleLabl.font = kTitleFont;
    titleLabl.textColor = kTitleTextColor;
    titleLabl.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:titleLabl];
    [titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconImg.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.iconImg.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    self.titleLabl = titleLabl;
    
    //8.立即阅读按钮
    UIButton * readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [readBtn setBackgroundColor:kGreenColor];
    [readBtn setTitle:@"立即阅读" forState:UIControlStateNormal];
    [readBtn.titleLabel setFont:kContentFont];
    [readBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [self.contentView addSubview:readBtn];
    [readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-5);
        make.top.mas_equalTo(weakSelf.titleLabl.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    self.readBtn = readBtn;
    
    //4.内容
    UILabel * contentLabl = [UILabel new];
    contentLabl.text = @"开学的第一天，他就得到了一个爆炸...";
    contentLabl.font = kContentFont;
    contentLabl.textColor = kDefaultColor;
    contentLabl.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:contentLabl];
    [contentLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabl.mas_left);
        make.top.mas_equalTo(weakSelf.titleLabl.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.readBtn.mas_left).offset(-5);
    }];
    self.contentLabl = contentLabl;
    
    //5.内容标签1
//    UIImageView * flag1 = [UIImageView new];
//    flag1.image = [UIImage imageNamed:@""];
//    [self.contentView addSubview:flag1];
//    [flag1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.flag1 = flag1;
//    
//    //6.内容标签2
//    UIImageView * flag2 = [UIImageView new];
//    flag2.image = [UIImage imageNamed:@""];
//    [self.contentView addSubview:flag2];
//    [flag2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.flag2 = flag2;
//    
//    //7.作者
//    UILabel * author = [UILabel new];
//    author.text = @"开学的第一天，他就得到了一个爆炸...";
//    author.font = kTitleFont;
//    author.textColor = kTitleTextColor;
//    author.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:author];
//    [author mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.author = author;
    
    //9.更多按钮
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundColor:RGB(255, 255, 255)];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:kContentFont];
    [moreBtn setTitleColor:RGB(89, 89, 89) forState:UIControlStateNormal];
    [self.contentView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(weakSelf.categoryNameLabl.mas_top);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    self.moreBtn = moreBtn;
}

@end
