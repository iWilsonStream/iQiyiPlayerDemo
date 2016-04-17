//
//  ThirdSectionCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "ThirdSectionCell.h"

@interface ThirdSectionCell ()

//封面图片
@property (nonatomic, strong) UIImageView * coverImg;
//视频标题
@property (nonatomic, strong) UILabel * titlelabl;
//视频简介
@property (nonatomic, strong) UILabel * contentlabl;
//视频播放次数
@property (nonatomic, strong) UILabel * playRecord;
//视频播放按钮
@property (nonatomic, strong) UIButton * playBtn;
//视频标签（VIP\1080P\normal）
@property (nonatomic, strong) UIImageView * filmFlag;

@end

@implementation ThirdSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void) layoutAllSubviews {
    __weak typeof (self)weakSelf = self;
//    NSLog(@"kStandardImgSize.height --- %f",kStandardImgSize.height);
    //1.封面图片
    UIImageView * coverimg = [UIImageView new];
    [self.contentView addSubview:coverimg];
    CGFloat standarImgWidth = kStandardImgWidth;
    [coverimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(standarImgWidth, standarImgWidth / 1.5));
    }];
    self.coverImg = coverimg;
    
    //2.视频标题
    UILabel * filmTitle = [UILabel new];
    filmTitle.backgroundColor = [UIColor clearColor];
    filmTitle.font = kTitleFont;
    filmTitle.textColor = kTitleTextColor;
//    filmTitle.text = @"阴阳先生之末代天师";
    [self.contentView addSubview:filmTitle];
    [filmTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.coverImg.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    self.titlelabl = filmTitle;
    
    //3.视频简介
    UILabel * contentLabl = [UILabel new];
    contentLabl.backgroundColor = [UIColor clearColor];
    contentLabl.font = kContentFont;
    contentLabl.textColor = kDefaultColor;
//    contentLabl.text = @"阴阳先生之末代天师";
    [self.contentView addSubview:contentLabl];
    [contentLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.coverImg.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.titlelabl.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    self.contentlabl = contentLabl;
    
    //4.视频播放次数
    UILabel * playRecord = [UILabel new];
    playRecord.backgroundColor = [UIColor clearColor];
    playRecord.font = kContentFont;
    playRecord.textColor = kDefaultColor;
//    playRecord.text = @"阴阳先生之末代天师";
    [self.contentView addSubview:playRecord];
    [playRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.coverImg.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.contentlabl.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    self.playRecord = playRecord;
    
    //5.视频播放按钮
    //6.视频标签
}

- (void)configureFilmCellWithModel:(PlayerDetailFilmListModel *)model {
//    self.coverImg.layer.contents = (id)[UIImage imageNamed:model.coverURL].CGImage;
    self.coverImg.image = [UIImage imageNamed:model.coverURL];
    self.titlelabl.text = model.name;
    self.contentlabl.text = model.content;
    self.playRecord.text = model.playRecord;
}

@end
