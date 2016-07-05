//
//  TTCProductLibViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCProductLibViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataProductListArray;
@property (strong, nonatomic) NSMutableArray *dataProductTypeArray;
@property (strong, nonatomic) NSMutableArray *dataProductTypeNameArray;
@property (strong, nonatomic) NSMutableArray *dataProductTypeImageArray;
@property (strong, nonatomic) NSMutableArray *dataProductSubTypeArray;
@property (strong, nonatomic) NSMutableArray *dataProductSubTypeNameArray;
//获取产品列表
- (void)getProListWithItemID:(NSString *)itemid page:(int)page success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
//获取产品分类
- (void)getProductTypeSuccess:(SuccessBlock)success fail:(FailBlock)fail;
//根据下标返回对应的二级目录
- (void)getSubProTypeWithIndex:(int)index;
//获取热销产品
- (void)getDataAHotSellProductsuccess:(SuccessBlock)success fail:(FailBlock)fail;
@end
