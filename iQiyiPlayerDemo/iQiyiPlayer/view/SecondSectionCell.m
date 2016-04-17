//
//  SecondSectionCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "SecondSectionCell.h"
#import "PraiseConsole.h"

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
//评论控件（点赞、差评）
@property (nonatomic, strong) PraiseConsole * praiseConsole;

@end

@implementation SecondSectionCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void) layoutAllSubviews {
    __weak typeof (self)weakSelf = self;
    //1.内容图标
    UIImageView * icon = [UIImageView new];
    icon.layer.contents = (id)[UIImage imageNamed:@"icon"].CGImage;
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(56, 56));
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
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(15);
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
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
        make.top.mas_equalTo(weakSelf.nameLabl.mas_bottom).offset(5);
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    self.contentLabl = content;
    
    //4.下载按钮
    UIButton * downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn setBackgroundColor:kGreenColor];
    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downloadBtn.titleLabel setFont:kTitleFont];
    [downloadBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [self.contentView addSubview:downloadBtn];
    [downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    self.downloadBtn = downloadBtn;
    
    //5.分割线
    UIView * lineBreak = [UIView new];
    lineBreak.backgroundColor = kLightGrayColor;
    [self.contentView addSubview:lineBreak];
    [lineBreak mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.icon.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenSize.width, 0.5));
    }];
    
    //6.内容标题
    UILabel * titleLabl = [UILabel new];
    titleLabl.backgroundColor = [UIColor clearColor];
    titleLabl.font = kTitleFont;
    titleLabl.textColor = kTitleTextColor;
    titleLabl.text = @"阴阳先生之末代天师";
    [self.contentView addSubview:titleLabl];
    [titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.icon.mas_left);
        make.top.mas_equalTo(lineBreak.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
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
        make.left.mas_equalTo(weakSelf.icon.mas_left);
        make.top.mas_equalTo(weakSelf.titleLabl.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    self.scoreLabl = scoreLabl;
    
    //8.显示全文按钮
    UIButton * showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showBtn setImage:[UIImage imageNamed:@"offline_clarity_black_down_iphone"] forState:UIControlStateNormal];
    [self.contentView addSubview:showBtn];
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(lineBreak.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    self.showBtn = showBtn;
    
/**************** 以下内容默认隐藏 *******************/
    //9.上映时间
//    UILabel * screenDate = [UILabel new];
//    screenDate.backgroundColor = [UIColor clearColor];
//    screenDate.font = kContentFont;
//    screenDate.textColor = kDefaultColor;
//    screenDate.text = @"上映时间: 2016";
//    [self.contentView addSubview:screenDate];
//    [screenDate mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.screenDateLabl = screenDate;
//    
//    //10.导演
//    UILabel * directorLabl = [UILabel new];
//    directorLabl.backgroundColor = [UIColor clearColor];
//    directorLabl.font = kContentFont;
//    directorLabl.textColor = kDefaultColor;
//    directorLabl.text = @"导演: 张涛";
//    [self.contentView addSubview:directorLabl];
//    [directorLabl mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.directorLabl = directorLabl;
//    
//    //11.主演
//    UILabel * protagonistLabl = [UILabel new];
//    protagonistLabl.backgroundColor = [UIColor clearColor];
//    protagonistLabl.font = kContentFont;
//    protagonistLabl.textColor = kDefaultColor;
//    protagonistLabl.text = @"主演: 钱小豪 楼南光 彭禹";
//    [self.contentView addSubview:directorLabl];
//    [protagonistLabl mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.protagonistLabl = protagonistLabl;
//    
//    //12.描述
//    UILabel * descLabl = [UILabel new];
//    descLabl.backgroundColor = [UIColor clearColor];
//    descLabl.font = kContentFont;
//    descLabl.textColor = kDefaultColor;
//    descLabl.text = @"影片简介: 军阀年间，硝烟四起。秋生、文才、阿龙三人同是九叔的徒弟，九叔仙逝后又逢乱世，三人为谋生计各立门户。而后，镇子一夜变尸城，三人齐力灭掉金甲干尸，他们把甘宝和师傅留下的茅山道术秘籍藏到隐蔽处后，把尸群引导一栋木楼中，点燃了炸药包...";
//    [self.contentView addSubview:scoreLabl];
//    [descLabl mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.descriptionLabl = descLabl;
//    
//    //13.点赞、取消赞控件
//    PraiseConsole * praise = [PraiseConsole new];
//    [self.contentView addSubview:praise];
//    [praise mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//    self.praiseConsole = praise;
}

@end
