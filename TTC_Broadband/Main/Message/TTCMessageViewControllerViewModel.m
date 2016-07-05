//
//  TTCMessageViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCMessageViewControllerViewModel.h"
//Model
#import "TTCMessageViewControllerModel.h"
#import "TTCMessageViewControllerRowsModel.h"
@implementation TTCMessageViewControllerViewModel
//获取所有消息
- (void)getAllMessageWithPage:(int)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //下载数据
    [[NetworkManager sharedManager] GET:kGetMessageAPI parameters:@{@"name":[SellManInfo sharedInstace].loginname,@"row":@"10",@"page":[NSString stringWithFormat:@"%d",page]} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        if (page == 1) {
            _dataRowsArray = [NSMutableArray array];
        }
        //获取数据
        TTCMessageViewControllerModel *vcModel = [[TTCMessageViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        for (TTCMessageViewControllerRowsModel *rowsModel in vcModel.rows) {
            //获取所有消息
            [_dataRowsArray addObject:rowsModel];
        }
        successBlock(nil);
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        failBlock(nil);
    }];
}


@end
