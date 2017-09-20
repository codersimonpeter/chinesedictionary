//
//  FeedbackViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/19.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "FeedbackViewController.h"
#import <Masonry.h>
#import "UIViewController+Common.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *textView;
@property (copy, nonatomic) NSString *placeholder;
@property (strong, nonatomic) UIPanGestureRecognizer *pan;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTextView)];
    self.placeholder = @"我今天没吃药\n感觉自己萌萌哒";
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UITapGestureRecognizer *tapTheView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tapTheView];
    [self creatUI];

    // Do any additional setup after loading the view.
}
- (void)tapView:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)creatUI
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectZero];
    back.translatesAutoresizingMaskIntoConstraints = NO;
    back.image = [UIImage imageNamed:@"fankuikuang"];
    back.userInteractionEnabled = YES;
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(70);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
    }];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.showsVerticalScrollIndicator = YES;
    self.textView.textColor = [UIColor lightGrayColor];
    
    
    self.textView.text = self.placeholder;
    [back addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back.mas_left).offset(10);
        make.right.equalTo(back.mas_right).offset(-10);
        make.top.equalTo(back.mas_top).offset(10);
        make.bottom.equalTo(back.mas_bottom).offset(-10);
    }];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"完成并发送" style:(UIBarButtonItemStyleDone) target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)panTextView
{
    if ([self.textView isFirstResponder]) {
        [self.view endEditing:YES];
    }else
    {
        [self.textView removeGestureRecognizer:self.pan];
    }
    
}
- (void)send
{
    [self.view endEditing:YES];
    if ([self.textView.text isEqualToString:@""] || [self.textView.text isEqualToString:self.placeholder]) {
        [self tips:@"请先编辑" animation:YES];
    }
    else
    {
        NSLog(@"允许发送");
        [self.view endEditing:YES];
        [self tips:@"发送完成" animation:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"editing");
    [self.textView addGestureRecognizer:self.pan];
    if ([self.textView.text isEqualToString:self.placeholder]) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        self.textView.text = self.placeholder;
        self.textView.textColor = [UIColor lightGrayColor];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
    [super viewWillAppear:YES];
}
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.textView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    self.textView.contentInset=UIEdgeInsetsZero;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
