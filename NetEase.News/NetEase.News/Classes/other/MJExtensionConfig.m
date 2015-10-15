//
//  MJExtensionConfig.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "MJExtensionConfig.h"
#import <MJExtension.h>

#import "NEStreamModel.h"
#import "NEVideoModel.h"
#import "NEAudioModel.h"
#import "NECommonTableViewModel.h"
#import "NENewsLiveModel.h"



@implementation MJExtensionConfig


+(void)load{

    [NEStreamModel setupObjectClassInArray:^NSDictionary *{ //NEStreamModel *context
        
        return @{@"context":@"NEContextModel"};
        
    }];
    
    
    
    
    [NEVideoModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Des":@"description"};
    }];
    
    
    
    [NEAudioModel setupObjectClassInArray:^NSDictionary *{
        
        return @{@"tList" : @"NEPerAudioModle"};
    }];
    
    
    [NECommonTableViewModel setupObjectClassInArray:^NSDictionary *{
        
        return @{@"list" : @"NENewsLiveModel"};
    }];


}

@end
