//
//  TTCNewUserViewControllerMainView.h
//  TTC_Broadband
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCNewUserViewControllerMainView : UIScrollView
//开户模式，支付方式，用户类型，收费类型，上门安装，主副机，智能卡设备来源，机顶盒设备来源，EOC设备来源，宽带后缀，开户地址
- (void)loadCreatModeArray:(NSArray *)creatModeArray payWayArray:(NSArray *)payWayArray serveTypeArray:(NSArray *)serveTypeArray feeTypeArray:(NSArray *)feeTypeArray setupArray:(NSArray *)setupArray cardDeviceArray:(NSArray *)cardDeviceArray topBoxDeviceArray:(NSArray *)topBoxDeviceArray cmDeviceArray:(NSArray *)cmDeviceArray broadSuffixArray:(NSArray *)broadSuffixArray broadDicArray:(NSArray *)broadDicArray addressArray:(NSArray *)addressArray;
//扫一扫
- (void)loadScanStringWithScanString:(NSString *)scanString;
//地址
- (void)loadAddressStringWithAddressString:(NSString *)addrString;
//尾地址
- (void)loadLastAddressStringWithAddressString:(NSString *)lastAddrString;
//添加客户账户
- (void)loadUserbroadAccountString:(NSString*)broadAccountString;
@end
