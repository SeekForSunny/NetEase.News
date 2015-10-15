//
//  NELable.m
//  NetEase.News
//
//  Created by SMART on 15/10/10.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NELable.h"

@implementation NELable


- (void)drawRect:(CGRect)rect {


    [self.text drawInRect:rect withAttributes:@{NSFontAttributeName :self.font}];

}


@end
