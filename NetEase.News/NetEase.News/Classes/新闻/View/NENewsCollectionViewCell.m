//
//  NENewsCollectionViewCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NENewsCollectionViewCell.h"
#import "NECommonNewsCell.h"
#import "NEImgExtraNewsCell.h"
#import "NELiveNewsCell.h"
#import "NEWordNewsCell.h"
#import "NEPictureNewsCell.h"
#import "NEFollowNewsCell.h"


#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>


#import "NECommonHeaderViewModel.h"
#import "NECommonTableViewModel.h"
#import "NENewsBoBoLiveModel.h"


@interface NENewsCollectionViewCell ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , weak) UITableView *tableView; //懒加载

@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , weak) UIScrollView *scrollView;
@property (nonatomic , weak) UIPageControl * pageControl;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , weak)UIView *bottomView;
@property (nonatomic , weak)UILabel *leftTextLable;
@property (nonatomic , weak) UIView *headerView;

//@property (nonatomic , assign) NSInteger selectedIndex;
@property (nonatomic , strong) AFHTTPSessionManager *manager;

@end


static NSString *const commonCellID= @"commonCell";
static NSString *const extraNewsCellID = @"ImgExtra";
static NSString *const liveNewsCellID =  @"livewNews";
static NSString *const wordNewsCellID =  @"wordNews";
static NSString *const pictureNewsCellID =  @"pictureNews";
static NSString *const followNewsCellID =  @"followNews";

@implementation NENewsCollectionViewCell


#pragma mark - 懒加载



- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        
        self.tableView = tableView;
        [self addSubview:tableView];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self setUpTableView];
//        [self setUpTableViewHeader];
        
    }
    return _tableView;
}

#pragma mark -  setter方法设置数据
- (void)setHeaderViewDatas:(NSMutableArray *)headerViewDatas{

    NSLog(@"HeaderViewCount = %zd",headerViewDatas.count);
    
    _headerViewDatas = headerViewDatas;

    self.pageControl.numberOfPages = self.headerViewDatas.count;
    
    if([headerViewDatas.lastObject imgsrc]){
                [self setUpTableViewHeader];
        [self setUpScrollViewContent:self.scrollView];
    }
    
    
}

- (void)setTableViewViewDatas:(NSMutableArray *)tableViewViewDatas{
    
    _tableViewViewDatas = tableViewViewDatas;
      NSLog(@"TableViewCount = %zd",tableViewViewDatas.count);
    

    [self.tableView reloadData];

    
}


#pragma mark - 初始化
- (void)awakeFromNib {

    self.autoresizingMask = NO;

}


- (void)layoutSubviews{
    [super layoutSubviews];

    
    CGPoint offset = self.tableView.contentOffset;
    offset.y = -self.tableView.contentInset.top;
    [self.tableView setContentOffset:offset animated:YES];
    
}


#pragma mark 设置tableView
- (void)setUpTableView{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NECommonNewsCell class]) bundle:nil] forCellReuseIdentifier:commonCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEImgExtraNewsCell class]) bundle:nil] forCellReuseIdentifier:extraNewsCellID];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NELiveNewsCell class]) bundle:nil] forCellReuseIdentifier:liveNewsCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEWordNewsCell class]) bundle:nil] forCellReuseIdentifier:wordNewsCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEPictureNewsCell class]) bundle:nil] forCellReuseIdentifier:pictureNewsCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NEFollowNewsCell class]) bundle:nil] forCellReuseIdentifier:followNewsCellID];
    
    self.tableView.backgroundColor = SMARTCommonColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(SMARTNavMaxY+SMARTTopContainViewH, 0, SMARTTabBarH, 0);
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;

    

}

#pragma mark - 设置tableViewHeader视图

