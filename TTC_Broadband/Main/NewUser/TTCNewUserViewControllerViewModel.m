//
//  TTCNewUserViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/5.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerViewModel.h"
//Model
#import "TTCNewCustomViewControllerDictionaryModel.h"
#import "TTCNewUserViewControllerCreateModel.h"
#import "TTCNewUserViewControllerCreateOutputModel.h"
#import "TTCNewUserViewControllerCreateOutputAutoOpenDefModel.h"
#import "TTCNewUserViewControllerModel.h"
#import "TTCNewUserViewControllerOutputModel.h"
#import "TTCNewUserViewControllerAddressModel.h"
#import "TTCNewUserViewControllerAddressOutputModel.h"
#import "TTCNewUserViewControllerAddressOutputHouseModel.h"
@implementation TTCNewUserViewControllerViewModel
//开户
- (void)createNewUserWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd areaid:(NSString *)areaid houseid:(NSString *)houseid addr:(NSString *)addr endaddr:(NSString *)endaddr openmode:(NSString *)openmode feekind:(NSString *)feekind custid:(NSString *)custid type:(NSString *)type servtype:(NSString *)servtype servrele:(NSString *)servrele stbno:(NSString *)stbno smno:(NSString *)smno cmno:(NSString *)cmno oldstbno:(NSString *)oldstbno oldlogicno:(NSString *)oldlogicno smnouseprop:(NSString *)smnouseprop stbuseprop:(NSString *)stbuseprop payway:(NSString *)payway cmuseprop:(NSString *)cmuseprop uname:(NSString *)uname passwrod:(NSString *)passwrod suffix:(NSString *)suffix success:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kNewUserAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"areaid":areaid,@"houseid":houseid,@"addr":addr,@"endaddr":endaddr,@"openmode":openmode,@"feekind":feekind,@"custid":custid,@"type":type,@"servtype":servtype,@"servrele":servrele,@"stbno":stbno,@"smno":smno,@"cmno":cmno,@"oldstbno":oldstbno,@"oldlogicno":oldlogicno,@"smnouseprop":smnouseprop,@"stbuseprop":stbuseprop,@"payway":payway,@"cmuseprop":cmuseprop,@"uname":uname,@"passwrod":passwrod,@"suffix":suffix} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
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
//查询用户类型
- (void)getServeTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_SERV_TYPE"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataServeTypeIDArray = [NSMutableArray array];
        _dataServeTypeNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataServeTypeNameArray addObject:dicModel.mname];
            [_dataServeTypeIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询支付方式
- (void)getPayWaySuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_PAYWAY"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataPayWayIDArray = [NSMutableArray array];
        _dataPayWayNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataPayWayNameArray addObject:dicModel.mname];
            [_dataPayWayIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询智能卡设备来源
- (void)getCardDeviceSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_DEV_UPROP"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataCardDeviceIDArray = [NSMutableArray array];
        _dataCardDeviceNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataCardDeviceNameArray addObject:dicModel.mname];
            [_dataCardDeviceIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询机顶盒设备来源
- (void)getTopBoxDeviceSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_DEV_UPROP"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataTopBoxDeviceIDArray = [NSMutableArray array];
        _dataTopBoxDeviceNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataTopBoxDeviceNameArray addObject:dicModel.mname];
            [_dataTopBoxDeviceIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询EOC设备来源
- (void)getCMDeviceSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"SYS_DEV_UPROP"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataCMDeviceIDArray = [NSMutableArray array];
        _dataCMDeviceNameArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataCMDeviceNameArray addObject:dicModel.mname];
            [_dataCMDeviceIDArray addObject:dicModel.mcode];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//查询宽带后缀
