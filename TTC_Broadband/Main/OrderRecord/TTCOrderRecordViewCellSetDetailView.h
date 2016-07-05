//
//  TTCOrderRecordViewCellSetDetailView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCOrderRecordViewCellSetDetailView : UIView
@property (copy, nonatomic) IndexTransBlock indexBlock;
//加载套餐详细内容
- (void)loadWithPname:(NSString *)pname createtime:(NSString *)createtime fees:(NSString *)fees count:(NSString *)count;
//加载套餐详细内容(销售明细)
- (void)loadWithTitle:(NSString *)title stime:(NSString *)stime price:(NSString *)price etime:(NSString *)etime;
//显示前往支付
- (void)goToPay:(BOOL)isAll;
@end
