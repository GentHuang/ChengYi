//
//  TTCNewUserViewControllerDragViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewUserViewControllerDragViewCell : UITableViewCell
@property (strong, nonatomic) NSString *addressString;
//读取地址
- (void)loadAddressWithString:(NSString *)addressString;
//选中
- (void)isSelected:(BOOL) isSelected;
@end
