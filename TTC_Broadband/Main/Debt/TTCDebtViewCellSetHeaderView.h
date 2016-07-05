//
//  TTCDebtViewCellSetHeaderView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCDebtViewCellSetHeaderView : UIView
@property (copy, nonatomic) ButtonPressedBlock buttonBlock;
//加载用户ID 总金额
- (void)loadUserID:(NSString *)userID arrearsun:(NSString *)arrearsun;
//选择
- (void)isSelected:(BOOL)isSelected;
//是否收起
- (void)isPackUp:(BOOL)isPackUp;
@end
