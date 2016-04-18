//
//  PlayerDetailController.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PlayerDetailController.h"
#import "PlayerDetailFilmListModel.h"
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
    self.player = [[iQiyiPlayer alloc] init];
    [self.view addSubview:self.player];
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.right.equalTo(self.view);
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

- (void) setupTableView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.player.mas_bottom);
        make.left.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenSize.width, kScreenSize.height - 200));
    }];
    self.tableView = tableView;
    [self setupDataSource];
}

- (void) setupDataSource {
    NSMutableArray * items = [NSMutableArray array];
    [items addObject:@[@"123"]];
    [items addObject:@[@"231"]];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"iqiyi_filmslist" ofType:@"plist"];
    NSDictionary * dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray * filmslist = dic[@"filmslist"];
    NSArray * likelist  = dic[@"likelist"];
    NSMutableArray * filmslistArr = [NSMutableArray array];
    NSMutableArray * likelistArr  = [NSMutableArray array];
    
    for(NSDictionary * filmDic in filmslist) {
        PlayerDetailFilmListModel * model = [PlayerDetailFilmListModel new];
        [model parseDictionary:filmDic];
        [filmslistArr addObject:model];
    }
    
    for(NSDictionary * likelistDic in likelist) {
        PlayerDetailFilmListModel * model = [PlayerDetailFilmListModel new];
        [model parseDictionary:likelistDic];
        [likelistArr addObject:model];
    }
    [items addObject:filmslistArr];
    [items addObject:likelistArr];
    [items addObject:@[@"123"]];
    
    self.dataSource = [[iQiyiDataSource alloc] initWithItems:items];
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 2 || section == 3) return 40;
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(section == 2 || section == 3) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        view.backgroundColor = RGB(255, 255, 255);
        
        NSString * title = nil;
        if(section == 2) title = @"播放列表";
        else if(section == 3) title = @"猜你喜欢";
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
        label.text = title;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = kTitleTextColor;
        label.font = kTitleFont;
        [view addSubview:label];
        
        CGRect rect = view.frame;
        rect.size.height = 1;
        rect.origin.y = 39;
        UIView * line = [[UIView alloc] initWithFrame:rect];
        line.backgroundColor = kLightGrayColor;
        [view addSubview:line];
        
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) return 40;
    else if (indexPath.section == 1) return 140;
    else if (indexPath.section == 2 || indexPath.section == 3) {
        CGFloat standardImgWidth = kStandardImgWidth;
        return standardImgWidth / 1.5 + 20;
    }
//    else if (indexPath.section == 3) return 120;
    else return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = kLightGrayColor;
    
    return view;
}

@end
