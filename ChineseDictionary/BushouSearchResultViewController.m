//
//  BushouSearchResultViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/18.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "BushouSearchResultViewController.h"
#import "SearchResultView.h"
#import "Background.h"
#import "SearchResultCell.h"
#import "HanziDetailViewController.h"
@interface BushouSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) SearchResultView *searchResultView;
@property (strong, nonatomic) Background *background;
@property (strong, nonatomic) NSMutableDictionary *items;
@property (strong, nonatomic) NSArray *bihuas;

@end

@implementation BushouSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.background = [Background backgroundShare];
    self.bihuas = @[@"0-4画",@"5-9画",@"10-14画",@"15-19画",@"20画以上"];
    self.items = [NSMutableDictionary dictionary];
    [self getData];
    [self creatUI];
    NSLog(@"bushouserach view   bushou = %@",self.bushou);
    // Do any additional setup after loading the view.
}

- (void)getData
{
    [self.background getBackgroundDataWithBushouID:[self.bushou allValues][0] completionHandler:^(NSMutableArray *results, NSString *error) {
        if (error) {
            NSLog(@"error = %@",error);
        }
        else
        {
            NSLog(@"results = %@",results);
            NSMutableArray *bihua0_4 = [NSMutableArray array];
            NSMutableArray *bihua5_9 = [NSMutableArray array];
            NSMutableArray *bihua10_14 = [NSMutableArray array];
            NSMutableArray *bihua15_19 = [NSMutableArray array];
            NSMutableArray *bihua20_ = [NSMutableArray array];
            for (NSDictionary *dic  in results) {
                int dic_num = [dic[@"num"] intValue];
                if (dic_num < 5) {
                    [bihua0_4 addObject:dic];
                }
                else if (dic_num < 10)
                {
                    [bihua5_9 addObject:dic];
                }
                else if (dic_num < 15)
                {
                    [bihua10_14 addObject:dic];
                }
                else if (dic_num < 20)
                {
                    [bihua15_19 addObject:dic];
                }
                else if (dic_num > 19)
                {
                    [bihua20_ addObject:dic];
                }
            }
            [self.items setObject:bihua0_4 forKey:@"0-4画"];
            [self.items setObject:bihua5_9 forKey:@"5-9画"];
            [self.items setObject:bihua10_14 forKey:@"10-14画"];
            [self.items setObject:bihua15_19 forKey:@"15-19画"];
            [self.items setObject:bihua20_ forKey:@"20画以上"];
            NSLog(@"items = %@",self.items);
            for (int i = 0; i < self.bihuas.count; i++) {
                NSArray *arr = self.items[self.bihuas[i]];
                if (arr.count > 0)
                {
                    [self.searchResultView.segmentControl setTitle:self.bihuas[i] forSegmentAtIndex:i];
                    [self.searchResultView.segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:(UIControlEventValueChanged)];
                }
                else
                {
                    [self.searchResultView.segmentControl setEnabled:NO forSegmentAtIndex:i];
                }
            }
            [self.searchResultView.tableView reloadData];
        }
    }];
}
- (void)creatUI
{
    self.searchResultView = [[SearchResultView alloc] init];
    self.searchResultView.frame = self.view.frame;
    self.searchResultView.tableView.delegate = self;
    self.searchResultView.tableView.dataSource = self;
    self.searchResultView.titleLabel.text = [self.bushou allKeys][0];
    self.searchResultView.tableView.rowHeight = 60;
    [self.view addSubview:self.searchResultView];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            NSArray *arr = self.items[@"0-4画"];
            return arr.count;
        }
            break;
        case 1:
        {
            NSArray *arr = self.items[@"5-9画"];
            return arr.count;
        }
            break;
        case 2:
        {
            NSArray *arr = self.items[@"10-14画"];
            return arr.count;
        }
            break;
        case 3:
        {
            NSArray *arr = self.items[@"15-19画"];
            return arr.count;
        }
            break;
        case 4:
        {
            NSArray *arr = self.items[@"20画以上"];
            return arr.count;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SearchResultCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    [cell setCellInfoWithDic:self.items[self.bihuas[indexPath.section]][indexPath.row]];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    label.text = self.bihuas[section];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (void)segmentControlValueChanged:(UISegmentedControl *)sender
{
    [self.searchResultView.tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[sender selectedSegmentIndex]]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HanziDetailViewController *vc = [[HanziDetailViewController alloc] init];
//    id obj = self.items[self.bihuas[indexPath.section]];
//    NSLog(@"obj = %@",obj);
    NSDictionary *hanzi = self.items[self.bihuas[indexPath.section]][indexPath.row];
    NSLog(@"simp = %@",hanzi);
    vc.hanzi = hanzi;
    [self.navigationController pushViewController:vc animated:YES];
}
//- set
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
