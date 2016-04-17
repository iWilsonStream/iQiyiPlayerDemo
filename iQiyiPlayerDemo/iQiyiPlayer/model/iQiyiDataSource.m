//
//  iQiyiDataSource.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "iQiyiDataSource.h"
#import "PlayerDetailCell.h"
#import "FirstSectionCell.h"
#import "SecondSectionCell.h"
#import "ThirdSectionCell.h"

@interface iQiyiDataSource ()

@property (strong, nonatomic) NSArray * items;
@property (copy, nonatomic)   NSString * identifier;
@property (copy, nonatomic)   configureCellBlock configureCellBlock;

@end

@implementation iQiyiDataSource

- (instancetype)initWithItems:(NSArray *)items {
    if(self = [super init]) {
        self.items = items;
//        self.identifier = identifier;
//        self.configureCellBlock = block;
    }
    return self;
}

//- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray * array = self.items == nil ? @[] : self.items[indexPath.section];
//    return array == 0 ? nil : array[(NSUInteger)indexPath.row];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items == nil ? 0 : self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * array = self.items == nil ? @[] : self.items[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.section == 0) {
        FirstSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:kPlayerDetailFirstCell];
        if(!cell) {
            cell = [[FirstSectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPlayerDetailFirstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    
    if(indexPath.section == 1) {
        SecondSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:kPlayerDetailSecondCell];
        if(!cell) {
            cell = [[SecondSectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPlayerDetailSecondCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    
    if(indexPath.section == 2) {
        ThirdSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:kPlayerDetailThirdCell];
        if(!cell) {
            cell = [[ThirdSectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPlayerDetailThirdCell];
            UIView * selectView = [UIView new];
            selectView.backgroundColor = RGB(249, 249, 249);
            cell.selectedBackgroundView = selectView;
        }
        
        PlayerDetailFilmListModel * model = self.items[indexPath.section][indexPath.row];
        [cell configureFilmCellWithModel:model];
        
        return cell;
    }
    
    PlayerDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:kPlayerDetailCell];
    if(!cell) {
        cell = [[PlayerDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPlayerDetailCell];
        UIView * selectedView = [UIView new];
        selectedView.backgroundColor = RGB(235, 235, 241);
        cell.selectedBackgroundView = selectedView;
//        cell.backgroundColor = RGB(255, 255, 255);
    }
    
    cell.textLabel.text = self.items[indexPath.section][indexPath.row];
//    id item = [self itemAtIndexPath:indexPath];
//    self.configureCellBlock(item, cell, indexPath.row);
    
    return cell;
}

@end
