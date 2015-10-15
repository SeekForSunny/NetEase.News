//
//  NESettingViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NESettingViewController.h"
#import "NEClearCell.h"

@interface NESettingViewController ()

@end
static NSString *const clearCellID = @"clearCell";

@implementation NESettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[NEClearCell class] forCellReuseIdentifier:clearCellID];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NEClearCell *cell = [tableView dequeueReusableCellWithIdentifier:clearCellID];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NEClearCell *cell = (NEClearCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell clearCache];

}

@end
