//
//  CommentLayoutObject.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "CommentLayoutObject.h"

@implementation CommentLayoutObject

- (instancetype)initWithObject:(CommentModel *)object {
    if(!object) return nil;
    self = [super init];
    _object = object;
    [self layout];
    return self;
}

- (void) layout {

}

@end
