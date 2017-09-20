//
//  SearchTableViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/19.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "SearchTableViewController.h"
#import "Background.h"
#import "UIViewController+Common.h"
#import "LoadingImageView.h"
#import "HanziDetailViewController.h"

@interface SearchTableViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *history;
@property (strong, nonatomic) Background *background;
@property (strong, nonatomic) LoadingImageView *loadingImageView;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.background = [Background backgroundShare];
    self.history = [NSMutableArray array];
    [self creatUI];
    [self getData];
}
- (void)creatUI
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"清空历史" style:(UIBarButtonItemStyleDone) target:self action:@selector(clearHistory)];
    self.navigationItem.rightBarButtonItem = right;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"历史" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight = 40;
    self.loadingImageView = [[LoadingImageView alloc] init];
    self.loadingImageView.hidden = YES;
    [self.navigationController.view addSubview:self.loadingImageView];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    
}
- (void)clearHistory
{
    NSArray *clearHistory = [NSArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:clearHistory forKey:@"history"];
    [userDefaults synchronize];
    self.history = [NSMutableArray arrayWithArray:clearHistory];
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    NSString *keyWord = searchBar.text;
    if (keyWord.length > 1) {
        NSLog(@"输入有误");
        [self.navigationController tipMore:@"输入有误"];
        return;
    }
    if([searchBar.text characterAtIndex:0] > 0x4e00 && [searchBar.text characterAtIndex:0] < 0x9fff)
    {
        NSLog(@"是中文");
        [self requestDataWithWord:searchBar.text];
    }
    else
    {
        NSLog(@"不是中文");
        [self.navigationController tipMore:@"请输入中文"];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    label.text = @"查询历史";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return label;
}
- (void)getData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.history = [userDefaults objectForKey:@"history"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.history[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self requestDataWithWord:self.history[indexPath.row]];

}
- (void)requestDataWithWord:(NSString *)keyWord
{
    self.loadingImageView.hidden = NO;
    [self.background getHanziDetailWithWord:keyWord completionHandler:^(NSDictionary *result, NSString *error) {
        if (error) {
            [self.navigationController tipMore:error];
        }
        else if (result == nil)
        {
            [self.navigationController tipMore:@"查询结果为空"];
        }
        else
        {
            self.loadingImageView.hidden = YES;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSArray *history = [userDefaults objectForKey:@"history"];
            NSMutableArray *mHistory = [NSMutableArray arrayWithArray:history];
            if (![mHistory containsObject:keyWord]) {
                [mHistory addObject:keyWord];
                [userDefaults setObject:[NSArray arrayWithArray:mHistory] forKey:@"history"];
                [userDefaults synchronize];
                self.history = mHistory;
                [self.tableView reloadData];
            }
            NSLog(@"查询结果为%@",result);
            HanziDetailViewController *vc = [HanziDetailViewController new];
            vc.hanzi = result[@"baseinfo"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
