//
//  TTCModifiedDataDragView.h
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCModifiedDataDragView : UIView
@property (copy, nonatomic) StringTransBlock stringBlock;
//弹出View
- (void)dragDownList;
//收起View
- (void)packUpList;
@end
