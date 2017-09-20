//
//  Background.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "Background.h"
//#define MGETPINYIN @""

@interface Background ()
@property (strong, nonatomic) AFHTTPRequestOperationManager *afManager;


@end

@implementation Background

+(instancetype)backgroundShare
{
    static Background *background;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        background = [[Background alloc] init];
    });
    return background;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.afManager = [AFHTTPRequestOperationManager new];
        self.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (void)getBackgroundDataWithPinyin:(NSString *)pinyin completionHandler:(void (^)(NSMutableArray *, NSString *))handler{
    NSString *url = [NSString stringWithFormat:@"http://www.chazidian.com/service/pinyin/%@/0/100",pinyin];
    [self.afManager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (!dic)
        {
            handler(nil,@"解析失败");
        }
        else
        {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"data"][@"words"]];
            for (NSDictionary *obj in arr) {
                NSLog(@"key count = %ld, value count = %ld",[obj allKeys].count,[obj allValues].count);
                NSArray *keys = [obj allKeys];
                for (NSString *key in keys) {
                    if ([[obj valueForKey:key] isKindOfClass:[NSNull class]]) {
                        [obj setValue:@"" forKey:key];
                    }
                }
            }
            handler(arr,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        handler(nil,error.localizedDescription);
    }];
}

- (void)getBackgroundDataWithBushouID:(NSString *)bushouID completionHandler:(void (^)(NSMutableArray *, NSString *))handler
{
    NSString *url = [NSString stringWithFormat:@"http://www.chazidian.com/service/bushou/%@/0/100", bushouID];
    [self.afManager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (!dic)
        {
            handler(nil,@"解析失败");
        }
        else
        {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"data"][@"words"]];
            for (NSDictionary *obj in arr) {
                NSLog(@"key count = %ld, value count = %ld",[obj allKeys].count,[obj allValues].count);
                NSArray *keys = [obj allKeys];
                for (NSString *key in keys) {
                    if ([[obj valueForKey:key] isKindOfClass:[NSNull class]]) {
                        [obj setValue:@"" forKey:key];
                    }
                }
            }
            handler(arr,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        handler(nil,error.localizedDescription);
    }];
}

- (void)getHanziDetailWithWord:(NSString *)word completionHandler:(void (^)(NSDictionary *, NSString *))handler
{
    NSString *originalUrl = [NSString stringWithFormat:@"http://www.chazidian.com/service/word/%@",word];
    NSString *url = [originalUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.afManager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (!dic)
        {
            handler(nil,@"查询失败");
        }
        else
        {
            NSDictionary *dict = dic[@"data"];
                NSArray *keys = [dict[@"baseinfo"] allKeys];
                for (NSString *key in keys) {
                    if ([[dict[@"baseinfo"] valueForKey:key] isKindOfClass:[NSNull class]]) {
                        [dict[@"baseinfo"] setValue:@"" forKey:key];
                    }
                }
            NSLog(@"dict = %@",dict);
            for (NSString *key in [dict allKeys]) {
                if ([[dict valueForKey:key] isKindOfClass:[NSString class]]) {
                    NSString *str = [dict valueForKey:key];
                    NSLog(@"str = %@",str);
                    str =  [str stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
                    [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
                    NSLog(@"change str = %@",str);
                    [dict setValue:str forKey:key];
                }
            }
            NSLog(@"dict = %@",dict);
            handler(dict,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        handler(nil,error.localizedDescription);
    }];

}



@end
