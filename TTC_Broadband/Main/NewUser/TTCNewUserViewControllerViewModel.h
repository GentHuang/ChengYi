//
//  TTCNewUserViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/5.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCNewUserViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataFeeTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataFeeTypeIDArray;
@property (strong, nonatomic) NSMutableArray *dataSetupNameArray;
@property (strong, nonatomic) NSMutableArray *dataSetupIDArray;
@property (strong, nonatomic) NSMutableArray *dataServeTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataServeTypeIDArray;
@property (strong, nonatomic) NSMutableArray *dataPayWayNameArray;
@property (strong, nonatomic) NSMutableArray *dataPayWayIDArray;
@property (strong, nonatomic) NSMutableArray *dataCardDeviceNameArray;
@property (strong, nonatomic) NSMutableArray *dataCardDeviceIDArray;
@property (strong, nonatomic) NSMutableArray *dataTopBoxDeviceNameArray;
@property (strong, nonatomic) NSMutableArray *dataTopBoxDeviceIDArray;
@property (strong, nonatomic) NSMutableArray *dataCMDeviceNameArray;
@property (strong, nonatomic) NSMutableArray *dataCMDeviceIDArray;
@property (strong, nonatomic) NSMutableArray *dataBroadSuffixNameArray;
@property (strong, nonatomic) NSMutableArray *dataBroadSuffixIDArray;
@property (strong, nonatomic) NSMutableArray *dataBroadSuffixCodeArray;
@property (strong, nonatomic) NSMutableArray *dataPermarkNameArray;
@property (strong, nonatomic) NSMutableArray *dataPermarkArray;
@property (strong, nonatomic) NSMutableArray *dataAddressArray;
@property (strong, nonatomic) NSMutableArray *dataAddressModelArray;
@property (strong, nonatomic) NSString *failMsg;
@property (strong, nonatomic) NSString *dataFeeTypeString;
@property (strong, nonatomic) NSString *dataSetupString;
@property (strong, nonatomic) NSString *dataPayWayString;
@property (strong, nonatomic) NSString *dataServeTypeString;
@property (strong, nonatomic) NSString *dataCardNumDeviceString;
@property (strong, nonatomic) NSString *dataTopBoxDeviceString;
@property (strong, nonatomic) NSString *dataCMDeviceString;
@property (strong, nonatomic) NSString *dataBroadSuffixString;
//开户
- (void)createNewUserWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid houseid:(NSString *)houseid addr:(NSString *)addr endaddr:(NSString *)endaddr openmode:(NSString *)openmode feekind:(NSString *)feekind custid:(NSString *)custid type:(NSString *)type servtype:(NSString *)servtype servrele:(NSString *)servrele stbno:(NSString *)stbno smno:(NSString *)smno cmno:(NSString *)cmno oldstbno:(NSString *)oldstbno oldlogicno:(NSString *)oldlogicno smnouseprop:(NSString *)smnouseprop stbuseprop:(NSString *)stbuseprop payway:(NSString *)payway cmuseprop:(NSString *)cmuseprop uname:(NSString *)uname passwrod:(NSString *)passwrod suffix:(NSString *)suffix success:(SuccessBlock)success fail:(FailBlock)fail;
//根据名称返回对应的ID
- (void)transfromFeeTypeWith:(NSString *)feeTypeString payWay:(NSString *)paywayString serveType:(NSString *)serveTypeString setup:(NSString *)setupString cardNumString:(NSString *)cardNumString topBoxString:(NSString *)topBoxString CMString:(NSString *)CMString broadSuffixString:(NSString *)broadSuffixString;
//查询收费类型
- (void)getFeeTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询上门安装
- (void)getSetupSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//通过开户模式返回开户模式Model
- (id)transfromCreateModeWithCreateModeString:(NSString *)createModeString;
//查询用户类型
- (void)getServeTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询支付方式
- (void)getPayWaySuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询智能卡设备来源
- (void)getCardDeviceSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询机顶盒设备来源
- (void)getTopBoxDeviceSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询EOC设备来源
- (void)getCMDeviceSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询宽带后缀
- (void)getBroadSuffixSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//根据地址获取houseID
- (NSString *)getHouseIDWithAddress:(NSString *)addressString;
//获取开户地址
- (void)getAddressWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd custid:(NSString *)custid areaid:(NSString *)areaid patchid:(NSString *)patchid addr:(NSString *)addr pagesize:(NSString *)pagesize currentPage:(NSString *)currentPage success:(SuccessBlock)success fail:(FailBlock)fail;
//查询开户模式
- (void)getCreateModeWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd city:(NSString *)city areaId:(NSString *)areaId permark:(NSString *)permark success:(SuccessBlock)success fail:(FailBlock)fail;
@end
