//
//  TTCSellDetailMonthPickView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellDetailMonthPickView : UIView
@property (assign, nonatomic) BOOL isPackUp;
//弹出PickerView
- (void)showPickerView;
//收回PickerView
- (void)packUpPickerView;
@end
