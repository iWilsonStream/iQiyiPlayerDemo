//
//  ThirdSectionCell.h
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/17.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailCell.h"
#import "PlayerDetailFilmListModel.h"

@interface ThirdSectionCell : PlayerDetailCell

- (void) configureFilmCellWithModel:(PlayerDetailFilmListModel *)model;

@end

