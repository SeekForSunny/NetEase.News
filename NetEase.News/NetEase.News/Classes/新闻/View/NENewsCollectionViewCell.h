//
//  NENewsCollectionViewCell.h
//  NetEase.News
//
//  Created by SMART on 15/10/2.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NENewsCollectionViewController.h"
@interface NENewsCollectionViewCell : UICollectionViewCell


#pragma mark - 头部轮番播放器数据部分
/**头部轮番播放器数据*/
@property (nonatomic , strong) NSMutableArray *headerViewDatas;

/**网易BoBo直播间数据*/
@property (nonatomic , strong) NSMutableArray *liveHomeDatas;
/**tableView部分数据*/
@property (nonatomic , strong) NSMutableArray *tableViewViewDatas;
///**推荐部分数据*/
@property (nonatomic , strong) NSMutableArray *recommentDatas;

@end
