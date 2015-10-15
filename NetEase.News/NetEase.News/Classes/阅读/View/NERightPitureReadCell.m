//
//  NERightPitureReadCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/9.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NERightPitureReadCell.h"
#import "NERecommentReadModel.h"


#import <UIImageView+WebCache.h>

@interface NERightPitureReadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image1_view;
@property (weak, nonatomic) IBOutlet UIImageView *image2_view;
@property (weak, nonatomic) IBOutlet UIImageView *image3_view;

@property (weak, nonatomic) IBOutlet UILabel *title_lable;

@property (weak, nonatomic) IBOutlet UILabel *source_lable;

@end

@implementation NERightPitureReadCell

- (void)awakeFromNib {
    self.autoresizingMask = NO;
}


- (void)setModel:(NERecommentReadModel *)model{

    _model = model;
    
    
//    [self.image1_view sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
//    [self.image2_view sd_setImageWithURL:[NSURL URLWithString:model.imgnewextra.firstObject[@"imgsrc"]]];
//    [self.image2_view sd_setImageWithURL:[NSURL URLWithString:model.imgnewextra.lastObject[@"imgsrc"]]];
    
    self.title_lable.text = model.title;
    self.source_lable.text = model.source;
    
}

@end
