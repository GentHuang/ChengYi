//
//  TTCPayQRCodeView.h
//  TTC_Broadband
//
//  Created by apple on 16/2/19.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TTCPayQRCodeView : UIView

//显示生成的二维码图片
- (void)ShowQRCodeImageViewWitURLString:(NSString *)urlString;
@end
