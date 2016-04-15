//
//  iQiyiDataSource.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/15.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "iQiyiDataSource.h"
#import "PlayerDetailCell.h"

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
    
    PlayerDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:kPlayerDetailCell];
    if(!cell) {
        cell = [[PlayerDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPlayerDetailCell];
        
//        cell.backgroundColor = RGB(255, 255, 255);
    }
    
    cell.textLabel.text = self.items[indexPath.section][indexPath.row];
//    id item = [self itemAtIndexPath:indexPath];
//    self.configureCellBlock(item, cell, indexPath.row);
    
    return cell;
}

@end
