//
//  NEVisualCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEVisualCell.h"
#import <UIImageView+WebCache.h>
#import "NEVideoModel.h"

@interface NEVisualCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UILabel *title_lable;
@property (weak, nonatomic) IBOutlet UILabel *subtitle_lable;

@property (weak, nonatomic) IBOutlet UIButton *timeLengthBtn;

@property (weak, nonatomic) IBOutlet UIButton *playCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation NEVisualCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = NO;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = SMARTMaxMargin;
    frame.size.width -= 2*SMARTMaxMargin;
    frame.size.height -= 2*SMARTMaxMargin;
    [super setFrame:frame];
}

- (void)setModel:(NEVideoModel *)model{
    _model = model;
    
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
    self.title_lable.text = model.title;
    self.subtitle_lable.text = model.Des;
    [self.playCountBtn setTitle:model.playCount forState:UIControlStateNormal];
    [self.timeLengthBtn setTitle:[NSString stringWithFormat:@"%zd:%zd",model.length.integerValue/60,model.length.integerValue%60] forState:UIControlStateNormal];
    
    [self.commentBtn setTitle:model.replyCount forState:UIControlStateNormal];
}


@end
