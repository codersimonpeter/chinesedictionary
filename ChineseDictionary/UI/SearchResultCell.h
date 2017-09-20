//
//  SearchResultCell.h
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
@property (strong, nonatomic) UIButton *soundButton;

- (void)setCellInfoWithDic:(NSDictionary *)dic;
@end
