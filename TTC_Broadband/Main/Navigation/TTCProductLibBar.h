//
//  TTCProductLibBar.h
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCProductLibBar : UINavigationBar
@property (copy, nonatomic) StringTransBlock stringBlock;
//设置产品库标题
- (void)loadProductLibHeaderLabel:(NSString *)title;
@end
