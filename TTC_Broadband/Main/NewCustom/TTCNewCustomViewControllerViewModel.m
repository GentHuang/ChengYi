//
//  TTCNewCustomViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCNewCustomViewControllerViewModel.h"
//Model
#import "TTCNewCustomViewControllerModel.h"
#import "TTCNewCustomViewControllerOutputModel.h"
#import "TTCNewCustomViewControllerOutputPubinfoModel.h"
#import "TTCNewCustomViewControllerDictionaryModel.h"

@implementation TTCNewCustomViewControllerViewModel
//新建客户
- (void)createNewCustomWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid markno:(NSString *)markno custType:(NSString *)custType subtype:(NSString *)subtype cardType:(NSString *)cardType cardNo:(NSString *)cardNo linkaddr:(NSString *)linkaddr linkman:(NSString *)linkman mobile:(NSString *)mobile phone:(NSString *)phone memo:(NSString *)memo topmemo:(NSString *)topmemo name:(NSString *)name success:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kNewCustomAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"areaid":areaid,@"markno":markno,@"custType":custType,@"subtype":subtype,@"cardType":cardType,@"cardNo":cardNo,@"linkaddr":linkaddr,@"linkman":linkman,@"mobile":mobile,@"phone":phone,@"memo":memo,@"topmemo":topmemo,@"name":name} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        TTCNewCustomViewControllerModel *vcModel = [[TTCNewCustomViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCNewCustomViewControllerOutputModel *outputModel = vcModel.output;
        if ([vcModel.status isEqualToString:@"0"]) {
            _markNum = outputModel.markno;
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
//查询业务区
- (void)getAreaSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"PRV_AREA"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataAreaNameArray = [NSMutableArray array];
        _dataAreaIDArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataAreaNameArray addObject:dicModel.mname];
            [_dataAreaIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询证件类型
- (void)getCardTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_CARD_TYPE"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataCardTypeIDArray = [NSMutableArray array];
        _dataCardTypeNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataCardTypeNameArray addObject:dicModel.mname];
            [_dataCardTypeIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询客户类型
- (void)getCustomTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_CUST_TYPE"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataCustomTypeIDArray = [NSMutableArray array];
        _dataCustomTypeNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataCustomTypeIDArray addObject:dicModel.mcode];
            [_dataCustomTypeNameArray addObject:dicModel.mname];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询农村文化共享户
- (void)getShareSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_YES_NO"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataShareIDArray = [NSMutableArray array];
        _dataShareNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataShareNameArray addObject:dicModel.mname];
            [_dataShareIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询客户子类型
- (void)getCustomSubTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_CUST_SUB_TYPE"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataCustomSubTypeIDArray = [NSMutableArray array];
        _dataCustomSubTypeNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataCustomSubTypeNameArray addObject:dicModel.mname];
            [_dataCustomSubTypeIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//根据名称返回对应的ID
- (void)transfromCardType:(NSString *)cardTypeString customType:(NSString *)customTypeString customSubType:(NSString *)customSubTypeString share:(NSString *)shareString{
    //初始化数据
    _dataCardTypeIDString = @"";
    _dataCustomTypeIDString = @"";
    _dataShareIDString = @"";
    _dataCustomSubTypeIDString = @"";
    NSInteger index = 0;
    //证件类型
    index = [_dataCardTypeNameArray indexOfObject:cardTypeString];
    if (index < 9999) {
        _dataCardTypeIDString = [_dataCardTypeIDArray objectAtIndex:index];
    }
    //客户类别
    index = [_dataCustomTypeNameArray indexOfObject:customTypeString];
    if (index < 9999) {
        _dataCustomTypeIDString = [_dataCustomTypeIDArray objectAtIndex:index];
    }
    //客户子类型
    index = [_dataCustomSubTypeNameArray indexOfObject:customSubTypeString];
    if (index < 9999) {
        _dataCustomSubTypeIDString = [_dataCustomSubTypeIDArray objectAtIndex:index];
    }
    //农村文化共享户
    index = [_dataShareNameArray indexOfObject:shareString];
    if (index < 9999) {
        _dataShareIDString = [_dataShareIDArray objectAtIndex:index];
    }
}
//根据ID返回名称
- (void)transfromAreaID:(NSString *)areaID{
    //初始化数据
    _dataAreaNameString = @"";
    NSInteger index = 0;
    //证件类型
    index = [_dataAreaIDArray indexOfObject:areaID];
    if (index < 9999) {
        _dataAreaNameString = [_dataAreaNameArray objectAtIndex:index];
    }
}
@end
