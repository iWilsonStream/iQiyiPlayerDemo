//
//  ReplyListModel.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "BaseModel.h"

@interface ReplyListModel : BaseModel

//回复内容
@property (nonatomic, strong) NSString * reply_content;
//回复时间
@property (nonatomic, strong) NSString * send_date;
//用户头像
@property (nonatomic, strong) NSString * usericon;
//用户名称
@property (nonatomic, strong) NSString * username;

@end
