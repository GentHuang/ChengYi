//
//  TTCSellDetailAllViewCell.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/12/14.
//  Copyright © 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellDetailAllViewCell : UITableViewCell
//获取明细信息
- (void)loadWithOrdertype:(NSString *)ordertype factprice:(NSString *)factprice adddate:(NSString *)adddate uname:(NSString *)uname numerical:(NSString *)numerical;
//获取icon信息
- (void)loadNumiconImageWithString:(NSString *)NumiconString NameiconImageWithString:(NSString*)nameiconString;
@end
