//
//  TTCAddCustAddrViewControllerCellTopView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCAddCustAddrViewControllerCellTopView : UIView
//收起键盘
- (void)packUpKeyBoard;
//加载业务区
- (void)loadAreaLabelWithAreaString:(NSString *)areaString;
@end
