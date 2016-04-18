//
//  PlayerDetailFilmListModel.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface PlayerDetailFilmListModel : BaseModel

//封面图片路径
@property (nonatomic, strong) NSString * coverURL;
//电影标题
@property (nonatomic, strong) NSString * name;
//电影简介
@property (nonatomic, strong) NSString * content;
//播放记录
@property (nonatomic, strong) NSString * playRecord;

@end
