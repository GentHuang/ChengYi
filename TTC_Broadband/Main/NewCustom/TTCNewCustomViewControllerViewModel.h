//
//  TTCNewCustomViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCNewCustomViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataAreaNameArray;
@property (strong, nonatomic) NSMutableArray *dataAreaIDArray;
@property (strong, nonatomic) NSMutableArray *dataCardTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataCardTypeIDArray;
@property (strong, nonatomic) NSMutableArray *dataCustomTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataCustomTypeIDArray;
@property (strong, nonatomic) NSMutableArray *dataShareNameArray;
@property (strong, nonatomic) NSMutableArray *dataShareIDArray;
@property (strong, nonatomic) NSMutableArray *dataCustomSubTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataCustomSubTypeIDArray;
@property (strong, nonatomic) NSString *dataCardTypeIDString;
@property (strong, nonatomic) NSString *dataCustomTypeIDString;
@property (strong, nonatomic) NSString *dataCustomSubTypeIDString;
@property (strong, nonatomic) NSString *dataShareIDString;
@property (strong, nonatomic) NSString *dataAreaNameString;
@property (strong, nonatomic) NSString *failMsg;
@property (strong, nonatomic) NSString *markNum;
//根据名称返回对应的ID
- (void)transfromCardType:(NSString *)cardTypeString customType:(NSString *)customTypeString customSubType:(NSString *)customSubTypeString share:(NSString *)shareString;
//新建客户
- (void)createNewCustomWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid markno:(NSString *)markno custType:(NSString *)custType subtype:(NSString *)subtype cardType:(NSString *)cardType cardNo:(NSString *)cardNo linkaddr:(NSString *)linkaddr linkman:(NSString *)linkman mobile:(NSString *)mobile phone:(NSString *)phone memo:(NSString *)memo topmemo:(NSString *)topmemo name:(NSString *)name success:(SuccessBlock)success fail:(FailBlock)fail;
//查询业务区
- (void)getAreaSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询证件类型
- (void)getCardTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询客户类型
- (void)getCustomTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询农村文化共享户
- (void)getShareSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询客户子类型
- (void)getCustomSubTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//根据ID返回名称
- (void)transfromAreaID:(NSString *)areaID;
@end
