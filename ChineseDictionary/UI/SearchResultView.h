//
//  SearchResultView.h
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultView : UIView
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UISegmentedControl *segmentControl;

@end
