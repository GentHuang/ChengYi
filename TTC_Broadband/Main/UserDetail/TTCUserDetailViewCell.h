//
//  TTCUserDetailViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kFirstType,
    kSecondType,
    kOtherType
}CellType;
@interface TTCUserDetailViewCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock secondStringBlock;
@property (copy, nonatomic) StringTransBlock firstStringBlock;
@property (copy, nonatomic) CellIndexTransBlock cellIndexBlock;
@property (assign, nonatomic) BOOL isSelected;

//加载用户高清标清
- (void)loadDefinitionLabelWithString:(NSString *)string;
//加载主副机
- (void)loadMainSecondWithString:(NSString *)string;
//业务图片
- (void)loadCellImageView:(UIImage *)image;
//业务编号
- (void)loadBusinessNumLabel:(NSString *)businessNumString;
//设备编号
- (void)loadDeviceNumLabel:(NSString *)deviceNumString;
//开通时间
- (void)loadTimeLabel:(NSString *)timeString;
//业务名称
- (void)loadBusinessNameLabel:(NSString *)businessNameString;
//选择Cell
- (void)selected:(BOOL)isSelected;
//创建详细套餐
- (void)loadDetailSetWithArray:(NSArray *)setArray;
//选择CellType
- (void)selecteCellType:(CellType)type;
//加载价格(第二种模式)
- (void)loadPriceWithArray:(NSArray *)dataArray;
//加载客户类型
- (void)loadTypeWithString:(NSString *)typeString;

@end
