//
//  TTCAddAddressViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCAddAddressViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataAddressArray;
@property (strong, nonatomic) NSMutableArray *dataPatchNameArray;
@property (strong, nonatomic) NSMutableArray *dataPatchArray;
@property (strong, nonatomic) NSMutableArray *dataStatusNameArray;
@property (strong, nonatomic) NSMutableArray *dataStatusArray;
@property (strong, nonatomic) NSMutableArray *dataPermarkNameArray;
@property (strong, nonatomic) NSMutableArray *dataPermarkArray;
@property (strong, nonatomic) NSString *failMsg;
//获取地址列表
- (void)getAddressListWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid patchid:(NSString *)patchid addr:(NSString *)addr pagesize:(NSString *)pagesize currentPage:(NSString *)currentPage success:(SuccessBlock)success fail:(FailBlock)fail;
//查询片区
- (void)getPatchSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//查询路线状态
- (void)getStatusSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//根据片区ID返回片区名字
- (NSString *)transfromPatchNameWithPatchID:(NSString *)patchID;
//根据路线状态ID返回路线状态
- (NSString *)transfromStatusNameWithStatusID:(NSString *)statusID;
//查询可安装业务
- (void)getPermarkSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//根据可安装业务ID返回可安装业务
- (NSString *)transfromPermarkNameWithStatusID:(NSString *)permarkID;
@end
