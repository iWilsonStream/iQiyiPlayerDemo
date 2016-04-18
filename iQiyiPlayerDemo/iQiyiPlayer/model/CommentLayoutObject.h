//
//  CommentLayoutObject.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//


#import "CommentModel.h"

@interface CommentLayoutObject : NSObject

//一条评论数据(包含了用户头像、用户名、评论内容、回复列表内容等信息)
@property (nonatomic, strong) CommentModel * commentObject;



@end
