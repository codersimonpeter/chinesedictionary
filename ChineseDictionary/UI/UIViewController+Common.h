//
//  UIViewController+Common.h
//  XXMusic
//
//  Created by lx刘逍 on 16/3/5.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)
- (void)tips:(NSString *)content animation:(BOOL)animation;
- (void)tipMore:(NSString *)content;
- (void)tipWithTime:(CGFloat)time content:(NSString *)content;
- (void)shouldOffsetWithView:(UIView *)subView interval:(CGFloat)interval;
- (void)makeViewInCenter;
@end
