//
//  SearchResultCell.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "SearchResultCell.h"
#import <Masonry.h>

@interface SearchResultCell ()
@property (strong, nonatomic) UILabel *hanziLabel;
@property (strong, nonatomic) UILabel *zhuyinLabel;
@property (strong, nonatomic) UILabel *bushouLabel;
@property (strong, nonatomic) UILabel *bihuaLabel;
@property (strong, nonatomic) UIImageView *hanziImageView;

@end

@implementation SearchResultCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.hanziImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.hanziImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.hanziImageView.image = [UIImage imageNamed:@"banmizige"];
//        self.hanziImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.hanziImageView];
        [self.hanziImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(self.hanziImageView.mas_width);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        
        self.hanziLabel = [[UILabel alloc] initWithFrame:self.hanziImageView.frame];
        self.hanziLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        self.hanziLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"banmizige"]];
        self.hanziLabel.textAlignment = NSTextAlignmentCenter;
        self.hanziLabel.font = [UIFont systemFontOfSize:30];
        [self.hanziImageView addSubview:self.hanziLabel];
        [self.hanziLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.hanziImageView.mas_centerX);
            make.centerY.equalTo(self.hanziImageView.mas_centerY);
            make.width.mas_equalTo(self.hanziImageView.mas_width);
            make.height.mas_equalTo(self.hanziImageView.mas_height);
        }];
        
        self.zhuyinLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.zhuyinLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.zhuyinLabel.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        self.zhuyinLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.zhuyinLabel];
        [self.zhuyinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hanziImageView.mas_right).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *bushout = [[UILabel alloc] initWithFrame:CGRectZero];
        bushout.translatesAutoresizingMaskIntoConstraints = NO;
        bushout.text = @"部首:";
        bushout.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        bushout.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:bushout];
        [bushout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hanziImageView.mas_right).offset(10);
            make.width.mas_equalTo(50);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.height.mas_equalTo(15);
        }];
        self.bushouLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.bushouLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bushouLabel.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        self.bushouLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.bushouLabel];
        [self.bushouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bushout.mas_right);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(bushout.mas_height);
            make.centerY.equalTo(bushout.mas_centerY);
        }];
        
//        self.soundButton = [[UIButton alloc] initWithFrame:CGRectZero];
//        self.soundButton.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.soundButton setBackgroundImage:[UIImage imageNamed:@"loud"] forState:(UIControlStateNormal)];
//        [self.contentView addSubview:self.soundButton];
        
        UILabel *bihuaT = [[UILabel alloc] initWithFrame:CGRectZero];
        bihuaT.translatesAutoresizingMaskIntoConstraints = NO;
        bihuaT.text = @"笔画:";
        bihuaT.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        bihuaT.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:bihuaT];
        [bihuaT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bushouLabel.mas_right);
            make.centerY.equalTo(self.bushouLabel.mas_centerY);
            make.height.mas_equalTo(self.bushouLabel.mas_height);
            make.width.mas_equalTo(50);
        }];
        
        self.bihuaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.bihuaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.bihuaLabel.textColor = [UIColor colorWithRed:160/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        self.bihuaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.bihuaLabel];
        [self.bihuaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bihuaT.mas_right);
            make.centerY.equalTo(bihuaT.mas_centerY);
            make.height.mas_equalTo(bihuaT.mas_height);
            make.width.mas_equalTo(20);
        }];
        
//        NSDictionary *dic = @{@"soundButton":self.soundButton,};
//        
//        NSArray *soundButtonCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[soundButton(20)]-100-|" options:0 metrics:nil views:dic];
//        NSArray *soundButtonCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[soundButton(20)]" options:0 metrics:nil views:dic];
//        [self.contentView addConstraints:soundButtonCons1];
//        [self.contentView addConstraints:soundButtonCons2];
        
        
    }
    return self;
}

- (void)setCellInfoWithDic:(NSDictionary *)dic
{
    self.hanziLabel.text = dic[@"simp"];
    self.zhuyinLabel.text = [NSString stringWithFormat:@"[%@]",dic[@"yin"][@"pinyin"]];
    self.bihuaLabel.text = dic[@"num"];
    self.bushouLabel.text = dic[@"bushou"];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
