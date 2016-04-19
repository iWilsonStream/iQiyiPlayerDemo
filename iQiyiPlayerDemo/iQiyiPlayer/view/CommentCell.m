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
        UIView * selectedView = [UIView new];
        selectedView.backgroundColor = kCellSelectedViewBackgroundColor;
        self.selectedBackgroundView = selectedView;
        [self layoutAllSubvies:object];
    }
    return self;
}

- (void) setLayoutObject:(CommentLayoutObject *)layoutObject {
    _layoutObject = layoutObject;
    
    _headIcon.image = [UIImage imageNamed:_layoutObject.object.usericon];
    _userNameLabl.text = _layoutObject.object.username;
    _contentLabl.text = _layoutObject.object.content;
    _sendDate.text = _layoutObject.object.send_date;
    _praiseLabl.text = _layoutObject.object.praise_count;
}

- (void) layoutAllSubvies:(CommentLayoutObject *)object {
    //1.头像
    _headIcon = [[UIImageView alloc] initWithFrame:object.iconRect];
    _headIcon.image = [UIImage imageNamed:object.object.usericon];
    _headIcon.layer.cornerRadius = kUserIconSize.width / 2;
    _headIcon.clipsToBounds = YES;
    [self.contentView addSubview:_headIcon];
    
    //2.用户名称
    _userNameLabl = [[UILabel alloc] init];
    [_userNameLabl setFrame:object.userNameRect];
    _userNameLabl.text = object.object.username;
    _userNameLabl.font = kContentFont;
    _userNameLabl.textColor = kDefaultColor;
    _userNameLabl.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_userNameLabl];
    
    //3.内容
    _contentLabl = [[UILabel alloc] init];
    [_contentLabl setFrame:object.contentRect];
    _contentLabl.text = object.object.content;
    _contentLabl.textColor = kTitleTextColor;
    _contentLabl.font = kContentFont;
    _contentLabl.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_contentLabl];
    
    //4.发布时间
    _sendDate = [[UILabel alloc] init];
    [_sendDate setFrame:object.sendDateRect];
    _sendDate.text = object.object.send_date;
    _sendDate.textColor = kDefaultColor;
    _sendDate.font = kMinFont;
    _sendDate.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_sendDate];
    
    //5.点赞label
    _praiseLabl = [[UILabel alloc] init];
    [_praiseLabl setFrame:object.praiseLablRect];
    _praiseLabl.text = object.object.praise_count;
    _praiseLabl.textColor = kDefaultColor;
    _praiseLabl.font = kMinFont;
    _praiseLabl.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_praiseLabl];
    
    //6.点赞按钮
    _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praiseBtn setFrame:object.praiseBtnRect];
    [_praiseBtn setImage:[UIImage imageNamed:@"comment_unlike_p"] forState:UIControlStateNormal];
    [self.contentView addSubview:_praiseBtn];
    
    //7.评论按钮
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentBtn setFrame:object.commentBtnRect];
    [_commentBtn setImage:[UIImage imageNamed:@"comment_reply_p"] forState:UIControlStateNormal];
    [self.contentView addSubview:_commentBtn];
}

@end
