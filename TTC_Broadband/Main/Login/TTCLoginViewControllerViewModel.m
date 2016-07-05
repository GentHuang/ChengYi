//
//  TTCLoginViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//
//ViewModel
#import "TTCLoginViewControllerViewModel.h"
//Model
#import "TTCLoginViewControllerModel.h"
#import "TTCLoginViewControllerOutputModel.h"
#import "TTCLoginViewControllerOutputDepinfoModel.h"
@interface TTCLoginViewControllerViewModel()
@property (strong, nonatomic) NSOperationQueue *dbQueue;
@end

@implementation TTCLoginViewControllerViewModel
//初始化
- (instancetype)init{
    if (self = [super init]) {
        _dbQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}
//销售人员登录
- (void)saleManLoginWithName:(NSString *)name pwd:(NSString *)pwd successs:(SuccessBlock)successBlock fail:(FailBlock)failBlock{

    NSString *urlString =[NSString stringWithFormat:kGetSalesmanInfoAPI@"&name=%@&pwd=%@",name,pwd];
    NSLog(@"login=%@",urlString);
    [[NetworkManager sharedManager] GET:kGetSalesmanInfoAPI parameters:@{@"name":name,@"pwd":pwd} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化数据
        _dataDepinfoIDArray = [NSMutableArray array];
        _dataDepinfoNameArray = [NSMutableArray array];
        //获取数据
        TTCLoginViewControllerModel *vcModel = [[TTCLoginViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCLoginViewControllerOutputModel *outputModel = vcModel.output;NSLog(@"??==%@",vcModel.output.message);
        if ([vcModel.output.message containsString:@"成功"]) {
            //加载营销人员信息
            [[SellManInfo sharedInstace] loadSellManInfoWithRequestid:vcModel.requestid loginname:outputModel.loginname message:outputModel.message name:outputModel.name password:outputModel.password returnCode:outputModel.returnCode];
            //加载手势密码信息
            [[LockInfo sharedInstace] loadName:name psw:pwd];
            [SellManInfo sharedInstace].md5PSW = [pwd MD5Digest];
            //加载数据
            for (TTCLoginViewControllerOutputDepinfoModel *depinfoModel in outputModel.depinfo) {
                [_dataDepinfoNameArray addObject:depinfoModel.detpname];
                [_dataDepinfoIDArray addObject:depinfoModel.detpid];
            }
            successBlock(nil);
        }else{
            failBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        failBlock(nil);
    }];
}
@end
