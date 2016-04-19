//
//  CommentCell.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/18.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "CommentCell.h"
#import "ReplyListTableView.h"

@interface CommentCell ()

//用户头像
@property (nonatomic, strong) UIImageView * headIcon;
//用户名
@property (nonatomic, strong) UILabel * userNameLabl;
//评论内容
@property (nonatomic, strong) UILabel * contentLabl;
//回复列表
@property (nonatomic, strong) ReplyListTableView * replyTableView;
//发送时间
@property (nonatomic, strong) UILabel * sendDate;
//点赞按钮
@property (nonatomic, strong) UIButton * praiseBtn;
//统计点赞的labl
@property (nonatomic, strong) UILabel * praiseLabl;
//评论按钮
@property (nonatomic, strong) UIButton * commentBtn;

@end

@implementation CommentCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier object:(CommentLayoutObject *)object {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void) setLayoutObject:(CommentLayoutObject *)layoutObject {
    _layoutObject = layoutObject;
}


@end
