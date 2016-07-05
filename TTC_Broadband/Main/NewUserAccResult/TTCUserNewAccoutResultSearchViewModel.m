//
//  TTCUserNewAccoutResultSearchViewModel.m
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserNewAccoutResultSearchViewModel.h"
#import "TTCUserNewAccoutResultSearchModel.h"
#import "TTCUserNewAccountResultSearchOutputModel.h"
@implementation TTCUserNewAccoutResultSearchViewModel
//查询开户状态
- (void)getUserOpenAccountResultSearchsuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    _dataAccountResultArray = [NSMutableArray array];
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    CustomerInfo *custInfo = [CustomerInfo shareInstance];
    //参数配置
    NSMutableDictionary *parameDic = [NSMutableDictionary dictionary];
    parameDic[@"deptid"] = sellManInfo.depID;
    parameDic[@"clientcode"] = sellManInfo.loginname;
    parameDic[@"clientpwd"] = sellManInfo.password;
    parameDic[@"custid"] = custInfo.custid;
    
    [[NetworkManager sharedManager]GET:kNewUserResultAPI parameters:parameDic success:^(AFHTTPRequestOperation * operation, id responsObject) {
        _dataAccountResultArray = [NSMutableArray array];
        TTCUserNewAccoutResultSearchModel *searchModel = [[TTCUserNewAccoutResultSearchModel alloc]init];
        [searchModel setValuesForKeysWithDictionary:responsObject];
        
        TTCUserNewAccountResultSearchOutputModel *arrayModel = searchModel.output;
        
        for (TTCUserAccountResultSearchMessageModel *messageModel  in arrayModel.tmpsustOrderList) {
            [_dataAccountResultArray addObject:messageModel];
        }
        if (_dataAccountResultArray.count>0) {
            successBlock(nil);
        }else {
            failBlock(nil);
        }
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
    }];
    
}
@end
