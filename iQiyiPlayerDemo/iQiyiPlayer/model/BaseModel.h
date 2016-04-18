//
//  BaseModel.h
//  CloudStudy
//
//  Created by zhiminglantai on 14-4-10.
//  Copyright (c) 2014年 ZXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//源数据为字典，执行set方法
- (void) parseDictionary:(NSDictionary*)dicData;

-(void)offLineDictionart:(NSDictionary *)dicData;
@end
