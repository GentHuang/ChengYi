//
//  SDBaseProgressView.h
//  SDProgressView
//
//  Created by aier on 15-2-19.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SDColorMaker(r, g, b, a) [UIColor colorWithRed:71/256.0 green:168/256.0 blue:239/256.0 alpha:1]

#define SDProgressViewItemMargin 10

#define SDProgressViewFontScale (MIN(self.frame.size.width, self.frame.size.height) / 100.0)

// 背景颜色
#define SDProgressViewBackgroundColor SDColorMaker(204, 204, 204, 0.9)

@interface SDBaseProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)setCenterProgressText:(NSString *)text withAttributes:(NSDictionary *)attributes;

- (void)dismiss;

+ (id)progressView;

@end
