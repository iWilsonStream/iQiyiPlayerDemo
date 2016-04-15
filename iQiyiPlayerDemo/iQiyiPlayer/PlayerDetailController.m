//
//  PlayerDetailController.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PlayerDetailController.h"

@interface PlayerDetailController ()

@property (nonatomic, strong) iQiyiPlayer * player;

@end

@implementation PlayerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPlayer];
}

- (void)setupPlayer {
    self.player = [[iQiyiPlayer alloc] init];
    [self.view addSubview:self.player];
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        //注意此处，宽高比16:9优先级比1000低就行
        make.height.equalTo(self.player.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    self.player.videoURL = self.videoURL;
    self.player.playerLayerGravityMode = PlayerLayerGravityModeResizeAspect;
    
    //如果想从xx秒开始播放视频
//    self.player.seekTime = 15;
    __weak typeof(self)weakSelf = self;
    self.player.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

@end
