//
//  NEMyReadViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NEMyReadViewController.h"

#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>
#import <MJExtension.h>


#import "NEMyRecommendReadModel.h"
#import "NEBannerListModel.h"

@interface NEMyReadViewController ()

@property (nonatomic , strong) AFHTTPSessionManager *manager;
@property (nonatomic , strong) NSArray *recommendlist;
@property (nonatomic , strong) NSArray *bannerlist;



@end


NSString *const MyReadURL = @"http://c.m.163.com/nc/topicset/subscribe/recommend.html";

@implementation NEMyReadViewController


#pragma mark - 懒加载

- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return _manager;
}




#pragma mark - 设置tableView分组样式
- (instancetype)initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.contentInset = UIEdgeInsetsMake(SMARTNavMaxY, 0, SMARTTabBarH, 0);
    self.tableView.backgroundColor = SMARTCommonColor;
    self.tableView.sectionFooterHeight = SMARTMinMargin;
    self.tableView.sectionHeaderHeight = SMARTMinMargin;
    
    
    [self setUpRefresh];
    
}


#pragma mark - 网络请求


- (void)setUpRefresh{
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}



- (void)loadNewData{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    [self.manager GET:MyReadURL parameters:nil success:^(NSURLSessionDataTask *  task, id responseObject) {
        
        
        
        self.recommendlist = [NEMyRecommendReadModel objectArrayWithKeyValuesArray:responseObject[@"recommendlist"]];
        self.bannerlist = [NEBannerListModel objectArrayWithKeyValuesArray:responseObject[@"bannerlist"]];
        SMARTOutPutPlist(responseObject, @"myRead");
        
//        NSLog(@"myRead = %@",responseObject);
        
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.header endRefreshing];
    }];
}



- (void)loadMoreData{
    
    [self.manager GET:MyReadURL parameters:nil success:^(NSURLSessionDataTask * task, id   responseObject) {
        
        
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.footer endRefreshing];
    }];
}




#pragma mark - tabelView数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.recommendlist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }
    return 2;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *const cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    NEMyRecommendReadModel *model = self.recommendlist[indexPath.section];
    
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (indexPath.section >= 1) {
        
        if (indexPath.row == 0) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"reader_add_button"] forState:UIControlStateNormal];
            [button sizeToFit];
            button.layer.cornerRadius = button.width*0.5;
            button.clipsToBounds = YES;
            cell.accessoryView = button;
            
            cell.imageView.image = [UIImage imageNamed:@"reader_login_guide_myreader"];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",model.tname];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.subnum];
            
        }else{
            cell.accessoryView = nil;
            cell.imageView.image = nil;
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",model.title];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.digest];
        }
    }else{
        
        return cell;
        
    }
    
    


    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}


@end
