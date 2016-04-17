//
//  SecondSectionCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "SecondSectionCell.h"

@interface SecondSectionCell ()

//内容图标
@property (nonatomic, strong) UIImageView * icon;
//内容名称
@property (nonatomic, strong) UILabel * nameLabl;
//内容
@property (nonatomic, strong) UILabel * contentLabl;
//下载按钮
@property (nonatomic, strong) UIButton * downloadBtn;
//全文标题
@property (nonatomic, strong) UILabel * titleLabl;
//评分
@property (nonatomic, strong) UILabel * scoreLabl;
//显示全文按钮
@property (nonatomic, strong) UIButton * showBtn;
//导演
@property (nonatomic, strong) UILabel * directorLabl;
//上映时间
@property (nonatomic, strong) UILabel * screenDateLabl;
//主演
@property (nonatomic, strong) UILabel * protagonistLabl;
//详情描述
@property (nonatomic, strong) UILabel * descriptionLabl;
//点赞
@property (nonatomic, strong) UIButton * praiseBtn;
//取消赞
@property (nonatomic, strong) UIButton * depraiseBtn;

@end

@implementation SecondSectionCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void) layoutAllSubviews {
    //1.内容图标
    UIImageView * icon = [UIImageView new];
    icon.layer.contents = (id)[UIImage imageNamed:@""].CGImage;
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.icon = icon;
    
    //2.内容名称
    UILabel * name = [UILabel new];
    name.backgroundColor = [UIColor clearColor];
    name.font = kTitleFont;
    name.textColor = kTitleTextColor;
    name.text = @"灵域";
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.nameLabl = name;
    
    //3.内容
    UILabel * content = [UILabel new];
    content.backgroundColor = [UIColor clearColor];
    content.font = kContentFont;
    content.textColor = kDefaultColor;
    content.text = @"小说动漫授权手游";
    [self.contentView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.contentLabl = content;
    
    //4.下载按钮
    UIButton * downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.contentView addSubview:downloadBtn];
    [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.downloadBtn = downloadBtn;
    
    //5.分割线
    UIView * lineBreak = [UIView new];
    lineBreak.backgroundColor = kDefaultColor;
    [self.contentView addSubview:lineBreak];
    [lineBreak mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    //6.内容标题
    UILabel * titleLabl = [UILabel new];
    titleLabl.backgroundColor = [UIColor clearColor];
    titleLabl.font = kTitleFont;
    titleLabl.textColor = kTitleTextColor;
    titleLabl.text = @"阴阳先生之末代天师";
    [self.contentView addSubview:titleLabl];
    [titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.titleLabl = titleLabl;
    
    //7.评分
    UILabel * scoreLabl = [UILabel new];
    scoreLabl.backgroundColor = [UIColor clearColor];
    scoreLabl.font = kContentFont;
    scoreLabl.textColor = kDefaultColor;
    scoreLabl.text = @"评分: 7.5";
    [self.contentView addSubview:scoreLabl];
    [scoreLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.scoreLabl = scoreLabl;
    
    //8.显示全文按钮
    UIButton * showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.contentView addSubview:showBtn];
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.showBtn = showBtn;
    
    //9.上映时间
    //10.导演
    //11.主演
    //12.描述
    UILabel * descLabl = [UILabel new];
    descLabl.backgroundColor = [UIColor clearColor];
    descLabl.font = kContentFont;
    descLabl.textColor = kDefaultColor;
    descLabl.text = @"影片简介: 军阀年间，硝烟四起。秋生、文才、阿龙三人同是九叔的徒弟，九叔仙逝后又逢乱世，三人为谋生计各立门户。而后，镇子一夜变尸城，三人齐力灭掉金甲干尸，他们把甘宝和师傅留下的茅山道术秘籍藏到隐蔽处后，把尸群引导一栋木楼中，点燃了炸药包...";
    [self.contentView addSubview:scoreLabl];
    [descLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    self.descriptionLabl = descLabl;
    
    //13.点赞、取消赞控件
    
}

@end
