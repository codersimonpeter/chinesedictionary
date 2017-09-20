//
//  LoadingImageView.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "LoadingImageView.h"

@implementation LoadingImageView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (self) {
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i < 12; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-%d.tiff",i+1]];
//            UIImage *ima = [UIImage imageNamed:@"loading-1"]
            [images addObject:image];
        }
        self.animationImages = images;
        self.animationDuration = 0.25;
        [self startAnimating];
        
        
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
