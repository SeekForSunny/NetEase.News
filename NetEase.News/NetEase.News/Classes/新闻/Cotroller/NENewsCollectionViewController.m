//
//  NENewsCollectionViewController.m
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NENewsCollectionViewController.h"
#import "NENewsCollectionViewCell.h"


#import "NECommonHeaderViewModel.h"
#import "NECommonTableViewModel.h"
#import "NENewsBoBoLiveModel.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>


@interface NENewsCollectionViewController ()

/**按钮数组*/
@property (nonatomic , strong) NSMutableArray *titleButtons;
@property (nonatomic , strong) NSMutableArray *titles;

/**选中按钮*/
@property (nonatomic , strong) UIButton *selectedButton;
@property (nonatomic , assign) NSInteger selectedIndex;


/**指示器*/
@property (nonatomic , weak) UIView *indicator;


/**标题按钮栏view*/
@property (nonatomic , weak) UIScrollView *topContainView ;

/**下拉弹框*/
@property (nonatomic , weak) UIView *popView ;


@property (nonatomic , assign) BOOL flag;



#pragma mark - tableView数据请求部分

/**头部轮番播放器数据*/
@property (nonatomic , strong) NSMutableArray *headerViewDatas;
/**网易BoBo直播间数据*/
@property (nonatomic , strong) NSMutableArray *liveHomeDatas;
/**tableView部分数据*/
@property (nonatomic , strong) NSMutableArray *tableViewViewDatas;
///**推荐部分数据*/
@property (nonatomic , strong) NSMutableArray *recommentDatas;


@property (nonatomic ,strong) AFHTTPSessionManager *manager;

@property (nonatomic , strong) NSMutableArray *requestURLArrs;


@end

static NSInteger const TAG = 1000;

@implementation NENewsCollectionViewController

static NSString * const NENewsCellID = @"NENewsCell";


#pragma mark - 懒加载
- (NSMutableArray *)titleButtons{
    
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}


#pragma mark - 初始化
- (instancetype)init{

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;//CGSizeMake(SMARTScreenW, SMARTScreenH - SMARTNavMaxY);
 
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NENewsCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NENewsCellID];
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpCollectionView];
    [self setUpTitlesView];
    

    
}

#pragma mark 设置CollectionView
- (void)setUpCollectionView{
    
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;
//    self.collectionView.autoresizingMask = NO;

}

#pragma mark - 设置标题按钮 、顶部标题栏、顶部标题按钮视图、指示器按钮以及右边按钮
- (void)setUpTitlesView{
    
    NSArray *titles = @[@"头条",@"娱乐",@"热点",@"体育",@"广州",@"财经",@"科技",@"图片",@"跟帖",@"直播",@"轻松一刻",@"汽车",@"段子",@"时尚",@"军事",@"房产",@"历史",@"彩票",@"原创",@"画报",@"游戏",@"政务"];
    self.titles = [titles copy];
    
    
    
#pragma mark 设置标题栏ScrollView
    UIScrollView *topContainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SMARTNavMaxY, SMARTScreenW, SMARTTopContainViewH)];
    self.topContainView = topContainView;
    [self.view addSubview:topContainView];
    topContainView.backgroundColor = [UIColor purpleColor];
    
    
    
#pragma mark 设置标题栏titleView
    UIView *titleView = [[UIView alloc] initWithFrame:topContainView.bounds];
    
    
#pragma mark 设置标题栏右边按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self .view addSubview:rightButton];
    [rightButton setImage:[UIImage imageNamed:@"contenttoolbar_hd_back_light"] forState:UIControlStateNormal];
    
    rightButton.height = topContainView.height;
    rightButton.width = rightButton.height;
    rightButton.x = SMARTScreenW - rightButton.width;
    rightButton.y = SMARTNavMaxY;

    rightButton.backgroundColor = SMARTCommonColor;
  
    
    
#pragma mark 创建标题按钮
    NSInteger count = titles.count;
    NSString *title = nil;
    CGFloat X = 0;
    
    
    for (int i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [self.titleButtons addObject:button];
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i + TAG;
        [button addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
     
      title = titles[i];
      CGFloat titleW = [title sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}].width + 2 * SMARTMaxMargin;
        
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        [button.titleLabel sizeToFit];
        button.x = X;
        X += titleW + SMARTMinMargin;
        button.width = titleW;
        button.height = topContainView.height;
        [titleView addSubview:button];
        topContainView.contentSize = CGSizeMake(X+SMARTTopContainViewH, 0);
        titleView.width = X;

    }
    
    [topContainView addSubview:titleView];
    
    
