//
//  TTCRankViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCRankViewControllerViewModel.h"
//Model
#import "TTCRankViewControllerArrayModel.h"
@implementation TTCRankViewControllerViewModel
//获取下载排行
- (void)getSalesRankingSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //下载数据
    [[NetworkManager sharedManager] GET:kGetSalesRankingAPI parameters:@{@"nums":@"5"} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataRankArray = [NSMutableArray array];
        //获取数据
        for (NSDictionary *dic in responseObject) {
            TTCRankViewControllerArrayModel *arrayModel = [[TTCRankViewControllerArrayModel alloc] init];
            [arrayModel setValuesForKeysWithDictionary:dic];
            //加载排行榜信息
            [_dataRankArray addObject:arrayModel];
        }
        if (_dataRankArray.count > 0) {
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
