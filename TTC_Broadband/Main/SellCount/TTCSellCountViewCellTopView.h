//
//  TTCSellCountViewCellTopView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCSellCountViewCellTopView : UIView
//载入顶部数据
- (void)loadWithMSales:(NSString *)mSales dSales:(NSString *)dSales ranking:(NSString *)ranking;
@end
