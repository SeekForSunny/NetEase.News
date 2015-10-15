//
//  NEAudioVisualViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEAudioVisualViewController.h"
#import "NEVisualController.h"
#import "NEAudioController.h"

@interface NEAudioVisualViewController ()

@end

@implementation NEAudioVisualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
    [self setupNavBar];
    self.view.backgroundColor = SMARTCommonColor;
}


- (void)setupChildVc{
    NEVisualController *visualVc = [[NEVisualController alloc] init];
    [self addChildViewController:visualVc];
    
    NEAudioController *audioVc = [[NEAudioController alloc] init];
    [self addChildViewController:audioVc];

}
- (void)setupNavBar{
    
    
    NSArray *items = @[@"视频",@"电台"];
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

        UIView *visualView = [self.childViewControllers[0] view];

        [self.view addSubview:visualView];
    }else{
    
        UIView *audioView = [self.childViewControllers[1] view];
        [self.view addSubview:audioView];

    }
    
    
}



@end
