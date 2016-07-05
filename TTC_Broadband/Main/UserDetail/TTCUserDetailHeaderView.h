//
//  TTCUserDetailHeaderView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUserDetailHeaderView : UIView
@property (copy, nonatomic) CellIndexTransBlock cellIndexBlock;
//读取地址
- (void)loadAddressTitle:(NSString *)addressString;
@end