#pragma mark 设置指示器
    
    UIView *indicator = [[UIView alloc] init];
    self.indicator = indicator;
    [topContainView insertSubview:indicator atIndex:0];
    indicator.y = topContainView.height - 2;
    indicator.height = 2;
    
    
    UIButton *firstButton = self.titleButtons.firstObject;
    [self titleButtonClicked:firstButton];
//     _indicator.width = firstButton.titleLabel.width;
//    indicator.centerX = firstButton.centerX;
    

    
}


#pragma mark - 事件处理

#pragma mark 标题按钮点击事件
- (void)titleButtonClicked:(UIButton*)titleButton{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;

    _indicator.width = self.selectedButton.titleLabel.width;
    _indicator.centerX = self.selectedButton.centerX;
    _indicator.backgroundColor = [UIColor redColor];

    
    NSInteger index = [self.titleButtons indexOfObject:titleButton];
    self.selectedIndex = index;
    
[[NSNotificationCenter defaultCenter] postNotificationName:@"selectedIndexDidChanged" object:self userInfo:@{@"selectedIndex":@(index)}];
    
    CGPoint offset = self.collectionView.contentOffset;
    
    offset.x = SMARTScreenW * index;
   
    
    [self.collectionView setContentOffset:offset animated:YES];
    

    

}






#pragma mark 右边按钮点击事件
- (void)rightButtonClicked:(UIButton *)rightButton{

    rightButton.imageView.transform = CGAffineTransformRotate(rightButton.imageView.transform,M_PI);
    

}

#pragma mark - 设置指示器显示位置以及设置containView的偏移位
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x/SMARTScreenW;
    UIButton *button =  [self.titleButtons objectAtIndex:index];
    [self titleButtonClicked:button];
    
    
    //将选中按钮的frame转换成ScrollView的frame,然后根据选中按钮的x取值来移动topView
    CGRect frame = [self.view convertRect:self.selectedButton.frame fromView:self.topContainView];
    CGFloat maxX = SMARTScreenW - SMARTTopContainViewH - self.selectedButton.width;
    CGPoint offset = self.topContainView.contentOffset;
    if (frame.origin.x >=maxX ) {
        
        offset.x += frame.origin.x - maxX;
        self.topContainView.contentOffset = offset;
    }
    
    if (frame.origin.x <= 0) {
        
        offset.x += frame.origin.x;
        self.topContainView.contentOffset = offset;
    }
    

}




#pragma mark - 网络请求部分



#pragma mark - 懒加载


- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];

    }
    return _manager;
}

- (NSMutableArray *)headerViewDatas{
    if (_headerViewDatas == nil) {
        _headerViewDatas = [[NSMutableArray alloc] init];
        
    }
    return _headerViewDatas;
}

- (NSMutableArray *)tableViewViewDatas{
    if (_tableViewViewDatas == nil) {
        _tableViewViewDatas = [NSMutableArray array];
        
    }
    return _tableViewViewDatas;
}

- (NSMutableArray *)recommentDatas{
    
    if (_recommentDatas == nil) {
        _recommentDatas = [NSMutableArray array];
    }
    return _recommentDatas;
}

- (NSMutableArray *)liveHomeDatas{

    if (_liveHomeDatas == nil) {
        _liveHomeDatas = [NSMutableArray array];
    }
    return _liveHomeDatas;
}






#pragma mark - 监听按钮改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIButton*)selectedButton change:(NSDictionary *)change context:(void *)context{
    
    if ([change[@"new"] intValue] == 1) {
        
        NSInteger selectedIndex = selectedButton.tag - TAG;
        self.selectedIndex = selectedIndex;

        [self getRequestURLArrWithIndex:selectedIndex];
        
        
    }
    
}

#pragma  mark - 请求网络数据

