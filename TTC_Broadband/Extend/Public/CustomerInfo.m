//
//  CustomerInfo.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "CustomerInfo.h"

@implementation CustomerInfo
//单例
+ (CustomerInfo *)shareInstance{
    static CustomerInfo * info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[CustomerInfo alloc] init];
    });
    return info;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    key = nil;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return key;
}
//暂存客户数据
- (void)loadCustomerInfoAddr:(NSString *)addr areaid:(NSString *)areaid cardno:(NSString *)cardno cardtype:(NSString *)cardtype city:(NSString *)city custid:(NSString *)custid custname:(NSString *)custname maintaindev:(NSString *)maintaindev markno:(NSString *)markno message:(NSString *)message mobile:(NSString *)mobile pgroupid:(NSString *)pgroupid pgroupname:(NSString *)pgroupname phone:(NSString *)phone returnCode:(NSString *)returnCode{
    _addr =addr;
    _areaid = areaid;
    _cardno = cardno;
    _cardtype = cardtype;
    _city = city;
    _custid = custid;
    _custname = custname;
    _maintaindev = maintaindev;
    _markno = markno;
    _message = message;
    _mobile = mobile;
    _pgroupid = pgroupid;
    _pgroupname = pgroupname;
    _phone = phone;
    _returnCode = returnCode;
}
@end
