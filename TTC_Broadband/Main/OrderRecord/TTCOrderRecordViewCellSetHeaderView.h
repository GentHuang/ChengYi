//
//  TTCOrderRecordViewCellSetHeaderView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TTCOrderRecordViewCellSetHeaderView : UIView
//加载业务流水号
- (void)loadOrderID:(NSString *)orderid;
//加载业务受理时间
- (void)loadDateWithDateString:(NSString *)dateString;
@end
