//
//  NEStreamModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/8.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NEContextModel;
@interface NEStreamModel : NSObject

@property (nonatomic , strong) NSArray *context;
@property (nonatomic , copy) NSString *icon;
@property (nonatomic , copy) NSString *jumpUrl;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *type;

@end
