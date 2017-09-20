//
//  ViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "ViewController.h"
#import "SearchPinyinTableViewController.h"
#import "SearchBushouTableViewController.h"
#import "MoreViewController.h"
#import "SearchTableViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    
}

- (void)creatUI
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //nav颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    //背景
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:(UIBarButtonItemStyleDone) target:self action:@selector(more)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"笑笑字典";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:37];
    titleLabel.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    //输入框
    UILabel *input = [[UILabel alloc] initWithFrame:CGRectZero];
    input.translatesAutoresizingMaskIntoConstraints = NO;///////////
    input.backgroundColor = [UIColor clearColor];
    input.userInteractionEnabled = YES;
    input.text = @"   请输入查询内容";
    input.textColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *tapInputView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedInputView)];
    [input addGestureRecognizer:tapInputView];
    input.font = [UIFont systemFontOfSize:14];
    input.layer.cornerRadius = 10;
    input.layer.borderWidth = 0.3;
    [self.view addSubview:input];
    //按拼音查
    UILabel *pinyin = [[UILabel alloc] initWithFrame:CGRectZero];
    pinyin.translatesAutoresizingMaskIntoConstraints = NO;
    pinyin.text = @"拼";
    pinyin.font = [UIFont systemFontOfSize:20];
    pinyin.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    pinyin.layer.borderWidth = 1;
    pinyin.layer.borderColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1].CGColor;
    pinyin.layer.cornerRadius = 10;
    pinyin.textAlignment = NSTextAlignmentCenter;
    pinyin.userInteractionEnabled = YES;
    [self.view addSubview:pinyin];
    UITapGestureRecognizer *tapPY = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPinyin:)];
    [pinyin addGestureRecognizer:tapPY];
    //按部首查
    UILabel *bushou = [[UILabel alloc] initWithFrame:CGRectZero];
    bushou.translatesAutoresizingMaskIntoConstraints = NO;
    bushou.text = @"部";
    bushou.font = [UIFont systemFontOfSize:20];
    bushou.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    bushou.layer.borderWidth = 1;
    bushou.layer.borderColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1].CGColor;
    bushou.layer.cornerRadius = 10;
    bushou.textAlignment = NSTextAlignmentCenter;
    bushou.userInteractionEnabled = YES;
    [self.view addSubview:bushou];
    UITapGestureRecognizer *tapBushou = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBushouBtn:)];
    [bushou addGestureRecognizer:tapBushou];
    
    UILabel *message4pinyin = [[UILabel alloc] initWithFrame:CGRectZero];
    message4pinyin.text = @"按拼音查";
    message4pinyin.translatesAutoresizingMaskIntoConstraints = NO;
    message4pinyin.font = [UIFont systemFontOfSize:14];
    message4pinyin.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    message4pinyin.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:message4pinyin];
    
    UILabel *message4bushou = [[UILabel alloc] initWithFrame:CGRectZero];
    message4bushou.text = @"按部首查";
    message4bushou.translatesAutoresizingMaskIntoConstraints = NO;
    message4bushou.font = [UIFont systemFontOfSize:14];
    message4bushou.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    message4bushou.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:message4bushou];
    
    //自动布局字典
    NSDictionary *dic = @{
                          @"titleLabel":titleLabel,
                          @"input":input,
                          @"pinyin":pinyin,
                          @"bushou":bushou,
                          @"pinyinMessage":message4pinyin,
                          @"bushouMessage":message4bushou
                          };
    
    NSArray *titleLabelCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[titleLabel]-80-|" options:0 metrics:nil views:dic];
    NSArray *titleLabelCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[titleLabel(60)]" options:0 metrics:nil views:dic];
    [self.view addConstraints:titleLabelCons1];
    [self.view addConstraints:titleLabelCons2];
    
    NSArray *inputCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-40-[input(40)]" options:0 metrics:nil views:dic];
    NSArray *inputCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[input]-40-|" options:0 metrics:nil views:dic];
    [self.view addConstraints:inputCons1];
    [self.view addConstraints:inputCons2];
    
    NSArray *pinyinCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[input]-30-[pinyin(50)]" options:0 metrics:nil views:dic];
    NSArray *pinyinCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[pinyin(50)]" options:0 metrics:nil views:dic];
    [self.view addConstraints:pinyinCons1];
    [self.view addConstraints:pinyinCons2];
    
    NSArray *bushouCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[input]-30-[bushou(50)]" options:0 metrics:nil views:dic];
    NSArray *bushouCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[bushou(50)]-80-|" options:0 metrics:nil views:dic];
    [self.view addConstraints:bushouCons1];
    [self.view addConstraints:bushouCons2];
    
    NSArray *messPinyinCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pinyin]-5-[pinyinMessage(20)]" options:0 metrics:nil views:dic];
    NSArray *messPinyinCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pinyinMessage(100)]" options:0 metrics:nil views:dic];
    NSLayoutConstraint *messPinyinCons3 = [NSLayoutConstraint constraintWithItem:message4pinyin attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:pinyin attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [self.view addConstraints:messPinyinCons1];
    [self.view addConstraints:messPinyinCons2];
    [self.view addConstraint:messPinyinCons3];
    
    NSArray *messBushouCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bushou]-5-[bushouMessage(20)]" options:0 metrics:nil views:dic];
    NSArray *messBushouCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[bushouMessage(100)]" options:0 metrics:nil views:dic];
    NSLayoutConstraint *messBushouCons3 = [NSLayoutConstraint constraintWithItem:message4bushou attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:bushou attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [self.view addConstraints:messBushouCons1];
    [self.view addConstraints:messBushouCons2];
    [self.view addConstraint:messBushouCons3];
    
}
- (void)tapPinyin:(UITapGestureRecognizer *)sender
{
    NSLog(@"tapPinyin");
    SearchPinyinTableViewController *vc = [SearchPinyinTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)tapBushouBtn:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap bushou");
    SearchBushouTableViewController *vc = [SearchBushouTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)more
{
    NSLog(@"tap more");
    MoreViewController *vc = [MoreViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapedInputView
{
    SearchTableViewController *vc = [SearchTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
