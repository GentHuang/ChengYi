//
//  TTCPrintDetailViewCell.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kFillInType,
    kPrinterType
}CellType;
@interface TTCPrintDetailViewCell : UITableViewCell
@property (copy, nonatomic) StringTransBlock stringBlock;
@property (copy, nonatomic) StringTransBlock changeBlock;
@property (copy, nonatomic) TapPressedBlock tapBlock;
//选择Cell类型
- (void)selectCellType:(CellType)type;
//添加打印机
- (void)loadPrinterWithNumber:(int)number;
//加载价格
- (void)loadPrice:(NSString *)price;
//加载发票本号
- (void)loadBooknoLabelWithBookno:(NSString *)bookno;
//加载发票编号
- (void)loadInvoNumWithInvoNum:(NSString *)invoString;
//收起键盘
- (void)packUpKeyBoard;
@end
