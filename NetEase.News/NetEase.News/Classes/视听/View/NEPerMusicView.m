//
//  NEPerMusicView.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NEPerMusicView.h"
#import "NERadioModel.h"
#import "NEPerAudioModle.h"


#import <UIImageView+WebCache.h>

@interface NEPerMusicView ()
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UIButton *focus_button;
@property (weak, nonatomic) IBOutlet UILabel *titile_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;

@end
@implementation NEPerMusicView


- (void)awakeFromNib{

    self.autoresizingMask = NO;
    
}

- (void)setModel:(NEPerAudioModle *)model{

    _model = model;
    
    NERadioModel * radio = model.radio;
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:radio.imgsrc] placeholderImage:[UIImage imageNamed:@"contentview_image_default"]];
    [self.focus_button setTitle:[NSString stringWithFormat:@"%.2f万",model.playCount.intValue/100000.0] forState:UIControlStateNormal];
    self.titile_label.text = radio.tname;
    self.content_label.text = radio.title;
    
  
}


@end
