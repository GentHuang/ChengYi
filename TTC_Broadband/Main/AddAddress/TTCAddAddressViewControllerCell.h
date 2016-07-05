//
//  TTCAddAddressViewControllerCell.h
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kTopMode,
    kOtherMode
}CellMode;
@interface TTCAddAddressViewControllerCell : UITableViewCell
//选择Cell模式
- (void)selectCellModel:(CellMode)cellMode;
//加载住宅地址 片区 可安装业务 住宅状态
- (void)loadAddress:(NSString *)addressString area:(NSString *)areaString business:(NSString *)businessString status:(NSString *)statusString;
//加载业务区
- (void)loadArea:(NSString *)areaString;
//收起键盘
- (void)packUpKeyBoard;
@end
