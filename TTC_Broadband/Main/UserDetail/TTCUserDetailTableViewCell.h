//
//  TTCUserDetailTableViewCell.h
//  TTC_Broadband
//
//  Created by apple on 16/5/25.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTCUserDetailTableViewCellDelegate <NSObject>

@optional
- (void)UserRenewBusinessButtonClick:(UIButton*)button;

@end

@interface TTCUserDetailTableViewCell : UITableViewCell
//协议指针
@property (weak, nonatomic) id<TTCUserDetailTableViewCellDelegate>delegate;

//详细套餐数据刷新
- (void)loadDetailSetWithModeString:(id)model;

@end
