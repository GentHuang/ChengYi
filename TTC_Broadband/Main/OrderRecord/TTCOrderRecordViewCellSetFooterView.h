//
//  TTCOrderRecordViewCellSetFooterView.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCOrderRecordViewCellSetFooterView : UIView
//加载总金额 营销人员部门 姓名
- (void)loadPrice:(NSString *)price sellManDepName:(NSString *)depName name:(NSString *)name;
//加载支付状态
- (void)loadTypeLabelWithTypeString:(NSString *)string;
@end
