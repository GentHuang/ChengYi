//
//  TTCShoppingCarViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
//Model
#import "TTCShoppingCarViewControllerModel.h"
@interface TTCShoppingCarViewControllerViewModel : NSObject

@property (strong, nonatomic) NSMutableArray *dataCarArray;
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) NSString *failMSG;
@property (copy, nonatomic) SuccessBlock dbSuccessBlock;


//从数据库获取购物车数据
- (void)getDataFromDB;
//删除实例
- (void)deleteModelWithID:(NSString *)ID keyno:(NSString *)keyno;
//购物车支付
- (void)carPayWithArray:(NSArray *)dataArray sucess:(SuccessBlock)successBlock fail:(FailBlock)fail;

@end
