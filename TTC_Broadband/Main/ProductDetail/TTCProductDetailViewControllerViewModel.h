//
//  TTCProductDetailViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
//Model
#import "TTCProductDetailViewControllerModel.h"
@interface TTCProductDetailViewControllerViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) NSString *failMSG;
@property (strong, nonatomic) TTCProductDetailViewControllerModel *vcModel;
//根据ID返回产品详细信息
- (void)getProductById:(NSString *)id_conflict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
//加入购物车
- (void)addToShoppingCarWithModel:(TTCProductDetailViewControllerModel *)dataModel keyno:(NSString *)keyno count:(NSString *)count permark:(NSString *)permark success:(SuccessBlock)successBlock fail:(FailBlock)fail;
//马上订购
- (void)productOrderWithModel:(TTCProductDetailViewControllerModel *)dataModel keyno:(NSString *)keyno count:(NSString *)count success:(SuccessBlock)successBlock fail:(FailBlock)fail;
@end
