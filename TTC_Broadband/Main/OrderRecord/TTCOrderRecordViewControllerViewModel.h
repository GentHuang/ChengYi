//
//  TTCOrderRecordViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCOrderRecordViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataServsArray;
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) NSMutableArray *dataInfoArray;
@property (strong, nonatomic) NSString *dataDateString;
@property (strong, nonatomic) NSString *dataKeynoString;
//获取客户所有订单信息
- (void)getOrdersListPage:(int)page isAll:(BOOL)isAll success:(SuccessBlock)success fail:(FailBlock)fail;
//连接打印机
- (void)connectToPrinterSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//打印受理单
- (void)printAcceptWithOrderID:(NSString *)OrderID success:(SuccessBlock)success fail:(FailBlock)fail;
//打印字符串
- (void)printStringWithInfoArray:(NSArray *)dataArray success:(SuccessBlock)success fail:(FailBlock)fail;
//关闭打印机
- (void)closePrinter;
@end
