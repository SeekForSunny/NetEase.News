//
//  NEPerAudioModle.h
//  NetEase.News
//
//  Created by SMART on 15/10/8.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NERadioModel.h"

@interface NEPerAudioModle : NSObject


@property (nonatomic , copy) NSString *tname;
@property (nonatomic , copy) NSString *playCount;
@property (nonatomic ,strong) NERadioModel *radio;

@end