- (void)setUpTableViewHeader{
  
    
    UIView *headerView = [[UIView alloc] init];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.frame = CGRectMake(0, 0, SMARTScreenW ,200);
    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
    [headerView addSubview:scrollView];
    headerView.frame = scrollView.frame;
    self.tableView.tableHeaderView =headerView;
    
    
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    bottomView.frame = CGRectMake(0, scrollView.height - 30, scrollView.width, 30);
    bottomView.backgroundColor = [UIColor lightTextColor];
    [headerView addSubview:bottomView];
    
    UILabel *leftTextLable = [[UILabel alloc] init];
    self.leftTextLable = leftTextLable;

    leftTextLable.textColor = [UIColor blackColor];
    leftTextLable.font = [UIFont systemFontOfSize:13];
    leftTextLable.frame = CGRectMake(SMARTMaxMargin, 0, SMARTScreenW - self.pageControl.width - SMARTMaxMargin, bottomView.height);
    [bottomView addSubview:leftTextLable];
    

}


- (void)setUpScrollViewContent:(UIScrollView*)scrollView{
    
    
    CGFloat W = scrollView.width;
    CGFloat H = scrollView.height;
    CGFloat Y = 0;
    int count = (int)self.headerViewDatas.count;
    scrollView.contentSize = CGSizeMake(count*W,0);

    for (int i = 0; i < count; i++) {
        
        CGFloat X = i*W;
        
        UIImageView *imageView  = [[UIImageView alloc] init];
        
        NSString *imageName = [self.headerViewDatas[i] imgsrc];
//        NSLog(@"imageName = %zd",imageName);
       
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
        [scrollView addSubview:imageView];
        
        imageView.backgroundColor = [UIColor greenColor];
        imageView.frame = CGRectMake(X, Y, W,H);
        
        
    }
    
    
    self.leftTextLable.text = [self.headerViewDatas[0] title];
    
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.numberOfPages = self.totalPageCount;


    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    pageControl.height = self.bottomView.height;
    pageControl.x = self.bottomView.width - pageControl.width - 50;
    [self.bottomView addSubview:pageControl];
    
//    [self startTimer];

}



# pragma mark - scrollView的代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    [self stopTimer];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    int page = scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = page;
    self.leftTextLable.text = [self.headerViewDatas[page] title];
//    [self startTimer];
    
    
}


#pragma mark - 头部ScrollView方法
#pragma mark 打开定时器
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark 关掉定时器
- (void)stopTimer
{
    
    [self.timer invalidate];
    
}

#pragma mark 控制自动轮番播放
- (void)nextPage{
    
    NSUInteger page = self.pageControl.currentPage + 1;
    self.pageControl.currentPage = page;
    
    
    if (page > self.totalPageCount-1) {
        self.pageControl.currentPage =0;
    }else
    {
        self.pageControl.currentPage = page;
    }
    
    self.leftTextLable.text = [self.headerViewDatas[page%self.headerViewDatas.count] title];

    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.pageControl.currentPage * SMARTScreenW;

    self.scrollView.contentOffset = offset;
    
}





#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tableViewViewDatas.count;
}

#pragma mark 设置Cell显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NECommonTableViewModel *model =  self.tableViewViewDatas[indexPath.row];

    if (model.imgextra) {
        
       NEImgExtraNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:extraNewsCellID];
        cell.model = model;
       return cell;
    
    }else if(model.imgType == 1) {
        
        NELiveNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:liveNewsCellID];
        cell.model = model;
        return cell;
    }else if(!model.imgsrc) {
        
        NEWordNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:wordNewsCellID];
        cell.model = model;
        
        return cell;
    }else{
        
       NECommonNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellID];
        cell.model = model;
       return cell;
    }
 
}

#pragma mark  选中打印

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NECommonTableViewModel *model = self.tableViewViewDatas[indexPath.row]; //+ indexPath.section*10];
    SMARTLog(@"section  = %zd -- row =  %zd -- %@",indexPath.section,indexPath.row,model.title);

}

#pragma mark 设置Cell高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NECommonTableViewModel *model = self.tableViewViewDatas[indexPath.row];// + indexPath.section*10];
//    
//    if (model.imgextra) {
//        return 115;
//    }else if(model.imgType == 1){
//        return 200;
//    }
//    
//    return 80;
//}

@end



