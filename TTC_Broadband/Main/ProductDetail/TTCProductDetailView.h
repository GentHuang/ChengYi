//
//  TTCProductDetailView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kLogMode,
    kUnLogMode
}viewMode;
@interface TTCProductDetailView : UIView
@property (assign, nonatomic) BOOL canBuy;
@property (copy, nonatomic) TapPressedBlock tapBlock;
@property (copy, nonatomic) StringTransBlock stringBlock;
//读取地址
- (void)loadAddressString:(NSString *)address;
////弹出View
//- (void)dragDownView;
////收起View
//- (void)packUpView;
//加载数据
- (void)loadTitle:(NSString *)title intro:(NSString *)intro price:(NSString *)price smallimg:(NSString *)smallimg firstUserKeyno:(NSString *)firstUserKeyno firstUserPermark:(NSString *)firstUserPermark;
//收起键盘(确定购买数量)
- (void)hideKeyBoard;
//根据客户是否登录选择视图模式
- (void)selectViewModel:(viewMode)mode;

/**********************************/
//显示购买年份月份按钮
- (void)showBuyYearOrMonthlyButton;
//隐藏购买年份月份按钮
- (void)hiddeBUyYearOrMonthlyButton;

@end
