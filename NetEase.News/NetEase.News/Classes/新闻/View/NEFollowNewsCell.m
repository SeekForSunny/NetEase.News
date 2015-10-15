//
//  NEFollowNewsCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEFollowNewsCell.h"


@interface NEFollowNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlle_lable;
@property (weak, nonatomic) IBOutlet UILabel *name_lable;
@property (weak, nonatomic) IBOutlet UILabel *content_lable;
@property (weak, nonatomic) IBOutlet UIButton *dig_button;

@end
@implementation NEFollowNewsCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = NO;
}


@end
