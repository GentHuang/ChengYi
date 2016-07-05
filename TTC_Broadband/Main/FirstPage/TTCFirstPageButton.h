//
//  TTCFirstPageButton.h
//  TTC_Broadband
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCFirstPageButton : UIButton
//刷新图片
- (void)loadButtonImage:(UIImage *)image;
//刷新标题
- (void)loadButtonTitle:(NSString *)title;
@end
