//
//  HanziDetailView.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/17.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "HanziDetailView.h"
#import <Masonry.h>

#define MCELLSIZE [UIScreen mainScreen].bounds.size.height/64

@interface HanziDetailView ()
@property (strong, nonatomic) UILabel *hanziLabel;
@property (strong, nonatomic) MessageLabel *pinyinLabel;
@property (strong, nonatomic) MessageLabel *fantiLabel;
@property (strong, nonatomic) MessageLabel *bushouLabel;
@property (strong, nonatomic) MessageLabel *bishunLabel;
@property (strong, nonatomic) MessageLabel *zhuyinLabel;
@property (strong, nonatomic) MessageLabel *jiegouLabel;
@property (strong, nonatomic) MessageLabel *bushoubihuaLabel;
@property (strong, nonatomic) MessageLabel *bihuaLabel;
@end

@implementation HanziDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {

        UIView *hanziView = [[UIView alloc] init];
        hanziView.translatesAutoresizingMaskIntoConstraints = NO;
        hanziView.backgroundColor = [UIColor clearColor];
        [self addSubview:hanziView];
        //hanziView约束
        [hanziView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.mas_top).offset(70);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height*3/16);
//            NSLog(@"height = %f",[UIScreen mainScreen].bounds.size.height*3/16);
//            106.5
        }];
        
        UIImageView *hanziImageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        hanziImageview.image = [UIImage imageNamed:@"banmizige"];
        hanziImageview.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:hanziImageview];
        
//        hanziImageview约束
        [hanziImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(hanziView.mas_left).offset(5);
            make.centerY.equalTo(hanziView.mas_centerY);
            make.width.mas_equalTo(MCELLSIZE * 7);
            make.height.equalTo(hanziImageview.mas_width);
        }];
        
        self.hanziLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.hanziLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.hanziLabel.textAlignment = NSTextAlignmentCenter;
        self.hanziLabel.font = [UIFont systemFontOfSize:50];
        [hanziImageview addSubview:self.hanziLabel];
//        hanziLabel约束
        [self.hanziLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hanziImageview.mas_width);
            make.height.equalTo(self.hanziLabel.mas_width);
            make.centerX.equalTo(hanziImageview.mas_centerX);
            make.centerY.equalTo(hanziImageview.mas_centerY);
        }];
        
        MessageLabel *pinyinMessage = [[MessageLabel alloc] init];
        pinyinMessage.translatesAutoresizingMaskIntoConstraints = NO;
        pinyinMessage.text = @"拼音:";
        [hanziView addSubview:pinyinMessage];
//        pinyinMessage约束
        [pinyinMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hanziView.mas_top).offset(MCELLSIZE);
            make.left.equalTo(hanziImageview.mas_right).offset(10);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*4);
        }];
        
        self.pinyinLabel = [[MessageLabel alloc] init];
        self.pinyinLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        self.pinyinLabel.backgroundColor = [UIColor greenColor];
        [hanziView addSubview:self.pinyinLabel];
//        self.pinyinLabel约束
        [self.pinyinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pinyinMessage.mas_right);
            make.top.equalTo(pinyinMessage.mas_top);
            make.height.mas_equalTo(pinyinMessage.mas_height);
            make.width.mas_equalTo(MCELLSIZE*5);
        }];
        
        self.soundButton = [[UIButton alloc] init];
        self.soundButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.soundButton setImage:[UIImage imageNamed:@"loud"] forState:(UIControlStateNormal)];
        [hanziView addSubview:self.soundButton];
        //        self.soundButton约束
        [self.soundButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hanziView.mas_top).offset(MCELLSIZE*0.3);
            make.left.equalTo(self.pinyinLabel.mas_right);
            make.width.mas_equalTo(30);
            make.height.equalTo(self.soundButton.mas_width);
        }];
        
        MessageLabel *zhuyinMessage = [[MessageLabel alloc] init];
        zhuyinMessage.translatesAutoresizingMaskIntoConstraints = NO;
        zhuyinMessage.text = @"注音:";
        [hanziView addSubview:zhuyinMessage];
//        zhuyinMessage约束
        [zhuyinMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hanziView.mas_top).offset(MCELLSIZE);
            make.left.equalTo(self.pinyinLabel.mas_right).offset(MCELLSIZE * 4);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*4);
        }];
        
        self.zhuyinLabel = [[MessageLabel alloc] init];
        self.zhuyinLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:self.zhuyinLabel];
