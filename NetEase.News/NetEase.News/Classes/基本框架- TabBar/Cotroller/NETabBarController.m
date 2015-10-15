//
//  NETabBarController.m
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NETabBarController.h"

#import "NENewsCollectionViewController.h"
#import "NEReadViewController.h"
#import "NEAudioVisualViewController.h"
#import "NEFoundViewController.h"
#import "NEMeViewController.h"

@interface NETabBarController ()

@end

@implementation NETabBarController


#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVc];
    [self setUpTabBarItem];
    
    
}

#pragma mark 添加自控制器
- (void)addChildVc{
    
    NENewsCollectionViewController *newsVc = [[NENewsCollectionViewController alloc] init];
    [self setUpController:newsVc WithTitle:@"新闻" normalImage:[UIImage imageNamed:@"tabbar_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_news_highlight"]];

    
    NEReadViewController *readVc = [[NEReadViewController alloc] init];
    [self setUpController:readVc WithTitle:@"阅读" normalImage:[UIImage imageNamed:@"tabbar_icon_reader_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_reader_highlight"]];
  
    
    NEAudioVisualViewController *AudioVisualVc = [[NEAudioVisualViewController alloc] init];
    [self setUpController:AudioVisualVc WithTitle:@"视听" normalImage:[UIImage imageNamed:@"tabbar_icon_media_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_media_highlight"]];
   
    
    NEFoundViewController *foundVc = [[NEFoundViewController alloc] init];
    [self setUpController:foundVc WithTitle:@"发现" normalImage:[UIImage imageNamed:@"tabbar_icon_found_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_found_highlight"]];

    
    NEMeViewController *meVc = [[NEMeViewController alloc] init];
    [self setUpController:meVc WithTitle:@"我" normalImage:[UIImage imageNamed:@"tabbar_icon_me_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_me_highlight"]];
    
    

}

- (void)setUpController:(UIViewController *)controller WithTitle:(NSString *)title normalImage:(UIImage*)normalImage selectedImage:(UIImage*)selectedImage{

    controller.tabBarItem.title = title;
    controller.tabBarItem.selectedImage = selectedImage;
    controller.tabBarItem.image = normalImage;
    
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:controller]];
    
}


- (void)setUpTabBarItem{
    
    NSMutableDictionary *normalAttrs =[NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [self.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *SelectedAttrs =[NSMutableDictionary dictionary];
    SelectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    SelectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:SelectedAttrs forState:UIControlStateSelected];
    
}



@end
