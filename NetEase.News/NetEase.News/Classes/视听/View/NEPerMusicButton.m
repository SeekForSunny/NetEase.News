//
//  NEPerMusicButton.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEPerMusicButton.h"

#import "NEPerMusicView.h"
#import "NEPerAudioModle.h"

@interface NEPerMusicButton ()
@property (nonatomic , weak) NEPerMusicView *perView;
@end
@implementation NEPerMusicButton


- (void)awakeFromNib{
   self.autoresizingMask = NO;
    
    NEPerMusicView *  perView= [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NEPerMusicView class]) owner:nil options:nil].lastObject;
    self.perView = perView;
    [self addSubview:perView];
}
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.perView.frame = self.bounds;

}

- (void)setModel:(NEPerAudioModle *)model{
    
    _model = model;
    self.perView.model = model;

    
}

@end
