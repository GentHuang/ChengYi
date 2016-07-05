//
//  TTCUpgradeViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/6.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCUpgradeViewControllerViewModel.h"
//Model
#import "TTCNewCustomViewControllerDictionaryModel.h"
#import "TTCNewUserViewControllerCreateModel.h"
#import "TTCNewUserViewControllerCreateOutputModel.h"
#import "TTCNewUserViewControllerCreateOutputAutoOpenDefModel.h"
#import "TTCNewUserViewControllerModel.h"
#import "TTCNewUserViewControllerOutputModel.h"


@implementation TTCUpgradeViewControllerViewModel
//开户
- (void)createNewUserWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid houseid:(NSString *)houseid addr:(NSString *)addr endaddr:(NSString *)endaddr openmode:(NSString *)openmode feekind:(NSString *)feekind custid:(NSString *)custid type:(NSString *)type servtype:(NSString *)servtype servrele:(NSString *)servrele stbno:(NSString *)stbno logicno:(NSString *)logicno cmno:(NSString *)cmno oldstbno:(NSString *)oldstbno oldlogicno:(NSString *)oldlogicno smnouseprop:(NSString *)smnouseprop stbuseprop:(NSString *)stbuseprop payway:(NSString *)payway success:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kNewUserAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"areaid":areaid,@"houseid":houseid,@"addr":addr,@"endaddr":endaddr,@"openmode":openmode,@"feekind":feekind,@"custid":custid,@"type":type,@"servtype":servtype,@"servrele":servrele,@"stbno":stbno,@"logicno":logicno,@"cmno":cmno,@"oldstbno":oldstbno,@"oldlogicno":oldlogicno,@"smnouseprop":smnouseprop,@"stbuseprop":stbuseprop,@"payway":payway} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //获取数据
        TTCNewUserViewControllerModel *vcModel = [[TTCNewUserViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        if ([vcModel.status isEqualToString:@"0"]) {
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
//查询收费类型
- (void)getFeeTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_CHARGETYPE"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataFeeTypeIDArray = [NSMutableArray array];
        _dataFeeTypeNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataFeeTypeNameArray addObject:dicModel.mname];
            [_dataFeeTypeIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询上门安装
- (void)getSetupSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_YES_NO"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataSetupIDArray = [NSMutableArray array];
        _dataSetupNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataSetupNameArray addObject:dicModel.mname];
            [_dataSetupIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询开户模式
- (void)getCreateModeWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd city:(NSString *)city areaId:(NSString *)areaId permark:(NSString *)permark success:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kCreateModeAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"city":city,@"areaId":areaId,@"permark":permark} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataPermarkArray = [NSMutableArray array];
        _dataPermarkNameArray = [NSMutableArray array];
        //获取数据
        TTCNewUserViewControllerCreateModel *vcModel = [[TTCNewUserViewControllerCreateModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCNewUserViewControllerCreateOutputModel *outputModel = vcModel.output;
        for (TTCNewUserViewControllerCreateOutputAutoOpenDefModel *defModel in outputModel.autoOpenDef) {
            [_dataPermarkArray addObject:defModel];
            [_dataPermarkNameArray addObject:[NSString stringWithFormat:@"%@ %@",defModel.memo,defModel.modememo]];
        }
        if (_dataPermarkArray.count > 0) {
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
//通过开户模式返回开户模式Model
- (id)transfromCreateModeWithCreateModeString:(NSString *)createModeString{
    id createModel;
    for (TTCNewUserViewControllerCreateOutputAutoOpenDefModel *defModel in _dataPermarkArray) {
        if ([createModeString isEqualToString:[NSString stringWithFormat:@"%@ %@",defModel.memo,defModel.modememo]]) {
            createModel = defModel;
        }
    }
    return createModel;
}
@end

