//
//  NECommonNewsCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/3.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NECommonNewsCell.h"
#import "NECommonTableViewModel.h"
#import <UIImageView+WebCache.h>

@interface NECommonNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image_View;
@property (weak, nonatomic) IBOutlet UILabel *title_lable;
@property (weak, nonatomic) IBOutlet UILabel *content_lable;
@property (weak, nonatomic) IBOutlet UILabel *followCount_lable;

@end

@implementation NECommonNewsCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = NO;
}


- (void)setFrame:(CGRect)frame {
    frame.origin.x = SMARTMaxMargin;
    frame.size.width = SMARTScreenW - 2*SMARTMaxMargin;
    [super setFrame:frame];
}


- (void)setModel:(NECommonTableViewModel *)model{

    _model = model;
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.title_lable.text = model.title;
    
    self.content_lable.text = model.digest;
    self.followCount_lable.text = [NSString stringWithFormat:@"%@跟贴",model.replyCount];
    
}
@end
