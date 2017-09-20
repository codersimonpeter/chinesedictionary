//
//  MessageLabel.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/17.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "MessageLabel.h"

@implementation MessageLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
