//
//  SellManInfo.m
//  TTC_Broadband
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "SellManInfo.h"
@implementation SellManInfo
//单例
+ (SellManInfo *)sharedInstace{
    static SellManInfo * info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[SellManInfo alloc] init];
    });
    return info;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
//加载数据
- (void)loadSellManInfoWithRequestid:(NSString *)requestid loginname:(NSString *)loginname message:(NSString *)message name:(NSString *)name password:(NSString *)password returnCode:(NSString *)returnCode{
    _requestid = requestid;
    _loginname = loginname;
    _message = message;
    _name = name;
    _password = password;
    _requestid = requestid;
}
//加载工作部门信息
- (void)loadDepInfoName:(NSString *)depName ID:(NSString *)depID{
    _depName = depName;
    _depID = depID;
}

@end
