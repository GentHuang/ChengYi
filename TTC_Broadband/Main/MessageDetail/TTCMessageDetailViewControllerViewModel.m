//
//  TTCMessageDetailViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCMessageDetailViewControllerViewModel.h"
//Model
#import "TTCMessageDetailViewControllerModel.h"

@implementation TTCMessageDetailViewControllerViewModel
//发送已读
- (void)sendIsReadWithMid:(NSString *)mid{
    //下载数据
    [[NetworkManager sharedManager] GET:kIsReadAPI parameters:@{@"mid":mid,@"mcode":[SellManInfo sharedInstace].loginname,@"mname":[SellManInfo sharedInstace].name} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        TTCMessageDetailViewControllerModel *vcModel = [[TTCMessageDetailViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        if ([vcModel.mes isEqualToString:@"yes"]) {
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

//根据ID返回产品详细信息
- (void)getProductById:(NSString *)id_conflict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //id不存在的时候
    if (id_conflict ==nil) {
        failBlock(nil);
        return;
    }
    //下载数据
    [[NetworkManager sharedManager] GET:kGetProductByIdAPI parameters:@{@"id":id_conflict} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //数据初始化
        _ProductModel = [[TTCProductDetailViewControllerModel alloc] init];
        //获取数据
        [_ProductModel setValuesForKeysWithDictionary:responseObject];
        if (_ProductModel.id_conflict.length > 0 || _ProductModel.code.length > 0) {
            //成功
            successBlock(nil);
        }else{
            failBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        failBlock(nil);
    }];
}
@end
