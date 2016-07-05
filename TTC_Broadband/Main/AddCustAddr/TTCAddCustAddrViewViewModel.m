//
//  TTCAddCustAddrViewViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCAddCustAddrViewViewModel.h"
//Model
#import "TTCAddCustAddrViewControllerModel.h"
#import "TTCAddCustAddrViewControllerOutputModel.h"
#import "TTCAddCustAddrViewControllerOutputHouseModel.h"
#import "TTCNewCustomViewControllerDictionaryModel.h"
@implementation TTCAddCustAddrViewViewModel
//获取地址列表
- (void)getAddressListWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid patchid:(NSString *)patchid addr:(NSString *)addr pagesize:(NSString *)pagesize currentPage:(NSString *)currentPage success:(SuccessBlock)success fail:(FailBlock)fail{
    
    [[NetworkManager sharedManager] GET:kAddAddressAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"areaid":areaid,@"patchid":patchid,@"addr":addr,@"pagesize":pagesize,@"currentPage":currentPage} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        if ([currentPage isEqualToString:@"1"]) {
            _dataAddressArray = [NSMutableArray array];
        }
        //获取数据
        TTCAddCustAddrViewControllerModel *vcModel = [[TTCAddCustAddrViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCAddCustAddrViewControllerOutputModel *outputModel = vcModel.output;
        for (TTCAddCustAddrViewControllerOutputHouseModel *houseModel in outputModel.houses) {
            [_dataAddressArray addObject:houseModel];
        }
        if (_dataAddressArray.count > 0) {
            success(nil);
        }else{
            _failMsg = vcModel.message;
            fail(nil);
        }
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询片区
- (void)getPatchSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"RES_PATCH"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataPatchArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataPatchArray addObject:dicModel];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询路线状态
- (void)getStatusSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"RES_HOUSE_STATUS"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataStatusArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataStatusArray addObject:dicModel];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询可安装业务
- (void)getPermarkSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_PERMARK"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataPermarkArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataPermarkArray addObject:dicModel];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询可安装业务
- (void)getAreaSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"PRV_AREA"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataAreaArray = [NSMutableArray array];
        _dataAreaNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataAreaArray addObject:dicModel];
            [_dataAreaNameArray addObject:dicModel.mname];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//根据片区ID返回片区名字
- (NSString *)transfromPatchNameWithPatchID:(NSString *)patchID{
    NSString *patchName = @"";
    for (TTCNewCustomViewControllerDictionaryModel *dicModel in _dataPatchArray) {
        if ([patchID isEqualToString:dicModel.mcode]) {
            patchName = dicModel.mname;
        }
    }
    return patchName;
}
//根据路线状态ID返回路线状态
- (NSString *)transfromStatusNameWithStatusID:(NSString *)statusID{
    NSString *statusName = @"";
    for (TTCNewCustomViewControllerDictionaryModel *dicModel in _dataStatusArray) {
        if ([statusID isEqualToString:dicModel.mcode]) {
            statusName = dicModel.mname;
        }
    }
    return statusName;
}
//根据可安装业务ID返回可安装业务
- (NSString *)transfromPermarkNameWithStatusID:(NSString *)permarkID{
    NSString *permarkName = @"";
    NSArray *perMarkArray = [permarkID componentsSeparatedByString:@","];
    for (NSString *permarkID in perMarkArray) {
        for (TTCNewCustomViewControllerDictionaryModel *dicModel in _dataStatusArray) {
            if ([permarkID isEqualToString:dicModel.mcode]) {
                permarkName = [NSString stringWithFormat:@"%@,%@",permarkName,dicModel.mname];
            }
        }
    }
    return permarkName;
}
//根据业务区名称返回业务区ID
- (NSString *)transfromAreaIDWithAreaName:(NSString *)AreaName{
    NSString *areaID = @"";
    for (TTCNewCustomViewControllerDictionaryModel *dicModel in _dataAreaArray) {
        if ([AreaName isEqualToString:dicModel.mname]) {
            areaID = dicModel.mcode;
        }
    }
    return areaID;
}

@end
