//
//  NEClearCell.m
//  百思不得姐
//
//  Created by SMART on 15/9/7.
//  Copyright (c) 2015年 SMART. All rights reserved.
//

#import "NEClearCell.h"
#import <SVProgressHUD.h>


@interface NEClearCell ()
@property (nonatomic , copy) NSString *sizeText;
@end
@implementation NEClearCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"清理缓存";
        UIActivityIndicatorView * view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = view;
        [view startAnimating];
        //禁止与用户交互
        self.userInteractionEnabled = NO;
        
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
          NSUInteger size = [self getCacheSize];

            CGFloat unit = 1000.0;
            NSString *sizeText = nil;
            if (size > unit*unit*unit) {//>=1GB
                sizeText = [NSString stringWithFormat:@"%.1fGB",size/unit/unit/unit];
            }else if (size >= unit*unit){
            
            sizeText = [NSString stringWithFormat:@"%.1fMB",size/unit/unit];
            }else if (size >= unit){
                
                sizeText = [NSString stringWithFormat:@"%.1fKB",size/unit];
            }else{
                
                sizeText = [NSString stringWithFormat:@"%.1zdB",size];
            }
            
            self.sizeText = sizeText;
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.textLabel.text = text;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.accessoryView = nil;
                self.userInteractionEnabled = YES;
            }];
            
        }];
        
    }
 

    return self;
}



- (void)upDateStatus{
    if (self.accessoryView == nil)return;
    
   UIActivityIndicatorView *loadingView = (UIActivityIndicatorView*)self.accessoryView;
    [loadingView startAnimating];

}


- (void)clearCache{
    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    
    NSString * str = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        NSString *fileName = [str stringByAppendingPathComponent:@"default"];
        NSFileManager *mgr =  [NSFileManager defaultManager];
        [mgr removeItemAtPath:fileName error:nil];
//        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"共清理缓存%@",self.sizeText] maskType:SVProgressHUDMaskTypeClear];
        
            [SVProgressHUD showSuccessWithStatus:@"缓存清理成功"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [SVProgressHUD dismiss];
            self.textLabel.text = @"清理缓存";
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.userInteractionEnabled = NO;
        }];
    }];
    



}


- (NSInteger)getCacheSize{
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSString * str = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *fileName = [str stringByAppendingPathComponent:@"default"];
    NSFileManager *mgr =  [NSFileManager defaultManager];
    
    NSArray * subPaths = [mgr subpathsAtPath:fileName];
    NSUInteger size = 0;
    for (NSString *subPath  in subPaths) {
        
        NSString *fullName = [fileName stringByAppendingPathComponent:subPath];
        NSDictionary *dict = [mgr attributesOfItemAtPath:fullName error:nil];
        size += [dict[NSFileSize] integerValue];
//        self.textLabel.text = [NSString stringWithFormat:@"清除缓存(本地缓存%.1fM)",size/1000.0/1000.0];
    
    }
    
    return size;
}

@end
