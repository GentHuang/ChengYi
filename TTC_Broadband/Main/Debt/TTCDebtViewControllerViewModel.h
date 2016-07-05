//
//  TTCDebtViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCDebtViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataArrearArray;
@property (strong, nonatomic) NSMutableArray *dataOutputArray;
@property (strong, nonatomic) NSMutableArray *dataBalanceArray;
@property (copy, nonatomic) SuccessBlock arrearSuccessBlock;
@property (copy, nonatomic) SuccessBlock balanceSuccessBlock;
@property (copy, nonatomic) FailBlock arrearFailBlock;
@property (copy, nonatomic) FailBlock balanceFailBlock;

//获取所有用户的欠费信息
- (void)getArrearsListWithServsArray:(NSArray *)servsArray withPage:(int)page;
//通过下标返回该用户的欠费信息
- (NSArray *)getServsArrearsListWithIndex:(int)index;
//获取余额信息
- (void)getBalanceInfo;
@end
