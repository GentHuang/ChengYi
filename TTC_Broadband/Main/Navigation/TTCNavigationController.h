//
//  TTCNavigationController.h
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXYNavigationController.h"
typedef enum{
    kNoneType,
    kFirstPageType,
    kUserLocateType,
    kProductLibType,
    kProductDetailType,
    kUserDetailType,
    kShoppingCarType,
    KMeType,
    kAccountInfoType,
    kSellCountType,
    kSellDetailMonthType,
    kSellDetailDayType,
    kOrderRecordType
//    kAccuntResultType
}NavigationType;
//@interface TTCNavigationController:XXYNavigationController
@interface TTCNavigationController:UINavigationController
//--add
@property (copy, nonatomic) StringTransBlock stringBlock;
//选择导航栏样式
- (void)selectNavigationType:(NavigationType)type;
//填入首页信息(姓名,ID,部门,营业厅,片区)
- (void)loadFirstPageInformation:(NSArray *)dataArray;
//客户是否已登录(姓名,地区)
- (void)loadCustomerFirstPageInformation:(BOOL)isLog;
//填入我信息(姓名,ID,部门,营业厅,片区)
- (void)loadMeInformation:(NSArray *)dataArray;
//设置标题
- (void)loadHeaderTitle:(NSString *)title;
//加载营销人员信息
- (void)loadSellManInfoWithArray:(NSArray *)dataArray;
//加载客户信息
- (void)loadClientInformationWithCustid:(NSString *)custid markno:(NSString *)markno phone:(NSString *)phone addr:(NSString *)addr name:(NSString *)name;
//加载销售统计信息
- (void)loadWithMname:(NSString *)mname mcode:(NSString *)mcode deptname:(NSString *)deptname commission:(NSString *)commission;
//是否可以后退
- (void)canGoBack:(BOOL)canGoBack;
//是否显示客户离开选项按钮
- (void)ClientLeaveButton:(BOOL)isHidden;
//更新销售额(月)
- (void)loadMonthSellCount:(NSString *)count;
//更新销售额(日)
- (void)loadDaySellCount:(NSString *)count;
//设置营销人员姓名，客户姓名
- (void)loadWithSellManName:(NSString *)sName customerName:(NSString *)cName;
//隐藏Bar
- (void)hideBar;
//显示Bar
- (void)showBar;
//新消息提示
- (void)newsHint:(BOOL)hasNew;
//是否隐藏本月销售和今日销售
- (void)hideMonthAndDaySell:(BOOL)isHide;
//加载订单记录客户名称
- (void)loadOrderRecordCustNameLabelWith:(NSString *)custNameString;
//更新点选按钮
- (void)reloadSelectedButtonWithIsAll:(BOOL)isAll;
@end
