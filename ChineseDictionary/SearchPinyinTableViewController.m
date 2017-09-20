//
//  SearchPinyinTableViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "SearchPinyinTableViewController.h"
#import "HanziEntity.h"
#import "PinyinSearchResultViewController.h"
#import "UIViewController+Common.h"
#import "TitleLabel.h"

@interface SearchPinyinTableViewController ()
//@property (strong,nonatomic) NSArray *arr;
@property (strong, nonatomic) NSDictionary *items;
@property (strong, nonatomic) NSArray *heads;
@end

@implementation SearchPinyinTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    self.items = [HanziEntity findPinyin];
    self.heads = [[self.items allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.tableView.sectionIndexColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
//    NSLog(@"dic = %@",self.items);

    
}

- (void)creatUI
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    TitleLabel *title = [[TitleLabel alloc] initWithTitle:@"拼音检索"];
    self.navigationItem.titleView = title;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *arr = [self.items allKeys];
    return arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    for (int i = 0; i < self.heads.count; i++) {
        if (section == i) {
            NSString *str = self.heads[i];
            NSArray *arr = [self.items valueForKey:str];;
            return arr.count;
        }
    }
    return 0;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.heads;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"title = %@ index = %ld",title,index);

    [self.navigationController tips:title animation:YES];
    return index;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
}
- (void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
        self.tableView.backgroundColor = [UIColor clearColor];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"pinyin";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    for (int i = 0; i < self.heads.count; i++) {
        if (indexPath.section == i) {
            NSString *str = self.heads[i];
            NSArray *arr = [self.items valueForKey:str];;
            cell.textLabel.text = arr[indexPath.row];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PinyinSearchResultViewController *vc = [PinyinSearchResultViewController new];
    vc.pinyin = cell.textLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    label.font = [UIFont systemFontOfSize:25];
    label.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    for (int i = 0; i < self.heads.count; i++) {
        if (section == i) {
            label.text = [NSString stringWithFormat:@"   %@",self.heads[i]];
        }
    }
    
    return label;
}



@end
