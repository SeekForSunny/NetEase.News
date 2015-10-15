//
//  NEVisualController.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEVisualController.h"
#import "NEVisualCell.h"
#import <MJRefresh.h>
#import <AFHTTPSessionManager.h>
#import <MJExtension.h>


#import "NEVideoSidModel.h"
#import "NEVideoModel.h"


@interface NEVisualController ()

@property (nonatomic , strong) AFHTTPSessionManager *manager;
@property (nonatomic , strong) NSArray *videoSidArr;
@property (nonatomic , strong) NSArray *videoArr;
@end

NSString *const visualCellID = @"visualCell";

static NSString *const requestURL = @"http://c.m.163.com/nc/video/home/0-10.html";
@implementation NEVisualController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEVisualCell class]) bundle:nil] forCellReuseIdentifier:visualCellID];
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.contentInset = UIEdgeInsetsMake(SMARTNavMaxY, 0, SMARTTabBarH, 0);
    self.view.backgroundColor = SMARTCommonColor;
    self.tableView.header.automaticallyChangeAlpha = YES;
    
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
    
    
    [self.manager GET:requestURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {

        
        self.videoSidArr = [NEVideoSidModel objectArrayWithKeyValuesArray:responseObject[@"videoSidList"]];
        self.videoArr = [NEVideoModel objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        
        SMARTOutPutPlist(responseObject, @"visual");

        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.header endRefreshing];
    }];
}



- (void)loadMoreData{
    
    [self.manager GET:requestURL parameters:nil success:^(NSURLSessionDataTask * task, id   responseObject) {
        
        
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.footer endRefreshing];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.videoArr.count;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NEVisualCell *cell = [tableView dequeueReusableCellWithIdentifier:visualCellID];
    cell.model = self.videoArr[indexPath.row];
    return cell;
    
}



@end
