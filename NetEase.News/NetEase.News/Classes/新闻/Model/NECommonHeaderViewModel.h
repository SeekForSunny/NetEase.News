//
//  NECommonHeaderViewModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/3.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NECommonHeaderViewModel : NSObject

/**头部轮番播放器图片字符串*/
@property (nonatomic , copy)  NSString *imgsrc;

/**头部轮番播放器图片子标题*/
@property (nonatomic , copy)  NSString *subtitle;

/**头部轮番播放器图片标题*/
@property (nonatomic , copy)  NSString *title;

/**头部轮番播放器图片链接url*/
@property (nonatomic , copy)  NSString *url;
@property (nonatomic , copy) NSString *tag;


@end
