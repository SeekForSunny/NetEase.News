//
//  NENewsBoBoLiveModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/5.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NENewsBoBoLiveModel : NSObject


@property (nonatomic , copy) NSString *nick;//nick = 女王♚深情唱歌,
@property (nonatomic , assign) NSInteger level;
@property (nonatomic ,assign) NSInteger roomType;
@property (nonatomic ,assign) NSInteger anchorCategory;
@property (nonatomic , copy) NSString *CAT_NEWS;
@property (nonatomic , copy) NSString *followsCount;

@property (nonatomic ,assign) NSInteger goldenSkinType;
@property (nonatomic , copy) NSString *roomName;//roomName = 女王♚深情唱歌,
@property (nonatomic , copy) NSString *duration;//duration = 1小时53分钟,
@property (nonatomic , copy) NSString *ownerId;

@property (nonatomic , copy) NSString *serialVersionUID;
@property (nonatomic , copy) NSString *live;//live = true,
@property (nonatomic , assign) NSInteger sex;//sex = 2,
//CAT_BOBO_INDEX = bobo-index,
@property (nonatomic , copy) NSString *cover;
@property (nonatomic , copy) NSString *followedCount;
@property (nonatomic , copy) NSString *roomId;
@property (nonatomic , copy) NSString *liveBegin;
@property (nonatomic , copy) NSString *userNum;
//anchorType = 1,

@property (nonatomic , copy) NSString *promText;//promText = 温柔歌声声动你心,
@property (nonatomic , copy) NSString *avatar;
@property (nonatomic , copy) NSString *badge;

@property (nonatomic , copy) NSString *crowd;
@property (nonatomic , copy) NSString *userId;



@end
