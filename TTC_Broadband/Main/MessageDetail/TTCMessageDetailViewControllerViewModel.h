//
//  TTCMessageDetailViewControllerViewModel.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/11/26.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTCProductDetailViewControllerModel.h"

@interface TTCMessageDetailViewControllerViewModel : NSObject
//
@property (strong, nonatomic) TTCProductDetailViewControllerModel *ProductModel;

//发送已读
- (void)sendIsReadWithMid:(NSString *)mid;

//根据ID返回产品详细信息
- (void)getProductById:(NSString *)id_conflict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
