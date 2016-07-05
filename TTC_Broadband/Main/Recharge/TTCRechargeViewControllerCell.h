//
//  TTCRechargeViewControllerCell.h
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kInformationType,
    kChoseType,
    kCountType,
    kPayInfoType,
    kPayOrderType
}CellType;
@interface TTCRechargeViewControllerCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock stringBlock;
//选择Cell类型
- (void)selectCellType:(CellType)type;
//加载用户名和营销人员信息
- (void)loadUserName:(NSString *)userName sellManName:(NSString *)sellManName sellManDepName:(NSString *)sellManDepName;
//加载充值的名称
- (void)loadRechargeNameWithName:(NSString *)name;
//隐藏键盘
- (void)hideKeyBoard;
@end
