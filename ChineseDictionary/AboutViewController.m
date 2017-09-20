//
//  AboutViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/19.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "AboutViewController.h"
#import <Masonry.h>

#define MCELLSIZE [UIScreen mainScreen].bounds.size.height/64

@interface AboutViewController ()
@property (strong, nonatomic) NSString *introduce;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.introduce = @"应用简介:\n该应用可帮助您快速查找汉语生词\n\n作者:\n微博:@coder_Simon\n邮箱:350400115@qq.com";
    [self creatUI];
    // Do any additional setup after loading the view.
}

- (void)creatUI
{
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    iconImageView.image = [UIImage imageNamed:@"icon"];
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(MCELLSIZE * 7);
        make.height.mas_equalTo(iconImageView.mas_width);
    }];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    versionLabel.text = @"当前版本: v  1.0";
    versionLabel.font = [UIFont systemFontOfSize:14];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
//    textView.canBecomeFirstResponder = NO;
    
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor lightGrayColor];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:16];
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    textView.userInteractionEnabled = NO;
    textView.text = self.introduce;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(versionLabel.mas_bottom).offset(10);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(200);
    }];
    
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
