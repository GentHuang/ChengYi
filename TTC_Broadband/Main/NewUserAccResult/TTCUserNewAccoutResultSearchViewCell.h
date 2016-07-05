//
//  TTCUserNewAccoutResultSearchView.h
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUserNewAccoutResultSearchViewCell : UITableViewCell
//获取明细信息
- (void)loadWithOrderID:(NSString *)ordertId Opentime:(NSString *)opentime Orderstatus:(NSString *)orderstatus Bossserialno:(NSString *)bossserialno failmemo:(NSString *)failmemo;
@end
