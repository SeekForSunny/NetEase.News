//
//  NEFoundViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NEFoundViewController.h"
#import "NEFounderViewCell.h"

#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>
#import <MJExtension.h>


#import "NEBannerModel.h"
#import "NERecommendModel.h"
#import "NEStreamModel.h"

@interface NEFoundViewController ()

@property (nonatomic , strong) AFHTTPSessionManager *manager;

@property (nonatomic , strong) NSArray *banner;//轮播器数据
@property (nonatomic , strong) NSArray *recommend;//头部View按钮视图
@property (nonatomic , strong) NSArray *stream; //tableView主体数据

@end

NSString *const founderCellID = @"founderCell";
NSString *const founderURL = @"http://c.m.163.com/nc/topicset/uc/api/discovery/indexV52";

@implementation NEFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEFounderViewCell class]) bundle:nil] forCellReuseIdentifier:founderCellID];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(SMARTNavMaxY, 0, SMARTTabBarH, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    self.tableView.backgroundColor = SMARTCommonColor;
    self.navigationItem.title = @"发现";
//    
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];

    
    [self setUpRefresh];

    
}

#pragma mark - 懒加载

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}



#pragma mark -  网络请求

- (void)setUpRefresh{
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}



- (void)loadNewData{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    
    [self.manager GET:founderURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        
        self.banner = [NEBannerModel objectArrayWithKeyValuesArray:responseObject[@"banner"]];
        self.recommend = [NERecommendModel objectArrayWithKeyValuesArray:responseObject[@"recommend"]];
        self.stream = [NEStreamModel objectArrayWithKeyValuesArray:responseObject[@"stream"]];
        
        SMARTOutPutPlist(responseObject, @"founder");
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.header endRefreshing];
    }];
}



- (void)loadMoreData{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    
    [self.manager GET:founderURL parameters:nil success:^(NSURLSessionDataTask * task, id   responseObject) {
        
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.footer endRefreshing];
    }];
}






#pragma mark -  tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.recommend.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NEFounderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:founderCellID];
    
    cell.model = self.stream[indexPath.row];
    return cell;
}
@end