//        self.zhuyinLabel约束
        [self.zhuyinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhuyinMessage.mas_top);
            make.left.equalTo(zhuyinMessage.mas_right);
            make.width.mas_equalTo(MCELLSIZE * 5);
            make.height.equalTo(zhuyinMessage.mas_height);
        }];
        
        MessageLabel *jiegouMessage = [[MessageLabel alloc] init];
        jiegouMessage.translatesAutoresizingMaskIntoConstraints = NO;
        jiegouMessage.text = @"结构:";
        [hanziView addSubview:jiegouMessage];
        //        jiegouMessage约束
        [jiegouMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhuyinMessage.mas_bottom).offset(MCELLSIZE);
            make.left.equalTo(self.pinyinLabel.mas_right).offset(MCELLSIZE * 4);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*4);
        }];
        
        self.jiegouLabel = [[MessageLabel alloc] init];
        self.jiegouLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:self.jiegouLabel];
        //        self.zhuyinLabel约束
        [self.jiegouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(jiegouMessage.mas_top);
            make.left.equalTo(jiegouMessage.mas_right);
            make.width.mas_equalTo(MCELLSIZE * 15);
            make.height.equalTo(jiegouMessage.mas_height);
        }];
        
        MessageLabel *bushoubihuaMessage = [[MessageLabel alloc] init];
        bushoubihuaMessage.translatesAutoresizingMaskIntoConstraints = NO;
        bushoubihuaMessage.text = @"部首笔画:";
        [hanziView addSubview:bushoubihuaMessage];
        //        bushoubihuaMessage约束
        [bushoubihuaMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(jiegouMessage.mas_bottom).offset(MCELLSIZE);
            make.left.equalTo(hanziView.mas_left).offset(MCELLSIZE * 17);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*7);
        }];
        
        self.bushoubihuaLabel = [[MessageLabel alloc] init];
        self.bushoubihuaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:self.bushoubihuaLabel];
//        self.bushoubihuaLabel约束
        [self.bushoubihuaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bushoubihuaMessage.mas_right);
            make.top.equalTo(bushoubihuaMessage.mas_top);
            make.height.mas_equalTo(bushoubihuaMessage.mas_height);
            make.width.mas_equalTo(MCELLSIZE * 2);
        }];
        
        MessageLabel *bihuaMessage = [[MessageLabel alloc] init];
        bihuaMessage.translatesAutoresizingMaskIntoConstraints = NO;
        bihuaMessage.text = @"笔画:";
        [hanziView addSubview:bihuaMessage];
//        bihuaMessage约束
        [bihuaMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bushoubihuaLabel.mas_right);
            make.top.equalTo(bushoubihuaMessage.mas_top);
            make.height.mas_equalTo(bushoubihuaMessage.mas_height);
            make.width.mas_equalTo(MCELLSIZE * 4);
        }];
        
        self.bihuaLabel = [[MessageLabel alloc] init];
        self.bihuaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:self.bihuaLabel];
//        self.bihuaLabel约束
        [self.bihuaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bihuaMessage.mas_right);
            make.top.equalTo(bushoubihuaMessage.mas_top);
            make.height.mas_equalTo(bushoubihuaMessage.mas_height);
            make.width.mas_equalTo(MCELLSIZE * 2);
        }];
        
        MessageLabel *fantiMessage = [[MessageLabel alloc] init];
        fantiMessage.translatesAutoresizingMaskIntoConstraints = NO;
        fantiMessage.text = @"繁体:";
        [hanziView addSubview:fantiMessage];
        //        fantiMessage约束
        [fantiMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pinyinMessage.mas_bottom).offset(MCELLSIZE);
            make.left.equalTo(hanziImageview.mas_right).offset(10);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*4);
        }];
        
        self.fantiLabel = [[MessageLabel alloc] init];
        self.fantiLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:self.fantiLabel];
        
        //        self.fantiLabel约束
        [self.fantiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(fantiMessage.mas_right);
            make.top.equalTo(fantiMessage.mas_top);
            make.height.mas_equalTo(fantiMessage.mas_height);
            make.width.mas_equalTo(MCELLSIZE*5);
        }];
        
        MessageLabel *bushouMessage = [[MessageLabel alloc] init];
        bushouMessage.translatesAutoresizingMaskIntoConstraints = NO;
        bushouMessage.text = @"部首:";
        [hanziView addSubview:bushouMessage];
        //        bushouMessage约束
        [bushouMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(fantiMessage.mas_bottom).offset(MCELLSIZE);
            make.left.equalTo(hanziImageview.mas_right).offset(10);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*4);
        }];
        
        self.bushouLabel = [[MessageLabel alloc] init];
        self.bushouLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [hanziView addSubview:self.bushouLabel];
        
        //        self.bushouLabel约束
        [self.bushouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bushouMessage.mas_right);
            make.top.equalTo(bushouMessage.mas_top);
            make.height.mas_equalTo(bushouMessage.mas_height);
            make.width.mas_equalTo(MCELLSIZE*3);
        }];
        
        MessageLabel *bishunMessage = [[MessageLabel alloc] init];
        bishunMessage.translatesAutoresizingMaskIntoConstraints = NO;
        bishunMessage.text = @"笔顺:";
        [hanziView addSubview:bishunMessage];
        //        bushouMessage约束
        [bishunMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bushouMessage.mas_bottom).offset(MCELLSIZE);
            make.left.equalTo(hanziImageview.mas_right).offset(10);
            make.height.mas_equalTo(MCELLSIZE*2);
            make.width.mas_equalTo(MCELLSIZE*4);
        }];
        
        self.bishunLabel = [[MessageLabel alloc] init];
        self.bishunLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bishunLabel.text = @"加载中";//todo
        [hanziView addSubview:self.bishunLabel];
        
        //        self.bishunLabel约束
        [self.bishunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bishunMessage.mas_right);
            make.top.equalTo(bishunMessage.mas_top);
            make.height.mas_equalTo(bishunMessage.mas_height);
            make.right.equalTo(hanziView.mas_right);
        }];
        
        NSArray *segItems = @[@"基本信息",@"汉语字典",@"组成词语",@"英文翻译"];
        self.segmentControl = [[UISegmentedControl alloc] initWithItems:segItems];
        self.segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
        self.segmentControl.frame = CGRectZero;
        self.segmentControl.tintColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        self.segmentControl.selectedSegmentIndex = 0;
        [self addSubview:self.segmentControl];
        //segment约束
        [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(hanziView.mas_bottom).offset(20);
            make.height.mas_equalTo(30);
        }];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"informatianlow"];
        [self addSubview:imageView];
        //imageView约束
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.segmentControl.mas_bottom).offset(30);
            make.bottom.equalTo(self.mas_bottom).offset(-55);
        }];
        
        self.detailLabel = [[UITextView alloc] init];
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.detailLabel setEditable:NO];
        self.detailLabel.font = [UIFont systemFontOfSize:14];//14
        self.detailLabel.text = @"正在加载...\nloading...";
        [imageView addSubview:self.detailLabel];
