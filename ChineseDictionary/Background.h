//
//  Background.h
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface Background : NSObject

+ (instancetype)backgroundShare;
- (void)getBackgroundDataWithPinyin:(NSString *)pinyin completionHandler:(void(^)(NSMutableArray *results, NSString *error))handler;
- (void)getBackgroundDataWithBushouID:(NSString *)bushouID completionHandler:(void (^)(NSMutableArray *results, NSString *error))handler;
- (void)getHanziDetailWithWord:(NSString *)word completionHandler:(void(^)(NSDictionary *result, NSString *error))handler;
@end
