//
//  TTCFirstPageBannerView.h
//  TTC_Broadband
//
//  Created by apple on 16/1/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCFirstPageBannerView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//添加Banner
- (void)loadBannerWithImageArray:(NSArray *)imageArray;
@end
