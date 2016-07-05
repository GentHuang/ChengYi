//
//  TTCDebtViewCellAccountBackView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCDebtViewCellAccountBackView : UIView
@property (copy, nonatomic) ButtonPressedBlock buttonBlock;
//加载总价
- (void)loadPrice:(NSString *)price;
//加载已选欠费
- (void)loadTotalPrice:(NSString *)totalPrice;
//加载总额名称，是否隐藏已选欠费，按钮名称
- (void)loadPriceNameWithPriceName:(NSString *)priceName hide:(BOOL)isHide buttonTitle:(NSString *)buttonTitle;
@end
