//
//  TTCFirstPageViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import "TTCFirstPageViewControllerViewModel.h"
//Model
#import "TTCFirstPageViewControllerBannerModel.h"
#import "TTCMessageViewControllerModel.h"
#import "TTCMessageViewControllerRowsModel.h"
@implementation TTCFirstPageViewControllerViewModel
//banner
- (void)getBannerSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    [[NetworkManager sharedManager] GET:kGetBannerAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        NSArray *responseArray = responseObject;
        //初始化
        _dataBannerArray = [NSMutableArray array];
        _dataImageArray = [NSMutableArray array];
        //获取数据
        for (NSDictionary *dic in responseArray) {
            TTCFirstPageViewControllerBannerModel *banner = [[TTCFirstPageViewControllerBannerModel alloc] init];
            [banner setValuesForKeysWithDictionary:dic];
            //获取所有Banner信息
            [_dataBannerArray addObject:banner];
            [_dataImageArray addObject:banner.img];
        }
        //检测是否下载成功
        if (_dataBannerArray.count > 0) {
            //banner循环数组转化
            [_dataBannerArray insertObject:_dataBannerArray.lastObject atIndex:0];
            [_dataBannerArray addObject:_dataBannerArray[1]];
            [_dataImageArray insertObject:_dataImageArray.lastObject atIndex:0];
            [_dataImageArray addObject:_dataImageArray[1]];
            success(nil);
        }else{
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        fail(nil);
    }];
}
//获取所有消息
- (void)getAllMessageWithPage:(int)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //下载数据
    [[NetworkManager sharedManager] GET:kGetMessageAPI parameters:@{@"name":[SellManInfo sharedInstace].loginname,@"row":@"10",@"page":[NSString stringWithFormat:@"%d",page]} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _hasNew = NO;
        //获取数据
        TTCMessageViewControllerModel *vcModel = [[TTCMessageViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        if (vcModel.rows.count > 0) {
            for (TTCMessageViewControllerRowsModel *rowsModel in vcModel.rows) {
                //获取所有消息
                if ([rowsModel.isread isEqualToString:@"0"]) {
                    _hasNew = YES;
                    successBlock(nil);
                    return;
                }
            }
            [self getAllMessageWithPage:(page+1) success:^(NSMutableArray *resultArray) {
                successBlock(nil);
            } fail:^(NSError *error) {
                failBlock(nil);
            }];
        }else{
            successBlock(nil);
            return;
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        failBlock(nil);
    }];
}

@end
