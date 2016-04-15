//
//  PlayerDetailController.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PlayerDetailController.h"
#import "iQiyiDataSource.h"

@interface PlayerDetailController ()<UITableViewDelegate>

@property (nonatomic, strong) iQiyiPlayer * player;
@property (nonatomic, strong) iQiyiDataSource * dataSource;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation PlayerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPlayer];    //播放器
    [self setupTableView]; //设置tableView
}

- (void)setupPlayer {
    self.player = [[iQiyiPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [self.view addSubview:self.player];
//    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(20);
//        make.left.right.equalTo(self.view);
//        //注意此处，宽高比16:9优先级比1000低就行
//        make.height.equalTo(self.player.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
//    }];
    
    self.player.videoURL = self.videoURL;
    self.player.playerLayerGravityMode = PlayerLayerGravityModeResizeAspect;
    
    //如果想从xx秒开始播放视频
//    self.player.seekTime = 15;
    __weak typeof(self)weakSelf = self;
    self.player.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

- (void) setupTableView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 200) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.backgroundView = nil;
    tableView.delegate = self;
//    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = 40;
    [self.view addSubview:tableView];
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.player.mas_bottom).with.offset(10);
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom).offset(100);
//    }];
    self.tableView = tableView;
    
//    [self.tableView registerNib:[UINib nibWithNibName:kPlayerDetailCell bundle:nil] forCellReuseIdentifier:kPlayerDetailCell];
    NSMutableArray * items = [NSMutableArray array];
    [items addObject:@[@"123"]];
    [items addObject:@[@"231"]];
    [items addObject:@[@"我的麦霸女友",@"极品无赖犯二记",@"山炮进城",@"羞羞鬼"]];
    [items addObject:@[@"123"]];
    [items addObject:@[@"微星阿斯顿发",@"啊第三方qer",@"发生地方"]];
    self.dataSource = [[iQiyiDataSource alloc] initWithItems:items];
    self.tableView.dataSource = self.dataSource;
//    246 245 250
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = RGB(235, 235, 241);
    
    return view;
}

@end
