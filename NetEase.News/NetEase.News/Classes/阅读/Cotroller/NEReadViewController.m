//
//  NEReadViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NEReadViewController.h"
#import "NERecommentReadController.h"
#import "NEMyReadViewController.h"

@interface NEReadViewController ()

@end

@implementation NEReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
    [self setupNavBar];
    self.view.backgroundColor = SMARTCommonColor;
}


- (void)setupChildVc{
    NERecommentReadController *recommentVc = [[NERecommentReadController alloc] init];
    [self addChildViewController:recommentVc];
    
    NEMyReadViewController *myReadVc = [[NEMyReadViewController alloc] init];
    [self addChildViewController:myReadVc];
    
}
- (void)setupNavBar{
    
    
    NSArray *items = @[@"推荐阅读",@"我的订阅"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    [segment addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];
    segment.width = 100;
    segment.selectedSegmentIndex = 0;
    [self segmentClicked:segment];
    self.navigationItem.titleView = segment;
    
    
    
}

- (void)segmentClicked:(UISegmentedControl*)segment{
    
//    NSLog(@"segment = %zd",segment.selectedSegmentIndex);
    
    if (segment.selectedSegmentIndex == 0) {
        
        UIView *visualView = [self.childViewControllers.firstObject view];
        
        [self.view addSubview:visualView];
    }else{
        
        UIView *audioView = [self.childViewControllers.lastObject view];
        [self.view addSubview:audioView];
        
    }
    
    
}


@end
