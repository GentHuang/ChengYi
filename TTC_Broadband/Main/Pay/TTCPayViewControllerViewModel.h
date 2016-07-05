//
//  TTCPayViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
//Model
#import "TTCProductDetailViewControllerModel.h"
@interface TTCPayViewControllerViewModel : NSObject
@property (copy, nonatomic) SuccessBlock paySuccessBlock;
@property (copy ,nonatomic) FailBlock payFailBlock;
@property (copy, nonatomic) SuccessBlock sureSuccessBlock;
@property (copy ,nonatomic) FailBlock sureFailBlock;
@property (strong, nonatomic) NSMutableArray *dataOrderArray;
@property (strong, nonatomic) NSString *failMSG;
//add
//获取支付链接成功后返回支付链接
@property (strong ,nonatomic) NSString *PayQRString;
//返回XML格式
@property (strong, nonatomic) NSString *PayQRWebViewString;

//缴纳欠费
- (void)payArrearsWithArray:(NSArray *)dataArray;
//确定订单
- (void)sureOrderWithOrderArray:(NSArray *)orderArray carArray:(NSArray *)carArray payway:(NSString *)payway;
//马上订购
- (void)productOrderWithModel:(TTCProductDetailViewControllerModel *)dataModel keyno:(NSString *)keyno count:(NSString *)count success:(SuccessBlock)successBlock fail:(FailBlock)fail;
//购物车支付
- (void)carPayWithArray:(NSArray *)dataArray sucess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;


//微信支付
- (void)sendPayWithOrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice;
//add
//后台生成微信支付链接
- (void)sendPayCreateQRcodeWithOrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice OrderID:(NSString*)orderID Success:(SuccessBlock)success Fail:(FailBlock)fail;

//使用网页支付
- (void)sendPayWebViewWithOrderID:(NSString*)orderID OrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice sucess:(SuccessBlock)successBlock fail:(FailBlock)fail;
//查询支付情况
- (void)queryPayResultWithOderID:(NSString*)OrderID sucess:(SuccessBlock)successBlock fail:(FailBlock)fail;

@end
