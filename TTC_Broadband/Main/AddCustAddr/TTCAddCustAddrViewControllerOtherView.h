//
//  TTCAddCustAddrViewControllerOtherView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAddCustAddrViewControllerOtherView : UIView
//加载住宅地址 片区 可安装业务 住宅状态
- (void)loadAddress:(NSString *)addressString area:(NSString *)areaString business:(NSString *)businessString status:(NSString *)statusString;

@end
