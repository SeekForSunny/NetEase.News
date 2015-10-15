//
//  NERecommentReadCell.m
//  NetEase.News
//
//  Created by SMART on 15/10/7.
//  Copyright © 2015年 SMART. All rights reserved.
//

#import "NERecommentReadCell.h"
#import "NERecommentReadModel.h"


#import <UIImageView+WebCache.h>

@interface NERecommentReadCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_view;

@property (weak, nonatomic) IBOutlet UILabel *title_lable;


@property (weak, nonatomic) IBOutlet UILabel *source_title;

@end

@implementation NERecommentReadCell

- (void)awakeFromNib {
    // Initialization code
    self.autoresizingMask = NO;
}


- (void)setFrame:(CGRect)frame{

    frame.origin.x = SMARTMaxMargin;
    frame.size.width -= 2*SMARTMaxMargin;
    frame.size.height -=2*SMARTMaxMargin;
    [super setFrame:frame];
}



- (void)setModel:(NERecommentReadModel *)model{
    _model = model;
    
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    self.title_lable.text = model.title;
    self.source_title.text = model.source;
    

}


- (IBAction)closeReson:(UIButton *)sender {
    
    SMARTFuncLog;
}


@end
