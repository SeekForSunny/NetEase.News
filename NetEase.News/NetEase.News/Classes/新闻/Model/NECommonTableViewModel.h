//
//  NECommonTableViewModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/3.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NENewsLiveModel.h"

@class NECommonHeaderViewModel;
@interface NECommonTableViewModel : NSObject

@property (nonatomic , strong)  NECommonHeaderViewModel *ads;
@property (nonatomic , copy) NSString *alias;
@property (nonatomic , copy) NSString *cid;
@property (nonatomic , copy) NSString *digest;
@property (nonatomic , copy) NSString *docid;
@property (nonatomic , copy) NSString *ename;
@property (nonatomic , assign) NSInteger hasAD;
@property (nonatomic , assign) BOOL hasCover;
@property (nonatomic , assign) NSInteger hasHead;
@property (nonatomic , assign) BOOL hasIcon;
@property (nonatomic , assign) NSInteger hasImg;
@property (nonatomic ,strong) NSArray *imgextra;
@property (nonatomic , copy) NSString *imgsrc;
@property (nonatomic , copy) NSString *lmodify;
@property (nonatomic , assign) NSInteger order;
@property (nonatomic , copy) NSString *photosetID;
@property (nonatomic , copy) NSString *priority;
@property (nonatomic , copy) NSString *ptime;
@property (nonatomic , copy) NSString *replyCount;
@property (nonatomic , copy) NSString *skipID;
@property (nonatomic , copy) NSString *skipType;
@property (nonatomic , copy) NSString *template;
@property (nonatomic ,copy) NSString *TAG;
@property (nonatomic , assign) NSInteger imgType;
@property (nonatomic , copy) NSString *specialID;
@property (nonatomic , copy) NSString *votecount;
@property (nonatomic , copy) NSString *url;
@property (nonatomic , copy) NSString *url_3w;

@property (nonatomic , copy) NSString *clkNum;
@property (nonatomic ,copy) NSString *program;


@property (nonatomic , strong) NENewsLiveModel *live_info;

/**cell内容标题*/
@property (nonatomic , copy) NSString *title;

/**分类*/
@property (nonatomic , copy) NSString *tname;


@property (nonatomic , copy) NSString *boardid;
@property (nonatomic , copy) NSString *downTimes;
@property (nonatomic , copy) NSString *upTimes;

@property (nonatomic , strong) NSArray *list;




@end
