//
//  CollectionTableViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "SearchResultCell.h"
#import "HanziDetailViewController.h"

@interface CollectionTableViewController ()
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"收藏页面");
    self.items = [NSMutableArray array];
    [self creatUI];
    [self getData];
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)creatUI
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 60;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
}

- (void)getData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefaults objectForKey:@"collection"];
    self.items = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tap delete");
    NSDictionary *item = self.items[indexPath.row];
    [self.items removeObject:item];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *collection = [userDefaults objectForKey:@"collection"];
    NSMutableArray *mCollection = [NSMutableArray arrayWithArray:collection];
    if ([mCollection containsObject:item]) {
        [mCollection removeObject:item];
        [userDefaults setObject:[NSArray arrayWithArray:mCollection] forKey:@"collection"];
    }
    [userDefaults synchronize];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"移除";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    SearchResultCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SearchResultCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    [cell setCellInfoWithDic:self.items[indexPath.row][@"hanzi"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [NSArray arrayWithArray:self.items];
    NSLog(@"selected %@",arr);
    
    HanziDetailViewController *vc = [HanziDetailViewController new];
    vc.hanzi = arr[indexPath.row][@"hanzi"];
    vc.hanziDetailDic = arr[indexPath.row][@"hanziDetail"];
    [self.navigationController pushViewController:vc animated:YES];
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
