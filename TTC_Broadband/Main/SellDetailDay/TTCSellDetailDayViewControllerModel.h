//
//  TTCSellDetailDayViewControllerModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCSellDetailDayViewControllerModel : NSObject
@property (strong, nonatomic) NSMutableArray *ods;
@property (strong, nonatomic) NSString *id_conflict;
@property (strong, nonatomic) NSString *orderid;
@property (strong, nonatomic) NSString *ordercode;
@property (strong, nonatomic) NSString *mcode;
@property (strong, nonatomic) NSString *ucode;
@property (strong, nonatomic) NSNumber *factprice;
@property (strong, nonatomic) NSString *adddate;
@property (strong, nonatomic) NSString *Status;
@property (strong, nonatomic) NSString *isdel;
@property (strong, nonatomic) NSString *mname;
@property (strong, nonatomic) NSString *uname;
@property (strong, nonatomic) NSString *deptid;
@property (strong, nonatomic) NSString *deptname;
@property (strong, nonatomic) NSString *ordertype;
@property (strong, nonatomic) NSString *numerical;

@end
