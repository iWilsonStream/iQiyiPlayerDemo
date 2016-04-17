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
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    self.player = [[iQiyiPlayer alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)];
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
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height - 220) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.backgroundView = nil;
    tableView.delegate = self;
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    tableView.estimatedRowHeight = 50;
//    tableView.tableFooterView = [UIView new];
//    tableView.rowHeight = 40;
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
    if(section == 2) return 40;
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(section != 2) return nil;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor = RGB(255, 255, 255);
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
    label.text = @"播放列表";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Arial" size:16.f];
    [view addSubview:label];
    
    CGRect rect = view.frame;
    rect.size.height = 1;
    rect.origin.y = 39;
    UIView * line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = RGB(235, 235, 241);
    [view addSubview:line];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) return 40;
    else if (indexPath.section == 1) return 120;
    else if (indexPath.section == 2) return 120;
    else if (indexPath.section == 3) return 120;
    else return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = RGB(235, 235, 241);
    
    return view;
}

@end
