//
//  MoreViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/19.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "MoreViewController.h"
#import "EFAnimationViewController.h"

@interface MoreViewController ()
@property (strong, nonatomic) EFAnimationViewController *viewController;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
//    self.view.backgroundColor = [UIColor whiteColor];
    self.viewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
