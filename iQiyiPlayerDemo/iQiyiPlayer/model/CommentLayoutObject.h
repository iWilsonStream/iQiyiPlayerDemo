//
//  CommentLayoutObject.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//


#import "CommentModel.h"

@interface CommentLayoutObject : NSObject


#define kUserIconSize CGSizeMake(30,30)
#define kUserNameSize CGSizeMake(150,20)
#define kContentWidth iPhone6plus_6Splus ? 329 : ((iPhone6_6S || iPhone6plusZoomMode) ? 290 : 235)
#define kSendDateSize CGSizeMake(150,20)
#define kCommentBtnSize CGSizeMake(30,30)
#define kPraiseBtnSize  CGSizeMake(30,30)
#define kTopPadding 10
#define kBottomPadding 10


- (instancetype)initWithObject:(CommentModel *)object;

//一条评论数据(包含了用户头像、用户名、评论内容、回复列表内容等信息)
@property (nonatomic, strong) CommentModel * object;
//用于存放所有cell的布局对象
@property (nonatomic, strong) NSMutableArray * rects;
//用于存储本条cell的总高度
@property (nonatomic, assign) CGFloat cellHeight;


//头像rect
@property (nonatomic, assign) CGRect iconRect;
//用户名rect
@property (nonatomic, assign) CGRect userNameRect;
//内容rect
@property (nonatomic, assign) CGRect contentRect;
//发布时间rect
@property (nonatomic, assign) CGRect sendDateRect;
//点赞按钮rect
@property (nonatomic, assign) CGRect praiseBtnRect;
//点赞label Rect
@property (nonatomic, assign) CGRect praiseLablRect;
//评论button rect
@property (nonatomic, assign) CGRect commentBtnRect;
//回复列表rect
@property (nonatomic, assign) CGRect replyListRect;

//计算cell的总高度
- (void) calculateCellHeight;


@end
