//
//  HanziEntity.h
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HanziEntity : NSObject
@property (strong, nonatomic) NSString *simp;
@property (strong, nonatomic) NSArray *yin;
@property (strong, nonatomic) NSString *tra;
@property (strong, nonatomic) NSString *frame;
@property (strong, nonatomic) NSString *create;
@property (strong, nonatomic) NSString *bushou;
@property (strong, nonatomic) NSString *bsnum;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *seq;
@property (strong, nonatomic) NSString *sound;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (NSDictionary *)findPinyin;
+ (NSDictionary *)finBushou;
@end
