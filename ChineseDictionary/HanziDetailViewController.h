//
//  HanziDetailViewController.h
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/17.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HanziDetailView.h"

@interface HanziDetailViewController : UIViewController
@property (strong, nonatomic) HanziDetailView *hanziDetailView;
@property (copy, nonatomic) NSDictionary *hanzi;
@property (strong, nonatomic) NSDictionary *hanziDetailDic;

@end
