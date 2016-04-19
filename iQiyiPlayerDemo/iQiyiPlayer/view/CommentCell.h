//
//  CommentCell.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentLayoutObject.h"

@interface CommentCell : UITableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier object:(CommentLayoutObject *)object;

@property (nonatomic, strong) CommentLayoutObject * layoutObject;

@end
