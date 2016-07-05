//
//  TTCUpgradeViewControllerMainView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/3.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCUpgradeViewControllerMainView : UIView
@property (copy, nonatomic) StringTransBlock buttonBlock;
//加载开户模式，收费类型，上门安装，主副机
- (void)loadCreatModeArray:(NSArray *)creatModeArray feeTypeArray:(NSArray *)feeTypeArray setupArray:(NSArray *)setupArray mainSeconderyArray:(NSArray *)mainSeconderyArray;
//扫一扫
- (void)loadScanStringWithScanString:(NSString *)scanString;
//是否升级设备
- (void)isUpgradeDevice:(BOOL)isUpgrade;
@end
