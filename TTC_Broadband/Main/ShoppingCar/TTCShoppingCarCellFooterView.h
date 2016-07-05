//
//  TTCShoppingCarCellFooterView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTCShoppingCarCellFooterView <NSObject>
@optional
- (void) btnAllSelectedWithButton:(UIButton *) button;

@end

@interface TTCShoppingCarCellFooterView : UIView

@property (weak,nonatomic) id<TTCShoppingCarCellFooterView>footerViewdelegate;

//加载总价
- (void)loadAllPrice:(NSString *)allPrice;
// 根据单选状态改变全选的状态
- (void) changeAllSelectButtonStatus:(BOOL)singleBtnFlag;
@end
