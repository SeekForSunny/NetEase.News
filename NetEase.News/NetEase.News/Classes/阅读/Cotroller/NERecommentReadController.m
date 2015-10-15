//
//  NERecommentReadController.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NERecommentReadController.h"
#import "NERecommentReadCell.h"
#import "NERecommentReadModel.h"

#import <AFHTTPSessionManager.h>
#import <MJExtension.h>
#import <MJRefresh.h>


#import "NERecommentReadCell.h"
#import "NERecBigPictureReadCell.h"
#import "NERightPitureReadCell.h"
#import "NELeftPictureReadCell.h"



@interface NERecommentReadController ()

@property (nonatomic , strong) AFHTTPSessionManager *manager;
@property (nonatomic , strong) NSArray *recommentsArr;
@end


static NSString * const recommentCellID = @"recommentRead";
static NSString * const recLeftCellID = @"leftPictureRead";
static NSString * const recRightCellID = @"rightPitureRead";
static NSString * const recBigCellID = @"bigPictureRead";


static NSString *const RecommentURL = @"http://c.m.163.com/recommend/getSubDocPic?size=20&from=yuedu";
@implementation NERecommentReadController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUptableView];
    [self setUpRefresh];
    
}

- (void)setUptableView{

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NERecommentReadCell class]) bundle:nil] forCellReuseIdentifier:recommentCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NELeftPictureReadCell class]) bundle:nil] forCellReuseIdentifier:recLeftCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NERightPitureReadCell class]) bundle:nil] forCellReuseIdentifier:recRightCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NERecBigPictureReadCell class]) bundle:nil] forCellReuseIdentifier:recBigCellID];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.contentInset = UIEdgeInsetsMake(SMARTNavMaxY, 0, SMARTTabBarH, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = SMARTCommonColor;
    self.tableView.header.automaticallyChangeAlpha = YES;
    
}

#pragma mark - 网络请求

#pragma mark   懒加载

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)setUpRefresh{
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}



- (void)loadNewData{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    [self.manager GET:RecommentURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        
        self.recommentsArr = [NERecommentReadModel objectArrayWithKeyValuesArray:responseObject[@"推荐"]];
//        NSLog(@"res = %@",responseObject);
        SMARTOutPutPlist(responseObject, @"recommentRead");
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.header endRefreshing];
    }];
}



- (void)loadMoreData{
    
    [self.manager GET:RecommentURL parameters:nil success:^(NSURLSessionDataTask * task, id   responseObject) {
        
        
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [self.tableView.footer endRefreshing];
    }];
}




#pragma  mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.recommentsArr.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NERecommentReadModel *model = self.recommentsArr[indexPath.row];
//    if (model.imgnewextra) {
//        NERightPitureReadCell *cell = [tableView dequeueReusableCellWithIdentifier:recRightCellID];
//        
//        cell.model = model;
//        return cell;
//        
//    }else{
    
    NERecommentReadCell *cell = [tableView dequeueReusableCellWithIdentifier:recommentCellID];
    
        cell.model = model;
         return cell;
//    }
   
}



@end
