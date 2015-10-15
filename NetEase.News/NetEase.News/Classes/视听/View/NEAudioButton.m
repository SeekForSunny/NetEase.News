//
//  NEAudioButton.m
//  NetEase.News
//
//  Created by SMART on 15/10/6.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEAudioButton.h"

@interface NEAudioButton ()
@property (nonatomic , weak) UIImageView *arrow;
@end
@implementation NEAudioButton

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        
//        
//        UIImageView *arrow = [[UIImageView alloc] init];
//        self.arrow = arrow;
//        [self addSubview:arrow];
//        
//    }
//    return self;
//}


- (void)awakeFromNib{
    
    UIImageView *arrow = [[UIImageView alloc] init];
    self.arrow = arrow;
    [self addSubview:arrow];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.x = SMARTMinMargin;
    self.imageView.height = self.height;
    self.imageView.width = self.height;
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + SMARTMaxMargin;
    
    self.arrow.image = [UIImage imageNamed:@"baike_arrow"];
    self.arrow.contentMode = UIViewContentModeScaleAspectFit;
    [self.arrow sizeToFit];

    self.arrow.centerY = self.centerY;
    self.arrow.x = self.width - 20;
    self.arrow.backgroundColor = [UIColor clearColor];
    

}
@end