- (void)getBroadSuffixSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetDictionariesAPI parameters:@{@"gcode":@"CMACCTNO_LAST"} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        _dataBroadSuffixIDArray = [NSMutableArray array];
        _dataBroadSuffixNameArray = [NSMutableArray array];
        _dataBroadSuffixCodeArray = [NSMutableArray array];
        //获取数据
        NSArray *dataArray = (NSArray *)responseObject;
        for (NSDictionary *allDic  in dataArray) {
            TTCNewCustomViewControllerDictionaryModel *dicModel = [[TTCNewCustomViewControllerDictionaryModel alloc] init];
            [dicModel setValuesForKeysWithDictionary:allDic];
            [_dataBroadSuffixNameArray addObject:dicModel.mname];
            [_dataBroadSuffixIDArray addObject:dicModel.paramid];
            NSDictionary *dic = [NSDictionary dictionaryWithObject:dicModel.mcode forKey:dicModel.mname];
            [_dataBroadSuffixCodeArray addObject:dic];
        }
        success(nil);
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        _failMsg = @"网络开小差哦";
        fail(nil);
    }];
}
//获取开户地址
- (void)getAddressWithDeptid:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd custid:(NSString *)custid areaid:(NSString *)areaid patchid:(NSString *)patchid addr:(NSString *)addr pagesize:(NSString *)pagesize currentPage:(NSString *)currentPage success:(SuccessBlock)success fail:(FailBlock)fail{
    //请求数据
    [[NetworkManager sharedManager] GET:kGetAddressAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"custid":custid,@"areaid":areaid,@"patchid":patchid,@"addr":addr,@"pagesize":pagesize,@"currentPage":currentPage} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        //初始化
        if ([currentPage isEqualToString:@"1"]) {
            _dataAddressArray = [NSMutableArray array];
            _dataAddressModelArray = [NSMutableArray array];
        }
        //获取数据
        TTCNewUserViewControllerAddressModel *vcModel = [[TTCNewUserViewControllerAddressModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCNewUserViewControllerAddressOutputModel *outputModel = vcModel.output;
        for (TTCNewUserViewControllerAddressOutputHouseModel *houseModel in outputModel.houses) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:houseModel.addr forKey:houseModel.endaddr];
            [_dataAddressArray addObject:dic];
            [_dataAddressModelArray addObject:houseModel];
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
            [_dataPermarkNameArray addObject:defModel.modname];
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
        if ([createModeString isEqualToString:defModel.modname]) {
            createModel = defModel;
        }
    }
    return createModel;
}
//根据名称返回对应的ID
- (void)transfromFeeTypeWith:(NSString *)feeTypeString payWay:(NSString *)paywayString serveType:(NSString *)serveTypeString setup:(NSString *)setupString cardNumString:(NSString *)cardNumString topBoxString:(NSString *)topBoxString CMString:(NSString *)CMString broadSuffixString:(NSString *)broadSuffixString{
    //初始化数据
    _dataFeeTypeString = @"";
    _dataSetupString = @"";
    _dataPayWayString = @"";
    _dataServeTypeString = @"";
    _dataCardNumDeviceString = @"";
    _dataTopBoxDeviceString = @"";
    _dataCMDeviceString = @"";
    _dataBroadSuffixString = @"";
    NSInteger index = 0;
    //收费类型
    index = [_dataFeeTypeNameArray indexOfObject:feeTypeString];
    if (index < 9999) {
        _dataFeeTypeString = [_dataFeeTypeIDArray objectAtIndex:index];
    }
    //支付方式
    index = [_dataPayWayNameArray indexOfObject:paywayString];
    if (index < 9999) {
        _dataPayWayString = [_dataPayWayIDArray objectAtIndex:index];
    }
    //用户类型
    index = [_dataServeTypeNameArray indexOfObject:serveTypeString];
    if (index < 9999) {
        _dataServeTypeString = [_dataServeTypeIDArray objectAtIndex:index];
    }
    //上门安装
    index = [_dataSetupNameArray indexOfObject:setupString];
    if (index < 9999) {
        _dataSetupString = [_dataSetupIDArray objectAtIndex:index];
    }
    //智能卡设备来源
    index = [_dataCardDeviceNameArray indexOfObject:cardNumString];
    if (index < 9999) {
        _dataCardNumDeviceString = [_dataCardDeviceIDArray objectAtIndex:index];
    }
    //机顶盒设备来源
    index = [_dataTopBoxDeviceNameArray indexOfObject:topBoxString];
    if (index < 9999) {
        _dataTopBoxDeviceString = [_dataTopBoxDeviceIDArray objectAtIndex:index];
    }
    //EOC设备来源
    index = [_dataCMDeviceNameArray indexOfObject:CMString];
    if (index < 9999) {
        _dataCMDeviceString = [_dataCMDeviceIDArray objectAtIndex:index];
    }
    //宽带后缀
    index = [_dataBroadSuffixNameArray indexOfObject:broadSuffixString];
    if (index < 9999) {
        _dataBroadSuffixString = [_dataBroadSuffixIDArray objectAtIndex:index];
    }
}
//根据地址获取houseID
- (NSString *)getHouseIDWithAddress:(NSString *)addressString{
    NSString *houseID = @"";
    for (TTCNewUserViewControllerAddressOutputHouseModel *houseModel in _dataAddressModelArray) {
//        if ([houseModel.whladdr isEqualToString:addressString]) {
//            houseID = houseModel.houseid;
//        }
        if ([houseModel.whladdr rangeOfString:addressString].location!= NSNotFound) {
            NSLog(@"houseModel%@",houseModel.whladdr);
             houseID = houseModel.houseid;
        }
        
    }
    return houseID;
}
@end
