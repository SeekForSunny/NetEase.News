//
//  NEWordNewsCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEWordNewsCell.h"
#import "NECommonTableViewModel.h"

@interface NEWordNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *up_button;

@property (weak, nonatomic) IBOutlet UIButton *down_button;

@end

@implementation NEWordNewsCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = NO;
}

- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = SMARTMaxMargin;
    frame.size.width -= 2*SMARTMaxMargin;
    frame.origin.y -=2*SMARTMaxMargin;

    [super setFrame:frame];
    
}


- (void)setModel:(NECommonTableViewModel *)model{

    _model = model;
    
    self.text_label.text = model.digest;
    [self.up_button setTitle:model.upTimes forState:UIControlStateNormal];
    [self.down_button setTitle:model.downTimes forState:UIControlStateNormal];
}


@end
