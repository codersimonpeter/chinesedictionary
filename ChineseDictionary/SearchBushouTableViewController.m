//
//  SearchBushouTableViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/18.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "SearchBushouTableViewController.h"
#import "HanziEntity.h"
#import "UIViewController+Common.h"
#import "BushouSearchResultViewController.h"

@interface SearchBushouTableViewController ()
@property (strong, nonatomic) NSDictionary *items;
@property (strong, nonatomic) NSArray *bihuas;
@property (strong, nonatomic) NSMutableArray *bushous;
@property (strong, nonatomic) NSMutableArray *bushouIDs;
@end

@implementation SearchBushouTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"searchBushouTableView");
    self.bushous = [NSMutableArray array];
    self.bushouIDs = [NSMutableArray array];
    self.items = [HanziEntity finBushou];
    self.bihuas = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17"];
    NSLog(@"bihuas = %@",self.bihuas);
    for (NSString *key in [self.items allKeys]) {
        NSArray *arr = self.items[key];
        for (NSDictionary *dic in arr) {
            NSArray *arrKeys = [dic allKeys];
            NSArray *arrValues = [dic allValues];
            [self.bushous addObject:arrKeys[0]];
            [self.bushouIDs addObject:arrValues[0]];
        }
    }
    
    [self creatUI];
    
    NSLog(@"items = %@",self.items);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)creatUI
{
    self.tableView.sectionIndexColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.bihuas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *str = [NSString stringWithFormat:@"%ld",section + 1];
    NSArray *rows = self.items[str];
    return rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.bihuas;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    label.font = [UIFont systemFontOfSize:25];
    label.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    for (int i = 0; i < self.bihuas.count; i++) {
        if (section == i) {
            label.text = [NSString stringWithFormat:@"   %@",self.bihuas[i]];
        }
    }
    NSLog(@"section = %ld",section);
    NSLog(@"text = %@",label.text);
    return label;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"bushou";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section+1];
    NSArray *rows = self.items[str];
    cell.textLabel.text = [rows[indexPath.row] allKeys][0];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"title = %@ index = %ld",title,index);
    [self.navigationController tips:title animation:YES];
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BushouSearchResultViewController *vc = [BushouSearchResultViewController new];
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section+1];
    NSArray *rows = self.items[str];
    vc.bushou = rows[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
        self.tableView.backgroundColor = [UIColor clearColor];
    }];
}


@end
