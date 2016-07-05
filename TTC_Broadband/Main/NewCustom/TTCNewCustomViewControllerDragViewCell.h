//
//  TTCNewCustomViewControllerDragViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/12/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewCustomViewControllerDragViewCell : UITableViewCell
@property (strong, nonatomic) NSString *addressString;
//读取地址
- (void)loadAddressWithString:(NSString *)addressString;
//选中
- (void)isSelected:(BOOL) isSelected;
@end
