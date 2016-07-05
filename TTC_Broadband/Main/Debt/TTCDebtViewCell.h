//
//  TTCDebtViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kAccountType,
    kSetDetailType,
}CellType;
@interface TTCDebtViewCell : UITableViewCell
@property (copy, nonatomic) CellIndexTransBlock buttonBlock;
//选择Cell类型
- (void)selectCellType:(CellType)type;
//是否收起
- (void)isPackUp:(BOOL)isPackUp;
//选择
- (void)isSelected:(BOOL)isSelected;
//创建详细套餐
- (void)loadDetailSetWithArray:(NSArray *)setArray;
//加载用户ID 总金额
- (void)loadUserID:(NSString *)userID arrearsun:(NSString *)arrearsun;
//加载总价
- (void)loadPrice:(NSString *)price;
//加载已选欠费
- (void)loadTotalPrice:(NSString *)totalPrice;
//加载总额名称，是否隐藏已选欠费，按钮名称
- (void)loadPriceNameWithPriceName:(NSString *)priceName hide:(BOOL)isHide buttonTitle:(NSString *)buttonTitle;
@end
