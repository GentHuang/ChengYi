//
//  TTCRechargeViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCRechargeViewControllerViewModel.h"
//Model
#import "TTCRechargeViewControllerModel.h"
#import "TTCRechargeViewControllerOutputModel.h"

@implementation TTCRechargeViewControllerViewModel
//充值
- (void)rechargeWithKeyno:(NSString *)keyno Fees:(NSString *)fees fbid:(NSString *)fbid payway:(NSString *)payway bankaccno:(NSString *)bankaccno payreqid:(NSString *)payreqid success:(SuccessBlock)success fail:(FailBlock)fail{
     //请求数据
    [[NetworkManager sharedManager] GET:kRechargeAPI parameters:@{@"clientcode":[SellManInfo sharedInstace].loginname,@"clientpwd":[SellManInfo sharedInstace].password,@"custid":[CustomerInfo shareInstance].custid,@"keyno":keyno,@"deptid":[SellManInfo sharedInstace].depID,@"fees":fees,@"fbid":fbid,@"payway":payway,@"bankaccno":bankaccno,@"payreqid":payreqid,@"Mname":[SellManInfo sharedInstace].name,@"Uname":[CustomerInfo shareInstance].custname,@"Deptname":[SellManInfo sharedInstace].depName} success:^void(AFHTTPRequestOperation * opertation, id responseObject) {
        TTCRechargeViewControllerModel *vcModel = [[TTCRechargeViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCRechargeViewControllerOutputModel *outputModel = vcModel.output;
        if (outputModel.orderid.length > 0) {
            success(nil);
        }else{
            fail(nil);
        }
    } failure:^void(AFHTTPRequestOperation * opertation, NSError * error) {
        NSLog(@"%@",error);
        fail(nil);
    }];
}
@end
