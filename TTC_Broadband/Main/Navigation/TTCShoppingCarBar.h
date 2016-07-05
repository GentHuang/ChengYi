//
//  TTCShoppingCarBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCShoppingCarBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置购物车标题
- (void)loadShoppingCarHeaderLabel:(NSString *)title;
//设置营销人员姓名，客户姓名
- (void)loadWithSellManName:(NSString *)sName customerName:(NSString *)cName;
@end
