//
//  TTCAddAddressViewControllerCellTopView.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAddAddressViewControllerCellTopView : UIView
//加载业务区
- (void)loadArea:(NSString *)areaString;
//收起键盘
- (void)packUpKeyBoard;
@end
