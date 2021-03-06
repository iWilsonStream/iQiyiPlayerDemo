//
//  CommentModel.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "BaseModel.h"

@interface CommentModel : BaseModel

//评论内容
@property (nonatomic, strong) NSString * content;
//点赞数目
@property (nonatomic, strong) NSString * praise_count;
//发送时间
@property (nonatomic, strong) NSString * send_date;
//用户头像路径
@property (nonatomic, strong) NSString * usericon;
//用户名称
@property (nonatomic, strong) NSString * username;
//回复列表数据
@property (nonatomic, strong) NSArray  * replylist;

@end
