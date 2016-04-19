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
    _rects  = [NSMutableArray array];
    _cellHeight = 0;
    [self layout];
    return self;
}

- (void) layout {
    //1.评论内容
    [self layoutCommentConsole];
    //2.回复列表内容
    [self layoutReplyConsole];
    //3.计算cell的总高度
    [self calculateCellHeight];
}

- (void) layoutCommentConsole {
    //1.头像rect
    _iconRect = CGRectMake(10, 10, kUserIconSize.width, kUserIconSize.height);
    
    //2.用户名rect
    _userNameRect = CGRectMake(CGRectGetMaxX(_iconRect) + 20, CGRectGetMinY(_iconRect), kUserNameSize.width, kUserNameSize.height);
    
    //3.内容rect
    CGRect calculateRect = [Help calculateText:_object.content withConstraintSize:CGSizeMake(kContentWidth, MAXFLOAT) font:kContentFont];
    _contentRect = CGRectMake(CGRectGetMinX(_userNameRect), CGRectGetMaxY(_userNameRect), kContentWidth, calculateRect.size.height);
    
    //4.发布时间
    _sendDateRect = CGRectMake(CGRectGetMinX(_userNameRect), CGRectGetMaxY(_contentRect), kSendDateSize.width, kSendDateSize.height);
    
    //5.评论按钮
    CGFloat commentBtnWidth = kCommentBtnSize.width;
    _commentBtnRect = CGRectMake(kScreenSize.width - 30 - commentBtnWidth, CGRectGetMinY(_sendDateRect), kCommentBtnSize.width, kCommentBtnSize.height);
    
    //6.点赞按钮Rect
    CGFloat praiseBtnWidth = kPraiseBtnSize.width;
    _praiseBtnRect = CGRectMake(CGRectGetMinX(_commentBtnRect) - praiseBtnWidth - 30, CGRectGetMinY(_commentBtnRect), kPraiseBtnSize.width, kPraiseBtnSize.height);
    
    //7.点赞label rect
    CGRect praiseCountRect = [Help calculateText:_object.praise_count withConstraintSize:CGSizeMake(120, MAXFLOAT) font:kMinFont];
    _praiseLablRect = CGRectMake(CGRectGetMinX(_praiseBtnRect) - praiseCountRect.size.width - 10, CGRectGetMinY(_praiseBtnRect), praiseCountRect.size.width, praiseCountRect.size.height);
}

- (void) layoutReplyConsole {

}

- (void) calculateCellHeight {
    _cellHeight = kTopPadding + kBottomPadding + _userNameRect.size.height + _contentRect.size.height + _sendDateRect.size.height;
}

@end
