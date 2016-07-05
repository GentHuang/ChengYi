
//
//  LockInfo.m
//  TTC_Broadband
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "LockInfo.h"

@implementation LockInfo
//单例
+ (LockInfo *)sharedInstace{
    static LockInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[LockInfo alloc] init];
    });
    return info;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
//加载手势密码数据
- (void)loadName:(NSString *)name psw:(NSString *)psw{
    _name = name;
    _psw = psw;
}
@end
