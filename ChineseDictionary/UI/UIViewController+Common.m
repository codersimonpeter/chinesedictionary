//
//  UIViewController+Common.m
//  XXMusic
//
//  Created by lx刘逍 on 16/3/5.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)
- (void)tips:(NSString *)content animation:(BOOL)animation
{
    static UILabel *tipsLabel;
    if (!tipsLabel) {
        tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        tipsLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        tipsLabel.center = CGPointMake(160, 380);
        tipsLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height * 0.5);
        tipsLabel.font = [UIFont systemFontOfSize:20];
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.layer.cornerRadius = 10;
        tipsLabel.layer.masksToBounds = YES;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:tipsLabel];
    }
    
    tipsLabel.text = content;
    tipsLabel.alpha = 1.0;
    if (animation) {
        [UIView animateWithDuration:2 animations:^{
            tipsLabel.alpha = 0;
        }];
    }
    else
    {
        [NSThread sleepForTimeInterval:1];
        tipsLabel.alpha = 0;
    }
    
    
}
- (void)tipMore:(NSString *)content
{
    static UILabel *tipsLabel;
    if (!tipsLabel) {
        tipsLabel = [[UILabel alloc] init];
        tipsLabel.font = [UIFont systemFontOfSize:16];
       tipsLabel.frame = CGRectMake(0, 0, [content length]*1.3*15, 15*1.3+3);
        tipsLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        tipsLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height * 0.5);
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.layer.cornerRadius = 8;
        tipsLabel.layer.masksToBounds = YES;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:tipsLabel];
    }
    tipsLabel.text = content;
    tipsLabel.alpha = 1.0;
    [UIView animateWithDuration:4 animations:^{
        tipsLabel.alpha = 0;
        tipsLabel = nil;
    }];
}
- (void)tipWithTime:(CGFloat)time content:(NSString *)content
{
    static UILabel *tipsLabel;
    if (!tipsLabel) {
        tipsLabel = [[UILabel alloc] init];
        tipsLabel.font = [UIFont systemFontOfSize:16];
        tipsLabel.frame = CGRectMake(0, 0, [content length]*1.3*15, 15*1.3+3);
        tipsLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        tipsLabel.center = CGPointMake(160, 300);
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.layer.cornerRadius = 8;
        tipsLabel.layer.masksToBounds = YES;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:tipsLabel];
    }
    tipsLabel.text = content;
    tipsLabel.alpha = 1.0;
    [UIView animateWithDuration:time animations:^{
        tipsLabel.alpha = 0;
        tipsLabel = nil;
    }];
}


- (void)shouldOffsetWithView:(UIView *)subView interval:(CGFloat)interval
{
    CGFloat offset = self.view.frame.size.height - (subView.frame.size.height+subView.frame.origin.y + 216 + interval);//英文键盘默认高度216
    if (offset <= 0) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
        
    }
}


- (void)makeViewInCenter
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}
@end
