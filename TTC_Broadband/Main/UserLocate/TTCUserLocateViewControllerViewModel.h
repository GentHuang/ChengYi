//
//  TTCUserLocateScrollViewViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCUserLocateViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataAddrsArray;
@property (strong, nonatomic) NSMutableArray *dataServsArray;
@property (strong, nonatomic) NSMutableArray *dataBalanceArray;
@property (strong, nonatomic) NSMutableArray *dataProductArray;
@property (strong, nonatomic) NSMutableArray *dataPrintInfoArray;
@property (copy, nonatomic) SuccessBlock balanceSuccessBlock;
@property (copy, nonatomic) SuccessBlock arrearSuccessBlock;
@property (copy, nonatomic) SuccessBlock userProductSuccessBlock;
@property (copy, nonatomic) SuccessBlock noPrintInfoSuccessBlock;
@property (copy, nonatomic) FailBlock balanceFailBlock;
@property (copy, nonatomic) FailBlock arrearFailBlock;
@property (copy, nonatomic) FailBlock userProductFailBlock;
@property (copy, nonatomic) FailBlock noPrintInfoFailBlock;
@property (strong, nonatomic) NSString *failMsg;

//获取客户信息
- (void)getCustomerInfoWithIcno:(NSString *)icno type:(NSString *)type success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
//获取余额信息
- (void)getBalanceInfo;
//获取所有业务信息
- (void)getUseProductWithServsArray:(NSArray *)servsArray;
//获取欠费信息
- (void)getArrearsListWithServsArray:(NSArray *)servsArray;
//获取未打印发票信息
- (void)getNoInvoiceInfo;
@end
