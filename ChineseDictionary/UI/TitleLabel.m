//
//  TitleLabel.m
//  XXMusicPlayer
//
//  Created by lx刘逍 on 16/1/29.
//  Copyright © 2016年 xiaoxiao. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.text = title;
        self.textColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, 60, 30);
        self.center = CGPointMake(180, 20);
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
