//
//  BaseModel.m
//  CloudStudy
//
//  Created by zhiminglantai on 14-4-10.
//  Copyright (c) 2014年 ZXY. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)init {
    if(self = [super init]) {
        
    }
    return self;
}

//源数据为字典，执行set方法
- (void) parseDictionary:(NSDictionary*)dicData;
{
    NSArray *keys = [dicData allKeys];
    
    for (NSString * parmeValue in keys) {
        //首字母大写
        NSString *firstStr = [[parmeValue substringToIndex:1] capitalizedString];
        NSString *lastStr = [parmeValue substringFromIndex:1];
        NSString *capStr = [NSString stringWithFormat:@"%@%@",firstStr,lastStr];
        
        //是否存在此属性
        NSString *selectString = [NSString stringWithFormat:@"set%@:",capStr];
        SEL selector = NSSelectorFromString(selectString);
        if ([self respondsToSelector:selector]) {
            //执行set方法
            NSObject *dicValue = [dicData objectForKey:parmeValue];
            if ([dicValue isKindOfClass:[NSNull class]]) {
                dicValue = @"";
            }
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:dicValue];
#pragma clang diagnostic pop
        }
    }
}

-(void)offLineDictionart:(NSDictionary *)dicData
{
    
}
@end
