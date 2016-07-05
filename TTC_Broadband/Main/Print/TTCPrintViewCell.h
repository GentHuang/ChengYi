//
//  TTCPrintViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kAccountType,
    kDetailType
}CellType;
@interface TTCPrintViewCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock stringBlock;
//选择Cell类型
- (void)selectCellType:(CellType)type;
//加载分组名称
- (void)loadTypeWithString:(NSString *)type;
//加载订单详情
- (void)loadWithInvcontid:(NSString *)invcontid keyno:(NSString *)keyno optime:(NSString *)optime fees:(NSString *)fees mName:(NSString *)mName;
//是否选择(详细)
- (void)isSelected:(BOOL)isSelected;
//是否选择(全局)
- (void)isAllSelected:(BOOL)isAllSelected;
//加载已选总额
- (void)loadSelectedPrice:(float)price;
//是否下拉
- (void)isDrag:(BOOL)isDrag;
@end
