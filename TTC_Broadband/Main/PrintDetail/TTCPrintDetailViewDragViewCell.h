//
//  TTCPrintDetailViewDragViewCell.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/12/21.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCPrintDetailViewDragViewCell : UITableViewCell
@property (strong, nonatomic) NSString *addressString;
//读取地址
- (void)loadAddressWithString:(NSString *)addressString;
//选中
- (void)isSelected:(BOOL) isSelected;
@end
