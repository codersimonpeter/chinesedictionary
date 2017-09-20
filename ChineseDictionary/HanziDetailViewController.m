//
//  HanziDetailViewController.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/17.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "HanziDetailViewController.h"
#import "Background.h"
#import "UIViewController+Common.h"
#import <WeiboSDK.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>

#define MFAYINREN @"xiaoyan"

@interface HanziDetailViewController ()<IFlySpeechSynthesizerDelegate>
@property (strong, nonatomic) Background *background;
@property (strong, nonatomic) IFlySpeechSynthesizer *speechSynthesizer;
@end

@implementation HanziDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.background = [Background backgroundShare];
    [self configIFlySpeech];

    
    [self creatUI];
    if (self.hanziDetailDic == nil) {
        NSLog(@"无数据");
        [self getData];
    }
    else
    {
        NSLog(@"有数据");
        self.hanziDetailView.detailLabel.text = self.hanziDetailDic[@"base"];
        [self.hanziDetailView setInfoWithDic:self.hanzi];
    }
    
    
    
    // Do any additional setup after loading the view.
}
- (void)creatUI
{
    self.hanziDetailView = [[HanziDetailView alloc] init];
    self.hanziDetailView.frame = self.view.frame;
    [self.view addSubview:self.hanziDetailView];
    [self.hanziDetailView.segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    [self.hanziDetailView.collectBtn addTarget:self action:@selector(collectinBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.hanziDetailView.fixBtn addTarget:self action:@selector(fixBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.hanziDetailView.coopyBtn addTarget:self action:@selector(coopyBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.hanziDetailView.shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.hanziDetailView.soundButton addTarget:self action:@selector(tapSoundBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
}
-(void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)configIFlySpeech
{
    self.speechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    self.speechSynthesizer.delegate = self;
    [self.speechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    [self.speechSynthesizer setParameter:MFAYINREN forKey:[IFlySpeechConstant VOICE_NAME]];
    [self.speechSynthesizer setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    
}
- (void)getData
{
    [self.background getHanziDetailWithWord:self.hanzi[@"simp"] completionHandler:^(NSDictionary *result, NSString *error) {
        if (error) {
            NSLog(@"error = %@",error);
        }
        else
        {
            NSLog(@"result = %@",result);
            for (NSString *key in [result allKeys]) {
                if ([[result valueForKey:key] isKindOfClass:[NSString class]] && [[result valueForKey:key] isEqualToString:@""]) {
                    [result setValue:@"暂无" forKey:key];
                }
            }
            self.hanziDetailDic = result;//
            self.hanzi = result[@"baseinfo"];
            NSString *keyWord = result[@"baseinfo"][@"simp"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSArray *history = [userDefaults objectForKey:@"history"];
            NSMutableArray *mHistory = [NSMutableArray arrayWithArray:history];
            if (![mHistory containsObject:keyWord]) {
                [mHistory addObject:keyWord];
                [userDefaults setObject:[NSArray arrayWithArray:mHistory] forKey:@"history"];
                [userDefaults synchronize];
            }
            [self.hanziDetailView setInfoWithDic:self.hanzi];
            self.hanziDetailView.detailLabel.text = result[@"base"];
        }
    }];
}

- (void)segmentControlValueChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.hanziDetailView.detailLabel.text = self.hanziDetailDic[@"base"];
            break;
        case 1:
            self.hanziDetailView.detailLabel.text = self.hanziDetailDic[@"hanyu"];
            break;
        case 2:
            self.hanziDetailView.detailLabel.text = self.hanziDetailDic[@"idiom"];
            break;
        case 3:
            self.hanziDetailView.detailLabel.text = self.hanziDetailDic[@"english"];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectinBtn:(UIButton *)sender
{
    NSLog(@"点击收藏");
    if (self.hanziDetailDic == nil) {
        [self.navigationController tipMore:@"正在加载数据，请等待"];
        return;
    }
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    NSArray *collection = [userDefalts objectForKey:@"collection"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.hanzi forKey:@"hanzi"];
    [dic setObject:self.hanziDetailDic forKey:@"hanziDetail"];
    if ([collection containsObject:dic]) {
        NSLog(@"已收藏");
        [self tipMore:@"您已收藏"];
    }
    else
    {
        NSMutableArray *mCollection = [NSMutableArray arrayWithArray:collection];
        [mCollection addObject:dic];
        [userDefalts setObject:[NSArray arrayWithArray:mCollection] forKey:@"collection"];
        [userDefalts synchronize];
        [self tipMore:@"收藏成功"];
    }
}

- (void)fixBtn:(UIButton *)sender
{
    BOOL paletteViewHidden = self.hanziDetailView.paletteView.hidden;
    if (paletteViewHidden == NO) {
        [self.hanziDetailView.paletteView clear];
        self.hanziDetailView.paletteView.hidden = YES;
    }
    else if (paletteViewHidden == YES)
    {
        self.hanziDetailView.paletteView.hidden = NO;
        [self tips:@"开始练习" animation:YES];
    }
}

- (void)shareBtn:(UIButton *)sender
{
    if ([WeiboSDK isWeiboAppInstalled] == NO) {
        NSLog(@"还没有安装微博");
    }
    else if([WeiboSDK isWeiboAppInstalled] == YES)
    {
        NSLog(@"已安装");
        if ([WeiboSDK registerApp:@"2848247398"]) {
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
            request.userInfo = @{@"ShareMessageFrom": @"HanziDetailViewController"};
            [WeiboSDK sendRequest:request];
            [WeiboSDK openWeiboApp];
        }
        else
        {
            NSLog(@"zhuceshibai");
        }
    }

}
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"测试数据 0001";
    return message;
}

- (void)coopyBtn:(UIButton *)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.hanziDetailView.detailLabel.text;
    [self tipMore:@"已复制到剪贴板"];
}
- (void)tapSoundBtn
{
    NSLog(@"tap sound");
    NSLog(@"sound = %@",self.hanzi[@"simp"]);
    [self.speechSynthesizer startSpeaking:self.hanzi[@"simp"]];
}
- (void)onCompleted:(IFlySpeechError *)error
{
    NSLog(@"结束");
    NSLog(@"error = %@",error);
}


@end
