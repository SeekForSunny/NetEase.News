//
//  NENewsLiveModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/4.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NENewsLiveModel : NSObject


@property (nonatomic , copy) NSString *end_time;
@property (nonatomic , copy) NSString *roomId;
@property (nonatomic , copy) NSString *start_time;
@property (nonatomic , copy) NSString *type;
@property (nonatomic , copy) NSString *user_count;
@property (nonatomic , assign) BOOL video;


@end
