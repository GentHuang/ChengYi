//
//  TTCProductLibTTopView.h
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProductLibTTopView : UIScrollView
//刷新产品分类
- (void)loadProductTypeWithArray:(NSArray *)dataArray titleImage:(NSArray*)imageArray;
@end
