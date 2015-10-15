//
//  NEAudioModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/8.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEAudioModel : NSObject

@property (nonatomic ,copy) NSString *cid;
@property (nonatomic ,copy) NSString *cname;

@property (nonatomic , strong) NSArray *tList;

@end
