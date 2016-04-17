//
//  FirstSectionCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "FirstSectionCell.h"

@interface FirstSectionCell ()

//播放按钮
@property (nonatomic, strong) UIImageView * playIcon;
//播放次数
@property (nonatomic, strong) UILabel * recordLabl;
//分享按钮
@property (nonatomic, strong) UIButton * shareBtn;
//缓存按钮
@property (nonatomic, strong) UIButton * downloadBtn;

@end

@implementation FirstSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void)layoutAllSubviews {
    __weak typeof(self) weakSelf = self;
    //播放按钮
    UIImageView * playIcon = [UIImageView new];
    playIcon.image = [UIImage imageNamed:@"mini_ic_play_on"];
    [self.contentView addSubview:playIcon];
    [playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    self.playIcon = playIcon;
   
    
    //播放次数
    UILabel * recordLabl = [UILabel new];
    recordLabl.text = @"1053.5万次播放";
    recordLabl.font = kContentFont;
    recordLabl.textColor = kTitleTextColor;
    recordLabl.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:recordLabl];
    [recordLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(playIcon.mas_right).offset(10);
        make.top.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    self.recordLabl = recordLabl;
    
    //分享按钮
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"mini_share"] forState:UIControlStateNormal];
    [self.contentView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(@5);
        make.width.height.mas_equalTo(@30);
    }];
    self.shareBtn = shareBtn;
    
    //下载按钮
    UIButton * download = [UIButton buttonWithType:UIButtonTypeCustom];
    [download setImage:[UIImage imageNamed:@"home_titleBar_offline"] forState:UIControlStateNormal];
    [download setTitle:@"下载" forState:UIControlStateNormal];
    [download.titleLabel setFont:kMinFont];
    [download setTitleColor:kDefaultColor forState:UIControlStateNormal];
    [self.contentView addSubview:download];
    [download mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.shareBtn.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    self.downloadBtn = download;
    
    //分割线
    UIView * line = [UIView new];
    line.backgroundColor = kLightGrayColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.left.mas_equalTo(weakSelf.shareBtn.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
}

@end
