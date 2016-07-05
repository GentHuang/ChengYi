//
//  TTCUpgradeViewControllerDragViewCell.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/3.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUpgradeViewControllerDragViewCell : UITableViewCell
@property (strong, nonatomic) NSString *addressString;
//读取地址
- (void)loadAddressWithString:(NSString *)addressString;
//选中
- (void)isSelected:(BOOL) isSelected;
@end
