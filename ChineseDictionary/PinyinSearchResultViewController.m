//
//  PinyinSearchResultViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "PinyinSearchResultViewController.h"
#import "Background.h"
#import "SearchResultView.h"
#import "SearchResultCell.h"
#import "HanziDetailViewController.h"
#import "TitleLabel.h"

@interface PinyinSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) Background *background;
@property (strong, nonatomic) NSDictionary *items;
@property (strong, nonatomic) NSMutableArray *pinyins;
@property (strong, nonatomic) SearchResultView *searchResultView;

@end

@implementation PinyinSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.background = [Background backgroundShare];
    self.pinyins = [NSMutableArray array];
    [self creatUI];
    [self getData];
    // Do any additional setup after loading the view.
}
- (void)getData
{
    [self.background getBackgroundDataWithPinyin:self.pinyin completionHandler:^(NSMutableArray *results, NSString *error) {
        if (error) {
            NSLog(@"error = %@",error);
        }
        else
        {
            NSMutableArray *yins = [NSMutableArray array];
            for (NSDictionary *word in results) {
                NSString *yin = word[@"yin"][@"pinyin"];
                    if ([yins containsObject:yin] == NO) {
                        [yins addObject:yin];
                    }
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int i = 0; i < yins.count; i++)
            {
                NSMutableArray *valueArray = [NSMutableArray array];
                for (NSDictionary *word in results) {
                    NSString *yin = word[@"yin"][@"pinyin"];
                    if ([yin isEqualToString:yins[i]]) {
                        [valueArray addObject:word];
                    }
                }
                [dic setObject:valueArray forKey:yins[i]];
            }
            self.items = dic;
            self.pinyins = yins;
            NSLog(@"items = %@",self.items);
            for (int i = 0; i < self.pinyins.count; i++) {
                if (i > 4) {
                    break;
                }
                [self.searchResultView.segmentControl setTitle:self.pinyins[i] forSegmentAtIndex:i];
                [self.searchResultView.segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:(UIControlEventValueChanged)];
            }
            [self.searchResultView.tableView reloadData];

        }
    }];
}
- (void)creatUI
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"检索结果" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    TitleLabel *title = [[TitleLabel alloc] initWithTitle:self.pinyin];
    self.navigationItem.titleView = title;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.searchResultView = [[SearchResultView alloc] init];
    self.searchResultView.frame = self.view.frame;
    self.searchResultView.tableView.delegate = self;
    self.searchResultView.tableView.dataSource = self;
    self.searchResultView.titleLabel.text = self.pinyin;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    for (int i = 0; i < self.pinyins.count; i++) {
        if (section == i) {
            label.text = [NSString stringWithFormat:@"    %@",self.pinyins[i]];
        }
    }
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.pinyins.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section = %ld",section);
    NSArray *it = self.items[self.pinyins[section]];
    return it.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SearchResultCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    [cell setCellInfoWithDic:self.items[self.pinyins[indexPath.section]][indexPath.row]];
    return cell;
}

- (void)segmentControlValueChanged:(UISegmentedControl *)sender
{
//    NSLog(@"select:%ld",[sender selectedSegmentIndex]);
    [self.searchResultView.tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[sender selectedSegmentIndex]]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //todo
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HanziDetailViewController *vc = [[HanziDetailViewController alloc] init];
    NSLog(@"simp = %@",self.items[self.pinyins[indexPath.section]][indexPath.row][@"simp"]);
    vc.hanzi = self.items[self.pinyins[indexPath.section]][indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
