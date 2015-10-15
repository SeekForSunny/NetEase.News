//
//  NERecommentReadModel.h
//  NetEase.News
//
//  Created by SMART on 15/10/9.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NERecommentReadModel : NSObject

@property (nonatomic , copy) NSString *digest;
@property (nonatomic , copy) NSString *recReason;//广州本地
@property (nonatomic , copy) NSString *source;//前瞻网
@property (nonatomic , copy) NSString *title;//标题
@property (nonatomic , copy) NSString *img;

@property (nonatomic , copy) NSString *picCount;
@property (nonatomic , copy) NSString *imgType;
@property (nonatomic , copy) NSString *pixel;
@property (nonatomic , strong) NSArray *unlikeReason;
@property (nonatomic , strong) NSArray *imgnewextra;

@end
