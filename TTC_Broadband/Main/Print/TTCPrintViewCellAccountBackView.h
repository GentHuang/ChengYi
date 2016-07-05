//
//  TTCPrintViewCellAccountBackView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCPrintViewCellAccountBackView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//加载业务类型
- (void)loadTypeWithString:(NSString *)type;
//是否选择(全局)
- (void)isAllSelected:(BOOL)isAllSelected;
//加载已选总额
- (void)loadSelectedPrice:(float)price;
//是否下拉
- (void)isDrag:(BOOL)isDrag;
@end
