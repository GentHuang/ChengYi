//
//  TTCUserDetailBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUserDetailBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置客户详情标题
- (void)loadUserDetailHeaderLabel:(NSString *)title;
- (void)loadClientInformationWithCustid:(NSString *)custid  markno:(NSString *)markno phone:(NSString *)phone addr:(NSString *)addr name:(NSString *)name;
@end
