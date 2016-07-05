//
//  TTCShoppingCarCellOtherView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCShoppingCarCellOtherView : UIView
//加载产品详情
- (void)loadWithImage:(NSString *)smallimg title:(NSString *)title contents:(NSString *)contents price:(NSString *)price count:(NSString *)count;
@end
