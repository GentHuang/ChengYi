//
//  TTCPayViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
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
@interface TTCPayViewCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock stringBlock;
//选择Cell类型
- (void)selectCellType:(CellType)type;
//加载欠费
- (void)loadCount:(NSString *)count;
//加载用户名和营销人员信息
- (void)loadUserName:(NSString *)userName sellManName:(NSString *)sellManName sellManDepName:(NSString *)sellManDepName;
//加载订单信息
- (void)loadPayInfo:(NSString *)payInfo;
//加载订单方案
- (void)loadTitle:(NSString *)title price:(NSString *)price count:(NSString *)count;
//加载图片
- (void)loadCellImageWithImageString:(NSString *)imageString;
//加载总价
- (void)loadTotalPrice:(NSString *)price;
@end
