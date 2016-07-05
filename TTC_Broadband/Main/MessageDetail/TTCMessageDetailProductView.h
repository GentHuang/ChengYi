//
//  TTCMessageDetailProductView.h
//  TTC_Broadband
//
//  Created by apple on 16/3/21.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCMessageDetailProductView : UIView
@property (copy,nonatomic) ButtonPressedBlock buttonClick;
//刷新数据
- (void)reloadDataWithString:(NSString*)titleName PriceString:(NSString*)price;
@end
