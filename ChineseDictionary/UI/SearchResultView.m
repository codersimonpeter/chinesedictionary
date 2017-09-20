//
//  SearchResultView.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "SearchResultView.h"

@interface SearchResultView ()

@end

@implementation SearchResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.titleLabel];
        
        NSArray *segItems = @[@"",@"",@"",@"",@""];
        self.segmentControl = [[UISegmentedControl alloc] initWithItems:segItems];
        self.segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
        self.segmentControl.frame = CGRectZero;
        self.segmentControl.selectedSegmentIndex = 0;
        self.segmentControl.tintColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        [self addSubview:self.segmentControl];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
        
        NSDictionary *dic = @{
                              @"title":self.titleLabel,
                              @"segment":self.segmentControl,
                              @"tableView":self.tableView,
                              };
        
        NSArray *titleLabelCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[title]-80-|" options:0 metrics:nil views:dic];
        NSArray *titleLabelCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[title(20)]" options:0 metrics:nil views:dic];
        [self addConstraints:titleLabelCons1];
        [self addConstraints:titleLabelCons2];
        
        
        NSArray *segCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[segment]-10-|" options:0 metrics:nil views:dic];
        NSArray *segCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[title]-15-[segment(30)]" options:0 metrics:nil views:dic];
        [self addConstraints:segCons1];
        [self addConstraints:segCons2];
        
        NSArray *tableViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:dic];
        NSArray *tableViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[segment]-5-[tableView]-0-|" options:0 metrics:nil views:dic];
        [self addConstraints:tableViewCons1];
        [self addConstraints:tableViewCons2];
        
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