- (void)getRequestURLArrWithIndex:(NSInteger)selectedIndex{

    NSArray* requestURLArrs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"requestURLArrs.plist" ofType:nil]];
    
    NSArray *requestURLArr = requestURLArrs[selectedIndex];
    
   
  
    
    for (NSInteger index = 0; index< requestURLArr.count; index++){
        

        
        NSString *requestURL =requestURLArr[index];
        
        NSString *key = nil;
        switch (index) {
            case 0:
                
                if (requestURL.length) { //tableView  如果是广州、房产 key = @"广州"; 如果是汽车 key = list 如果是段子 key = 段子 直播key = head 如果是跟帖 key = headlist/commentlist
               
                    if ([self.titles[self.selectedIndex] isEqualToString:@"广州"]||[self.titles[self.selectedIndex] isEqualToString:@"房产"]) {
                        key = @"广州";
                    }else if ([self.titles[self.selectedIndex] isEqualToString:@"汽车"]){
                    
                    key = @"list";
                    }else if ([self.titles[self.selectedIndex] isEqualToString:@"轻松一刻"]){
                        
                        key = @"轻松一刻 - json数组 GET text/html ";
                        
                    }else if ([self.titles[self.selectedIndex] isEqualToString:@"图片"]){
                        
                        key = @"图片 - json数组 GET";
                    }else if ([self.titles[self.selectedIndex] isEqualToString:@"段子"]){
                        
                        key = @"段子";
                    }else if ([self.titles[self.selectedIndex] isEqualToString:@"直播"]){
                        
                        key = @"articleList/head";
                    }else if ([self.titles[self.selectedIndex] isEqualToString:@"跟贴"]){
                        
                        key = @"headlist/commentlist";
                    }else {
                    
                     NSMutableArray *cmpArr =(NSMutableArray*)[requestURL componentsSeparatedByString:@"/"];
                        
                        [cmpArr removeLastObject];
                        key = cmpArr.lastObject;
                    
                    }

                    
                        [self getDataWithRequest:requestURL index:index key:key];
                        

                    
//                    NSLog(@"index = %zd ",index );
                    
//                    NSLog(@"index = %zd requestURL = %@ , key = %@",index , requestURL ,key);
                }
                break;
                
            case 1:
                
                if (requestURL.length) {//轮播器
                    
                    key = @"headline_ad";
//                    NSLog(@"index = %zd ",index );
                    
//                    NSLog(@"index = %zd requestURL = %@ , key = %@",index , requestURL ,key);
                    [self getDataWithRequest:requestURL index:index key:key];
//                    [self sessionDataWithRequest:requestURL index:index key:key];
                }
                break;
                
            case 2:
                
                if (requestURL.length) {//直播室
                    
                    
                    key = @"anchorList";
//                    NSLog(@"index = %zd ",index );
                    
//                    NSLog(@"index = %zd requestURL = %@ , key = %@",index , requestURL ,key);
                    [self getDataWithRequest:requestURL index:index key:key];
                    
//                    [self sessionDataWithRequest:requestURL index:index key:key];
                }
                break;
                
            case 3:
                
                if (requestURL.length) {//推荐
                    
                    
                    key = @"推荐";
//                    NSLog(@"index = %zd ",index );
                    [self getDataWithRequest:requestURL index:index key:key];
//                    [self sessionDataWithRequest:requestURL index:index key:key];
                }
                break;
                

        }
        

    }
    

}


//- (void)sessionDataWithRequest:(NSString*)requestURL index:(NSInteger)index key:(NSString*)key{
//    
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:requestURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        id responseObject =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        if(error){ NSLog(@"%@ :Session数据请求失败！",self.titles[self.selectedIndex]); return;}
//        
//        SMARTOutPutPlist(responseObject, @"Session");
//        [self getSwitchDataWithResponseObject:responseObject index:index key:key];
//        
////        NSLog(@"session = %@",responseObject);
//        NSLog(@"Session加载数据 ....");
//        
//        
//    }];
//    [task resume];
//    
//}


- (void)getDataWithRequest:(NSString*)requestURL index:(NSInteger)index key:(NSString*)key{
    
    self.tableViewViewDatas = nil;
    self.headerViewDatas = nil;

    [self.manager GET:requestURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
    
        NSLog(@"第一次请求URL = %@",requestURL);
        [self getSwitchDataWithResponseObject:responseObject index:index key:key];

        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        NSLog(@"%@:GET数据请求失败！",self.titles[self.selectedIndex]);
        


        if (error) {
            
       
         self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [self.manager GET:requestURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {

            
            NSLog(@"第二次请求URL = %@",requestURL);
            
            [self getSwitchDataWithResponseObject:responseObject index:index key:key];

            
            
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
            NSLog(@"数据再次请求失败！");
          self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        }];
            
         }

    }];

}




