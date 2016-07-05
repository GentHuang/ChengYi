//
//  TTCPaySweepQRcodeView.h
//  TTC_Broadband
//
//  Created by apple on 16/5/7.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCPaySweepQRcodeWebView : UIView

//按钮数据回传
@property (copy, nonatomic) ButtonPressedBlock buttonPress;

//加载数据
- (void)loadWebView:(NSString*)string;
@end
