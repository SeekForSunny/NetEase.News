//
//  AppDelegate.m
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "AppDelegate.h"
#import "NETabBarController.h"
@interface AppDelegate ()
@property (nonatomic , strong) UIWindow *StatusBarwindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    NETabBarController *tabBarVc = [[NETabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
    
    [self.window makeKeyAndVisible];
    return YES;
}





- (UIWindow *)StatusBarwindow{
    if (_StatusBarwindow == nil) {
        _StatusBarwindow = [[UIWindow alloc] init];
        UIViewController *Vc = nil;
        _StatusBarwindow.rootViewController = Vc;
        Vc.view.backgroundColor = [UIColor clearColor];
        _StatusBarwindow.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        _StatusBarwindow.backgroundColor = [UIColor clearColor];
        _StatusBarwindow.hidden = NO;
        _StatusBarwindow.windowLevel = UIWindowLevelAlert;
        [_StatusBarwindow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusBarClick)]];
    }
    return _StatusBarwindow;
}


- (void)searchSubViews:(UIView*)superView{
    for (UIScrollView *subView in superView.subviews) {
        [self searchSubViews:subView];
        if (![subView isKindOfClass:[UIScrollView class]]) continue;
        
        CGRect scrollViewRect = [subView  convertRect:subView.bounds toView:subView.window];
        CGRect windowRect = subView.window.bounds;
        
        if (!CGRectIntersectsRect(scrollViewRect, windowRect)) continue;
        
        CGPoint offset = subView.contentOffset;
        offset.y = -subView.contentInset.top;
        [subView setContentOffset:offset animated:YES];
        
    }
    
    
    
}

- (void)statusBarClick{
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        [self searchSubViews:window];
    }
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self StatusBarwindow];
}

@end