- (void)getSwitchDataWithResponseObject:(id)responseObject index:(NSInteger )index key:(NSString*)key{


    if ([responseObject isKindOfClass:[NSDictionary class]]){
        
        
        switch (index) { //轻松一刻 - json数组 GET text/html
                
            case 0:   //表格数据
            {
                NSLog(@"%@ --key = %@",self.titles[self.selectedIndex],key);
        
                NSArray *keys = [key componentsSeparatedByString:@"/"];
                
                if ([key containsString:@"/"]) {
                 self.headerViewDatas = [NECommonHeaderViewModel objectArrayWithKeyValuesArray:responseObject[keys.lastObject]];
                 self.tableViewViewDatas = [NECommonTableViewModel  objectArrayWithKeyValuesArray:[responseObject[keys.firstObject] lastObject][@"list"]];
                 NSLog(@"Class = %@",[[responseObject[keys.firstObject] lastObject][@"list"] class]);
                }else{
         
                    self.tableViewViewDatas = [NECommonTableViewModel  objectArrayWithKeyValuesArray:responseObject[keys.firstObject]];

                }
                SMARTOutPutPlist(responseObject, @"tableview");
                

                
                if (self.tableViewViewDatas.count) {
                    
                    [self.headerViewDatas addObject: self.tableViewViewDatas.firstObject];
                    [self.tableViewViewDatas removeObjectAtIndex:0];
                }
                
                
                break;
            }
                
            case 1:    //头部轮播器
                
            {
                
                NSArray *newDatas = [NECommonHeaderViewModel objectArrayWithKeyValuesArray:responseObject[key]];
                
                [self.headerViewDatas addObjectsFromArray:newDatas];
                SMARTOutPutPlist(responseObject, @"header");
            

                break;
            }
                
            case 2:   //BoBo直播
                
                self.liveHomeDatas = [NENewsBoBoLiveModel objectArrayWithKeyValuesArray:responseObject[key]];
                SMARTOutPutPlist(responseObject, @"bobo");
                break;
                
            case 3:   //推荐
            {
                
                NSMutableArray *recommentDatas = [NECommonTableViewModel objectArrayWithKeyValuesArray:responseObject[key]];
                
                [self.tableViewViewDatas addObjectsFromArray:recommentDatas];
                SMARTOutPutPlist(responseObject, @"recomment");
                
    
                if (recommentDatas.count) {
                    
                    [self.headerViewDatas addObject: recommentDatas.firstObject];
                    [recommentDatas removeObjectAtIndex:0];
                    self.recommentDatas = recommentDatas;
                    
                }


                
                break;
                
            }
                
        }
    
    }else{ //图片: -- index = 0 --返回数据类型为json数组
    
        
//        NSLog(@"%@: -- index = %zd --返回数据类型为json数组",self.titles[_selectedIndex],index);
        
        
        switch (index) { //轻松一刻 - json数组 GET text/html
            case 0:   //表格数据
            {
                self.tableViewViewDatas = [NECommonTableViewModel  objectArrayWithKeyValuesArray:responseObject];
                SMARTOutPutPlist(responseObject, @"tableview");
                
                if (self.tableViewViewDatas.count) {
                    
                    [self.headerViewDatas addObject: self.tableViewViewDatas.firstObject];
                    [self.tableViewViewDatas removeObjectAtIndex:0];
                }
                
                break;
            }
                
            case 1:    //头部轮播器
                
            {
                
                NSArray *newDatas = [NECommonHeaderViewModel objectArrayWithKeyValuesArray:responseObject];
                
                [self.headerViewDatas addObjectsFromArray:newDatas];
                SMARTOutPutPlist(responseObject, @"header");
                
                break;
            }
                
            case 2:   //BoBo直播
                
                self.liveHomeDatas = [NENewsBoBoLiveModel objectArrayWithKeyValuesArray:responseObject];
                SMARTOutPutPlist(responseObject, @"bobo");
                break;
                
            case 3:   //推荐
            {
                
                NSMutableArray *recommentDatas = [NECommonTableViewModel objectArrayWithKeyValuesArray:responseObject];
                
                [self.tableViewViewDatas addObjectsFromArray:recommentDatas];
                SMARTOutPutPlist(responseObject, @"recomment");
                
                if (recommentDatas.count) {
                    
                    [self.headerViewDatas addObject: self.tableViewViewDatas.firstObject];
                    [self.tableViewViewDatas removeObjectAtIndex:0];
                    self.recommentDatas = recommentDatas;
                }
                
                break;
                
            }
        }
        
  
    
    }
    
    [self.collectionView reloadData];

}




#pragma mark - UICollectionViewDataSource 数据源方法


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleButtons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NENewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NENewsCellID forIndexPath:indexPath];
    [collectionView setNeedsLayout];
    
    if (self.tableViewViewDatas.count&&self.headerViewDatas.count) {
    
        cell.tableViewViewDatas = self.tableViewViewDatas;
        cell.headerViewDatas = self.headerViewDatas;

    }


//    if (self.headerViewDatas.count) {
//        
//        cell.headerViewDatas = self.headerViewDatas;
//
//    }

    return cell;
}





@end
