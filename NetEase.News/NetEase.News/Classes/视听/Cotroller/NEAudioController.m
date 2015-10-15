//
//  NEAudioController.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEAudioController.h"
#import "NEAudioCell.h"

#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>
#import <MJExtension.h>


#import "NEAudioModel.h"
#import "NEAudioTopModel.h"

@interface NEAudioController ()
@property (nonatomic , strong) AFHTTPSessionManager *manager;
@property (nonatomic , strong) NSArray *cListArr;
@property (nonatomic , strong) NSArray *topArr;

@end

NSString *const audioCellID = @"audioCell";
NSString *const requestURL = @"http://c.m.163.com/nc/topicset/android/radio/index.html";
@implementation NEAudioController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(SMARTNavMaxY, 0, SMARTTabBarH, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEAudioCell class]) bundle:nil] forCellReuseIdentifier:audioCellID];
    self.view.backgroundColor = SMARTCommonColor;
    
    [self setUpRefresh];

}

#pragma mark - 懒加载

-(AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark -网络请求


- (void)setUpRefresh{
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}



- (void)loadNewData{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    [self.manager GET:requestURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        self.cListArr = [NEAudioModel objectArrayWithKeyValuesArray:responseObject[@"cList"]];
        self.topArr = [NEAudioTopModel objectArrayWithKeyValuesArray:responseObject[@"top"]];
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



#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cListArr.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NEAudioCell *cell = [tableView dequeueReusableCellWithIdentifier:audioCellID];
    
    cell.model = self.cListArr[indexPath.row];
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 230;
}

@end
