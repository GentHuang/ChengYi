//
//  TTCSellDetailMonthViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellDetailMonthViewCell : UITableViewCell
//获取明细信息
- (void)loadWithOrdertype:(NSString *)ordertype factprice:(NSString *)factprice adddate:(NSString *)adddate uname:(NSString *)uname numerical:(NSString *)numerical;
@end
