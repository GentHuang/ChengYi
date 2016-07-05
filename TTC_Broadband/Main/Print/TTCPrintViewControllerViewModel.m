//
//  TTCPrintViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintViewControllerViewModel.h"
//Model
#import "TTCPrintViewControllerViewOutputUnprintinvinfosModel.h"
#import "TTCPrintViewControllerModel.h"
#import "TTCPrintViewControllerViewOutputModel.h"
#import "TTCPrintViewControllerViewOutputUnprintinvinfosModel.h"
@implementation TTCPrintViewControllerViewModel
//通过GroupID返回未打印发票数组
- (void)getNoPrintInfoWithGroupID:(NSString *)groupID dataArray:(NSArray *)dataArray{
    //初始化
    _allPrice = 0;
    _dataPrintArray = [NSMutableArray array];
    //转换数据
    for (TTCPrintViewControllerViewOutputUnprintinvinfosModel *infoModel in dataArray) {
        if ([infoModel.groupid isEqualToString:groupID]) {
            [_dataPrintArray addObject:infoModel];
            _allPrice += [infoModel.fees floatValue];
        }
    }
}
//获取未打印发票信息
- (void)getNoInvoiceInfo{
    //初始化存储数据
    _allPrintArray = [NSMutableArray array];
    _dataGroupIDArray = [NSMutableArray array];
    __block CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    //获取数据
    [[NetworkManager sharedManager] GET:kGETNoInvoiceInfoAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"custid":customerInfo.custid} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        NSLog(@"%@",operation);
        TTCPrintViewControllerModel *vcModel = [[TTCPrintViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        //判断是否存在流水号冲突
        NSRange range = [vcModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self getNoInvoiceInfo];
            return;
        }
        TTCPrintViewControllerViewOutputModel *outputModel = vcModel.output;
        for (TTCPrintViewControllerViewOutputUnprintinvinfosModel *infoModel in outputModel.unprintinvinfos) {
            //获取所有未开票的打印单
            [_allPrintArray addObject:infoModel];
            //获取所有GroupID
            if (_dataGroupIDArray.count > 0) {
                if ([_dataGroupIDArray indexOfObject:infoModel.groupid] > 99999) {
                    [_dataGroupIDArray addObject:infoModel.groupid];
                }
            }else{
                [_dataGroupIDArray addObject:infoModel.groupid];
            }
        }
        if ([vcModel.status isEqualToString:@"0"]) {
            //成功
            self.noPrintInfoSuccessBlock(nil);
        }else{
            //失败
            self.noPrintInfoFailBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        self.noPrintInfoFailBlock(nil);
    }];
}

@end
