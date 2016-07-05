//
//  CustomerInfo.h
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerInfo : NSObject
@property (strong, nonatomic) NSString *addr;
@property (strong, nonatomic) NSString *areaid;
@property (strong, nonatomic) NSString *cardno;
@property (strong, nonatomic) NSString *cardtype;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *custid;
@property (strong, nonatomic) NSString *custname;
@property (strong, nonatomic) NSString *maintaindev;
@property (strong, nonatomic) NSString *markno;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *pgroupid;
@property (strong, nonatomic) NSString *pgroupname;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *custtype;
@property (strong, nonatomic) NSString *areaname;
@property (strong, nonatomic) NSString *servtype;
//客户证号
@property (strong, nonatomic) NSString *icno;
//客户定位类型
@property (strong, nonatomic) NSString *type;
//客户现金余额
@property (assign, nonatomic) float feesums;
//客户现金余额
@property (assign, nonatomic) float cashsums;
//客户增值余额
@property (assign, nonatomic) float incrementsums;
//欠费总额
@property (assign, nonatomic) float arrearsun;
//未开票总额
@property (assign, nonatomic) float printCount;
//所有用户消息
@property (strong, nonatomic) NSMutableArray *allServsArray;
//所有未开票消息
@property (strong, nonatomic) NSMutableArray *allPrintInfoArray;
//所有地址信息
@property (strong, nonatomic) NSMutableArray *allAddrsArray;
//所有产品信息
@property (strong, nonatomic) NSMutableArray *allProductArray;
//所余额信息
@property (strong, nonatomic) NSMutableArray *allBalanceArray;
//管理停
@property (strong, nonatomic) NSString *stoptype;
//单例
+ (CustomerInfo *)shareInstance;
//暂存客户数据
- (void)loadCustomerInfoAddr:(NSString *)addr areaid:(NSString *)areaid cardno:(NSString *)cardno cardtype:(NSString *)cardtype city:(NSString *)city custid:(NSString *)custid custname:(NSString *)custname maintaindev:(NSString *)maintaindev markno:(NSString *)markno message:(NSString *)message mobile:(NSString *)mobile pgroupid:(NSString *)pgroupid pgroupname:(NSString *)pgroupname phone:(NSString *)phone returnCode:(NSString *)returnCode;
@end
