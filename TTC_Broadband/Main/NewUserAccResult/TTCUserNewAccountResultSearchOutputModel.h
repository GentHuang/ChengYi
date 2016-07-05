//
//  TTCUserAccountResultSearchOutputModel.h
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCUserNewAccountResultSearchOutputModel : NSObject

@property (strong , nonatomic) NSMutableArray *tmpsustOrderList;

@end

@interface TTCUserAccountResultSearchMessageModel : NSObject
//订单编号
@property (strong , nonatomic) NSString *ordercode;
//BOSS受理时间
@property (strong , nonatomic) NSString *bossserialno;
//订单状态
@property (strong , nonatomic) NSString *orderstatus;
//操作时间
@property (strong , nonatomic) NSString *optime;

//other String
@property (strong , nonatomic) NSString *areaid;
@property (strong , nonatomic) NSString *bossdate;
@property (strong , nonatomic) NSString *city;
@property (strong , nonatomic) NSString *custid;
@property (strong , nonatomic) NSString *describe;
@property (strong , nonatomic) NSString *failmemo;
@property (strong , nonatomic) NSString *id_config;
@property (strong , nonatomic) NSString *opcode;
@property (strong , nonatomic) NSString *operator_config;
@property (strong , nonatomic) NSString *oprdep;
@property (strong , nonatomic) NSString *orderid;
@property (strong , nonatomic) NSString *status;
@property (strong , nonatomic) NSString *synctime;
@property (strong , nonatomic) NSString *systemid;
/*
 "areaid" : null,
 "bossdate" : "2016-01-29T18:18:44",
 "bossserialno" : null,
 "city" : null,
 "custid" : 8761130,
 "describe" : null,
 "failmemo" : "新开户住宅地址ID[12873770]已经被使用！",
 "id" : 502,
 "opcode" : "BIZ_USER_NEW",
 "operator" : 0,
 "oprdep" : 6804,
 "optime" : "2016-01-29T18:13:24",
 "ordercode" : null,
 "orderid" : 55069,
 "orderstatus" : "FAIL",
 "status" : "N",
 "synctime" : "2016-01-29T18:13:24",
 "systemid" : null
 
 */


@end