//
//  NEFounderViewCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEFounderViewCell.h"
#import <UIImageView+WebCache.h>


#import "NEStreamModel.h"
#import "NEContextModel.h"

@interface NEFounderViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImage_view;

@property (weak, nonatomic) IBOutlet UIImageView *logo_imageView;
@property (weak, nonatomic) IBOutlet UILabel *name_lable;

@property (weak, nonatomic) IBOutlet UILabel *title_lable;
@property (weak, nonatomic) IBOutlet UILabel *disc_lable;

@property (weak, nonatomic) IBOutlet UIButton *bottom_leftbtn;
@property (weak, nonatomic) IBOutlet UILabel *buttomText_lable;

@end

@implementation NEFounderViewCell

- (void)awakeFromNib {
    self.autoresizingMask = NO;
}



- (void)setFrame:(CGRect)frame{
    frame.origin.x = SMARTMaxMargin;
    frame.size.width -= 2*SMARTMaxMargin;
    frame.size.height -=2*SMARTMaxMargin;
    [super setFrame:frame];
}

- (void)setModel:(NEStreamModel *)model{

    _model = model;
    int index = (int)model.context.count;
    NEContextModel *context = model.context[arc4random_uniform(index)];
    
    //设置大图
    [self.shopImage_view sd_setImageWithURL:[NSURL URLWithString:context.image] placeholderImage:[UIImage imageNamed:@"shopImage"]];
    
    
//    //设置左上角按钮
    [self.logo_imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"shopping"]];

    self.name_lable.text = model.name;

     self.title_lable.text = context.title;
    
//设置大图下边文字
    self.disc_lable.text = context.subtitle;
    [self.bottom_leftbtn setTitle:context.btn forState:UIControlStateNormal];
    self.buttomText_lable.text = context.subbtn;
    self.bottom_leftbtn.layer.cornerRadius = 5;
    self.bottom_leftbtn.clipsToBounds = YES;
    self.bottom_leftbtn.layer.borderWidth = 2;
    self.bottom_leftbtn.layer.borderColor = [UIColor redColor].CGColor;
    
    
}


@end