//        self.detailLabel约束
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_left).offset(20);
            make.right.equalTo(imageView.mas_right).offset(-10);
            make.top.equalTo(imageView.mas_top).offset(MCELLSIZE * 3);
            make.bottom.equalTo(imageView.mas_bottom).offset(-5);
        }];
        
        UIImageView *markView = [[UIImageView alloc] initWithFrame:CGRectZero];
        markView.translatesAutoresizingMaskIntoConstraints = NO;
        markView.image = [UIImage imageNamed:@"brooch"];
        [self addSubview:markView];
        //markView约束
        [markView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(40);
            make.right.equalTo(self.mas_right).offset(-13);
            make.centerY.equalTo(imageView.mas_top).offset(18);
        }];
        
        self.paletteView = [[PaletteView alloc] initWithFrame:CGRectZero];
        self.paletteView.translatesAutoresizingMaskIntoConstraints = NO;
        self.paletteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.paletteView.hidden = YES;
        [self addSubview:self.paletteView];
        [self.paletteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_left).offset(10);
            make.right.equalTo(imageView.mas_right).offset(-10);
            make.top.equalTo(imageView.mas_top).offset(MCELLSIZE);
            make.bottom.equalTo(imageView.mas_bottom).offset(-5);
        }];
        
        UIView *toolView = [[UIView alloc] initWithFrame:CGRectZero];
        toolView.translatesAutoresizingMaskIntoConstraints = NO;
        toolView.backgroundColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        [self addSubview:toolView];
        //toolView约束
        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        
        self.collectBtn = [[UIButton alloc] init];
        self.collectBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.collectBtn setImage:[UIImage imageNamed:@"star"] forState:(UIControlStateNormal)];
        [toolView addSubview:self.collectBtn];
//        self.collectBtn约束
        [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
            make.centerX.equalTo(toolView.mas_centerX).offset(MCELLSIZE * -4);
            make.centerY.equalTo(toolView.mas_centerY);
        }];
        
        self.fixBtn = [[UIButton alloc] init];
        self.fixBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.fixBtn setImage:[UIImage imageNamed:@"pen"] forState:(UIControlStateNormal)];
        [toolView addSubview:self.fixBtn];
        //        self.fixBtn约束
        [self.fixBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
            make.centerX.equalTo(toolView.mas_centerX).offset(MCELLSIZE * -14);
            make.centerY.equalTo(toolView.mas_centerY);
        }];
        
        self.coopyBtn = [[UIButton alloc] init];
        self.coopyBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.coopyBtn setImage:[UIImage imageNamed:@"document"] forState:(UIControlStateNormal)];
        [toolView addSubview:self.coopyBtn];
        //        self.coopyBtn约束
        [self.coopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
            make.centerX.equalTo(toolView.mas_centerX).offset(MCELLSIZE * 4);
            make.centerY.equalTo(toolView.mas_centerY);
        }];
        
        self.shareBtn = [[UIButton alloc] init];
        self.shareBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.shareBtn setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
        [toolView addSubview:self.shareBtn];
        //        self.coopyBtn约束
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
            make.centerX.equalTo(toolView.mas_centerX).offset(MCELLSIZE * 14);
            make.centerY.equalTo(toolView.mas_centerY);
        }];
        
        
    }
    return self;
}

- (void)setInfoWithDic:(NSDictionary *)dic
{
    self.hanziLabel.text = dic[@"simp"];
    self.pinyinLabel.text = dic[@"yin"][@"pinyin"];
    self.fantiLabel.text = dic[@"tra"];
    self.bushouLabel.text = dic[@"bushou"];
    self.zhuyinLabel.text = dic[@"yin"][@"zhuyin"];
    self.jiegouLabel.text = dic[@"frame"];
    self.bushoubihuaLabel.text = dic[@"bsnum"];
    self.bihuaLabel.text = dic[@"num"];
    self.bishunLabel.text = dic[@"seq"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
