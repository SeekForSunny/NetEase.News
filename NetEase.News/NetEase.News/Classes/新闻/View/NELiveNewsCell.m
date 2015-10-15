//
//  NELiveNewsCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/4.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NELiveNewsCell.h"
#import "NECommonTableViewModel.h"

#import <UIImageView+WebCache.h>
@interface NELiveNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *title_lable;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UIButton *livie_btn;

@end
@implementation NELiveNewsCell

- (void)awakeFromNib {
    self.autoresizingMask = NO;
    
}


- (void)setFrame:(CGRect)frame{

    
    frame.origin.x = SMARTMaxMargin;
    frame.size.width -= 2*SMARTMaxMargin;
    [super setFrame:frame];

}


- (void)setModel:(NECommonTableViewModel *)model{
    _model = model;
    self.title_lable.text = model.title;
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.content_label.text = model.digest;
    [self.livie_btn setTitle:model.TAG forState:UIControlStateNormal];
    
    if ([model.skipType isEqualToString:@"special"]) {
        [self.livie_btn setTitle:@"专题"forState:UIControlStateNormal];
    }

}

@end
