//
//  SDPieLoopProgressView.m
//  SDProgressView
//
//  Created by aier on 15-2-20.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDPieLoopProgressView.h"

@implementation SDPieLoopProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - SDProgressViewItemMargin * 0.2;
    // 背景环
    [[UIColor grayColor] set];
    CGContextMoveToPoint(ctx, xCenter, yCenter);
    CGContextAddLineToPoint(ctx, xCenter, 0);
    CGFloat back = - M_PI * 0.5 + 1 * M_PI * 2 + 0.001; // 初始值
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, back, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    // 进度环
    [SDProgressViewBackgroundColor set];
    CGContextMoveToPoint(ctx, xCenter, yCenter);
    CGContextAddLineToPoint(ctx, xCenter, 0);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    // 遮罩
    [WHITE set];
    CGFloat maskW = (radius - 15) * 2;
    CGFloat maskH = maskW;
    CGFloat maskX = (rect.size.width - maskW) * 0.5;
    CGFloat maskY = (rect.size.height - maskH) * 0.5;
    CGContextAddEllipseInRect(ctx, CGRectMake(maskX, maskY, maskW, maskH));
    CGContextFillPath(ctx);    
    // 进度数字
    NSString *progressStr = [NSString stringWithFormat:@"%.0f%s", self.progress * 100, "\%"];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20 * SDProgressViewFontScale];
    attributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:252/256.0 green:121/256.0 blue:37/256.0 alpha:1];
    [self setCenterProgressText:progressStr withAttributes:attributes];
}

@end
