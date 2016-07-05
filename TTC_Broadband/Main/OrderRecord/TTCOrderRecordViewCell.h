//
//  TTCOrderRecordViewCell.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kUserType,
    kSetHeaderType,
    kSetDetailType,
    kSetFooterType,
    kSellDetailType
}CellType;

@interface TTCOrderRecordViewCell : UITableViewCell
@property (copy, nonatomic) IndexTransBlock indexBlock;
//选择Cell类型
- (void)selectCellType:(CellType)type;
//加载用户名字
- (void)loadUserName:(NSString *)name;
//加载总金额 营销人员部门 姓名
- (void)loadPrice:(NSString *)price sellManDepName:(NSString *)depName name:(NSString *)name;
//加载套餐详细内容
- (void)loadWithPname:(NSString *)pname createtime:(NSString *)createtime fees:(NSString *)fees count:(NSString *)count;
//加载套餐详细内容(销售明细)
- (void)loadWithTitle:(NSString *)title stime:(NSString *)stime price:(NSString *)price etime:(NSString *)etime;
//加载业务流水号
- (void)loadOrderID:(NSString *)orderid;
//加载客户信息
- (void)loadWithDate:(NSString *)date keyno:(NSString *)keyno;
//加载支付状态
- (void)loadTypeLabelWithTypeString:(NSString *)typeString;
//显示前往支付
- (void)goToPay:(BOOL)isAll;
//加载业务受理时间
- (void)loadDateWithDateString:(NSString *)dateString;
@end
