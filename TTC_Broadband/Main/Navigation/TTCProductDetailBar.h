//
//  TTCProductDetailBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProductDetailBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置产品详情标题
- (void)loadproductDetailHeaderLabel:(NSString *)title;
//设置是否可以后退
- (void)canGoBack:(BOOL)canGoBack;
@end
