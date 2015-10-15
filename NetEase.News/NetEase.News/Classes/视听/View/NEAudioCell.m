//
//  NEAudioCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEAudioCell.h"
#import "NEAudioButton.h"
#import "NEAudioModel.h"
#import "NEPerMusicButton.h"

#import "NEPerAudioModle.h"
@interface NEAudioCell ()

@property (weak, nonatomic) IBOutlet NEAudioButton *title_btn;
@property (weak, nonatomic) IBOutlet NEPerMusicButton *left_button;
@property (weak, nonatomic) IBOutlet NEPerMusicButton *middle_btn;
@property (weak, nonatomic) IBOutlet NEPerMusicButton *right_btn;

@end

@implementation NEAudioCell


- (void)awakeFromNib {
    self.autoresizingMask = NO;
    
}


- (void)setModel:(NEAudioModel *)model{

    _model = model;
    
    [self.title_btn setTitle:model.cname forState:UIControlStateNormal];

    self.left_button.model = model.tList[0];
    self.middle_btn.model = model.tList[1];
    self.right_btn.model = model.tList[2];

}




@end
