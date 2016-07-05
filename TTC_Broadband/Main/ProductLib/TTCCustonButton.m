//
//  TTCCustonButton.m
//  TTC_Broadband
//
//  Created by apple on 16/4/11.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCCustonButton.h"

@implementation TTCCustonButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect size =  self.frame;
    //title
    CGRect titleOrigin= self.titleLabel.frame;
    //image
    CGRect imageOrigin= self.imageView.frame;
    //确定Y坐标
    imageOrigin.origin.y =size.size.height/2 - (self.imageView.frame.size.height/2+self.titleLabel.frame.size.height/2+8/2);
    titleOrigin.origin.y =imageOrigin.origin.y+self.imageView.frame.size.height+8;
    
    imageOrigin.origin.x =size.size.width/2-self.imageView.frame.size.width/2;
    titleOrigin.origin.x =size.size.width/2-self.titleLabel.frame.size.width/2;
    
    self.titleLabel.frame = titleOrigin;
    self.imageView.frame = imageOrigin;
    
}

@end
