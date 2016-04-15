//
//  ViewController.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "ViewController.h"
#import "PlayerDetailController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void) configure {
    self.title = @"iQiyi Player Item List";
    
    NSDictionary * dic1 = @{@"鬼吹灯之寻龙诀":@"http://demo.zhixueyun.com/static/00/1B/CqJoMVaFMfSEChp9AAAAABEr3BU216.mp4"};
    NSDictionary * dic2 = @{@"火锅英雄":@"http://demo.zhixueyun.com/static/00/28/CqHYwVbiYEqEcb5DAAAAANSGOPQ829.mp4"};
    NSDictionary * dic3 = @{@"有一个地方只有我们知道":@"http://demo.zhixueyun.com/static/00/28/CqHYwVbiXh-EHBooAAAAAOzVKUQ229.mp4"};
    NSDictionary * dic4 = @{@"大声说我爱你":@"http://demo.zhixueyun.com/static/00/1D/CqHYwVaFQOGEEZlRAAAAADmcMCw129.mp4"};
    NSDictionary * dic5 = @{@"叶问2":@"http://demo.zhixueyun.com/static/00/19/CqJoMVaFGgeER3dvAAAAAFGXKBg448.mp4"};
    
    _dataSource = @[dic1,dic2,dic3,dic4,dic5];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor lightGrayColor];
    _tableView.rowHeight = 40;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"url";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [[_dataSource[indexPath.row] allKeys] firstObject];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerDetailController * detailController = [PlayerDetailController new];
    NSString * urlString = [_dataSource[indexPath.row] valueForKey:[[_dataSource[indexPath.row] allKeys] firstObject]];
    detailController.videoURL = [NSURL URLWithString:urlString];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

@end
