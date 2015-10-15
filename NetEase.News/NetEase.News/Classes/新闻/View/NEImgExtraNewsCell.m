//
//  NEImgExtraNewsCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/4.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEImgExtraNewsCell.h"
#import "NECommonTableViewModel.h"
#import <UIImageView+WebCache.h>

@interface NEImgExtraNewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *title_lable;
@property (weak, nonatomic) IBOutlet UILabel *followCount_lable;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UIImageView *extraImage_view1;
@property (weak, nonatomic) IBOutlet UIImageView *extraImage_view2;

@end

@implementation NEImgExtraNewsCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = NO;
}

- (void)setModel:(NECommonTableViewModel *)model{

    _model = model;
    self.title_lable.text = model.title;
    self.followCount_lable.text = [NSString stringWithFormat:@"%@跟贴",model.replyCount];
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    [self.extraImage_view1 sd_setImageWithURL:[NSURL URLWithString:model.imgextra.firstObject[@"imgsrc"]]];
    
    [self.extraImage_view2 sd_setImageWithURL:[NSURL URLWithString:model.imgextra.lastObject[@"imgsrc"]]];

}


- (void)setFrame:(CGRect)frame{
    frame.origin.x = SMARTMaxMargin;
    frame.size.width -= 2*SMARTMaxMargin;
    [super setFrame:frame];
}
@end
