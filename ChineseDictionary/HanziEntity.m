//
//  HanziEntity.m
//  ChineseDictionary
//
//  Created by lx刘逍 on 16/3/16.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "HanziEntity.h"
#import <FMDB.h>
@implementation HanziEntity

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (NSString *)findDB
{
    NSString *orginalPath = [[NSBundle mainBundle] pathForResource:@"aaaaa" ofType:@"sqlite"];
    NSString *docPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/aaaaa.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:docPath]) {
        NSError *error = nil;
        [fileManager copyItemAtPath:orginalPath toPath:docPath error:&error];
        if (error) {
            NSLog(@"error = %@",error.localizedDescription);
        }
    }
    return docPath;
}
+ (NSDictionary *)findPinyin
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableArray *pinyinHead = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:[self findDB]];
    if ([db open]) {
        NSString *sql = @"select * from ol_pinyins where rowid < 27";
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            [pinyinHead addObject:[set stringForColumn:@"pinyin"]];
        }
        for (NSString *head in pinyinHead) {
            NSMutableArray *pinyin = [NSMutableArray array];
            NSString *sqli = [NSString stringWithFormat:@"select * from ol_pinyins where rowid > 26 and pinyin LIKE '%@%%'",head];
            FMResultSet *seti = [db executeQuery:sqli];
            while ([seti next]) {
                [pinyin addObject:[seti stringForColumn:@"pinyin"]];
            }
            [dictionary setObject:pinyin forKey:head];
        }
    }
    [db close];
    return dictionary;
}

+ (NSDictionary *)finBushou
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableArray *bihuas = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:[self findDB]];
    if ([db open]) {
        NSString *sql = @"select * from ol_bushou";
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            int bihuaInt = [set intForColumn:@"bihua"];
            NSString *bihua = [NSString stringWithFormat:@"%d",bihuaInt];
            if (![bihuas containsObject:bihua]) {
                [bihuas addObject:bihua];
            }
        }
        for (NSString *bihua in bihuas) {
            NSMutableArray *bushous = [NSMutableArray array];
            NSString *sqli = [NSString stringWithFormat:@"select * from ol_bushou where bihua = %d",[bihua intValue]];
            FMResultSet *set2 = [db executeQuery:sqli];
            while ([set2 next]) {
                NSMutableDictionary *bushou = [NSMutableDictionary dictionary];
                NSString *bushouStr = [set2 stringForColumn:@"title"];
                NSString *bushouNum = [set2 stringForColumn:@"id"];
                [bushou setObject:bushouNum forKey:bushouStr];
                [bushous addObject:bushou];
            }
            [dictionary setObject:bushous forKey:bihua];
        }
        
    }
    [db close];
    return dictionary;
}

@end
