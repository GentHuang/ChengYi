//
//  TTCAddAddressViewControllerCellOtherView.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAddAddressViewControllerCellOtherView : UIView
//加载住宅地址 片区 可安装业务 住宅状态
- (void)loadAddress:(NSString *)addressString area:(NSString *)areaString business:(NSString *)businessString status:(NSString *)statusString;
@end
