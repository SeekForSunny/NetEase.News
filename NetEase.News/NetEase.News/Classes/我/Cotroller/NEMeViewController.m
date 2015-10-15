//
//  NEMeViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEMeViewController.h"
#import "NESettingViewController.h"

@interface NEMeViewController ()

@end

@implementation NEMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonClicked)];

}



- (void)settingButtonClicked{

    NESettingViewController *settingVc = [[NESettingViewController alloc] init];
    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];

}

@end
