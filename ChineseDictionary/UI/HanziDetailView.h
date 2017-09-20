//
//  HanziDetailView.h
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/17.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageLabel.h"
#import "PaletteView.h"

@interface HanziDetailView : UIView
@property (strong, nonatomic) UISegmentedControl *segmentControl;
@property (strong, nonatomic) UIButton *soundButton;
@property (strong, nonatomic) UITextView *detailLabel;
@property (strong, nonatomic) UIButton *collectBtn;
@property (strong, nonatomic) UIButton *fixBtn;
@property (strong, nonatomic) UIButton *coopyBtn;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) PaletteView *paletteView;

- (void)setInfoWithDic:(NSDictionary *)dic;

@end
