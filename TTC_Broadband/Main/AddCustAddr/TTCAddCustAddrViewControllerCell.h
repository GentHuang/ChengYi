//
//  TTCAddCustAddrViewControllerCell.h
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    kTopMode,
    kOtherMode
}CellMode;
@interface TTCAddCustAddrViewControllerCell : UITableViewCell
//选择Cell模式
- (void)selectCellModel:(CellMode)cellMode;
//加载住宅地址 片区 可安装业务 住宅状态
- (void)loadAddress:(NSString *)addressString area:(NSString *)areaString business:(NSString *)businessString status:(NSString *)statusString;
//收起键盘
- (void)packUpKeyBoard;
//加载业务区
- (void)loadAreaLabelWithAreaString:(NSString *)areaString;
@end
