//
//  SellManInfo.h
//  TTC_Broadband
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SellManInfo : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *loginname;
@property (strong, nonatomic) NSString *requestid;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *depName;
@property (strong, nonatomic) NSString *depID;
@property (strong, nonatomic) NSString *commission;
@property (strong, nonatomic) NSString *mSales;
@property (strong, nonatomic) NSString *dSales;
@property (strong, nonatomic) NSString *ranking;
@property (strong, nonatomic) NSString *md5PSW;
//单例
+ (SellManInfo *)sharedInstace;
//加载数据
- (void)loadSellManInfoWithRequestid:(NSString *)requestid loginname:(NSString *)loginname message:(NSString *)message name:(NSString *)name password:(NSString *)password returnCode:(NSString *)returnCode;
//加载工作部门信息
- (void)loadDepInfoName:(NSString *)depName ID:(NSString *)depID;
@end
