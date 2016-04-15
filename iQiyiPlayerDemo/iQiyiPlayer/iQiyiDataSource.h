//
//  iQiyiDataSource.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iQiyiDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)items /*identifier:(NSString *)identifier configureCellBlock:(configureCellBlock)block*/;

@end
