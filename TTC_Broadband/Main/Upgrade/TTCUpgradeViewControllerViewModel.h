//
//  TTCUpgradeViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/6.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCUpgradeViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataFeeTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataFeeTypeIDArray;
@property (strong, nonatomic) NSMutableArray *dataSetupNameArray;
@property (strong, nonatomic) NSMutableArray *dataSetupIDArray;
@property (strong, nonatomic) NSMutableArray *dataPermarkNameArray;
@property (strong, nonatomic) NSMutableArray *dataPermarkArray;
@property (strong, nonatomic) NSString *failMsg;
//开户
- (void)createNewUserWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid houseid:(NSString *)houseid addr:(NSString *)addr endaddr:(NSString *)endaddr openmode:(NSString *)openmode feekind:(NSString *)feekind custid:(NSString *)custid type:(NSString *)type servtype:(NSString *)servtype servrele:(NSString *)servrele stbno:(NSString *)stbno logicno:(NSString *)logicno cmno:(NSString *)cmno oldstbno:(NSString *)oldstbno oldlogicno:(NSString *)oldlogicno smnouseprop:(NSString *)smnouseprop stbuseprop:(NSString *)stbuseprop payway:(NSString *)payway success:(SuccessBlock)success fail:(FailBlock)fail;
//查询开户模式
- (void)getCreateModeWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd city:(NSString *)city areaId:(NSString *)areaId permark:(NSString *)permark success:(SuccessBlock)success fail:(FailBlock)fail;
//查询收费类型
- (void)getFeeTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询上门安装
- (void)getSetupSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//通过开户模式返回开户模式Model
- (id)transfromCreateModeWithCreateModeString:(NSString *)createModeString;
@end
