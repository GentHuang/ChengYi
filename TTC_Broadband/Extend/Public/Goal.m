//
//  Goal.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "Goal.h"

@implementation Goal
//单例
+ (Goal *)sharedInstace{
    static Goal *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[Goal alloc] init];
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
