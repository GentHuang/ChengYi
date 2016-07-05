//
//  FSLineChart.m
//  FSLineChart
//
//  Created by Arthur GUIBERT on 30/09/2014.
//  Copyright (c) 2014 Arthur GUIBERT. All rights reserved.
//
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <QuartzCore/QuartzCore.h>
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

@interface FSLineChart ()

@property (nonatomic, strong) NSMutableArray* data;

@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat max;
@property (nonatomic) CGMutablePathRef initialPath;
@property (nonatomic) CGMutablePathRef newPath;

@end

@implementation FSLineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setDefaultParameters];
    }
    return self;
}
- (void)setChartData:(NSArray *)chartData
{
    _data = [NSMutableArray arrayWithArray:chartData];
    
    _min = MAXFLOAT;
    _max = -MAXFLOAT;
    
    for(int i=0;i<_data.count;i++) {
        NSNumber* number = _data[i];
        if([number floatValue] < _min)
            _min = [number floatValue];
        
        if([number floatValue] > _max)
            _max = [number floatValue];
    }
    
    _max = [self getUpperRoundNumber:_max forGridStep:_gridStep];
    
    // No data
    if(isnan(_max)) {
        _max = 1;
    }
    
    [self strokeChart];
    
    if(_labelForValue) {
        for(int i=0;i<_gridStep;i++) {
            CGPoint p = CGPointMake(_margin + _axisWidth, _axisHeight + _margin - (i + 1) * _axisHeight / _gridStep);
            
            NSString* text = _labelForValue(_max / _gridStep * (i + 1));
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(-100, p.y - 7, 100, 14)];
            label.text = text;
            label.font = [UIFont systemFontOfSize:12.0f];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentRight;
            
            [self addSubview:label];
        }
    }
    
    if(_labelForIndex) {
        NSArray *nameArray = @[@"本月",@"一个月前",@"二个月前",@"三个月前",@"四个月前",@"五个月前",@"半年前"];
        float scale = 1.0f;
        int q = (int)_data.count / _gridStep;
        scale = (CGFloat)(q * _gridStep) / (CGFloat)(_data.count - 1);
        
        for(int i=0;i<_gridStep + 1;i++) {
//            NSInteger itemIndex = q * i;
//            if(itemIndex >= _data.count)
//            {
//                itemIndex = _data.count - 1;
//            }
            
//            NSString* text = _labelForIndex(itemIndex);
            CGPoint p = CGPointMake(_margin + i * (_axisWidth / _gridStep) * scale - 6, _axisHeight + _margin);
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - 4.0f, p.y + 2, self.frame.size.width, 14)];
            label.text = nameArray[i];
            label.font = [UIFont boldSystemFontOfSize:10.0f];
            label.textColor = [UIColor grayColor];
            [self addSubview:label];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawGrid];
}

- (void)drawGrid
{
    //表格背景
    for(int i=0;i<_gridStep;i++) {
        CGPoint point = CGPointMake(i * _axisWidth / _gridStep * 1 + _margin, i * _axisHeight / _gridStep + _margin);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 249/256.0, 245/256.0, 241/256.0, (i%2)*1); //方框的填充色
        CGContextFillRect(context, CGRectMake(_margin+3, point.y, _axisWidth-2, _axisHeight/_gridStep)); //画一个方框
    }
    //轴线样式
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    CGContextSetLineWidth(ctx, 3);
    CGContextSetStrokeColorWithColor(ctx, [_axisColor CGColor]);
    //X与Y轴
    CGContextMoveToPoint(ctx, _margin, _margin);
    CGContextAddLineToPoint(ctx, _margin, _axisHeight + _margin + 3);
    CGContextStrokePath(ctx);
    CGContextMoveToPoint(ctx, _margin, _axisHeight + _margin);
    CGContextAddLineToPoint(ctx, _axisWidth + _margin, _axisHeight + _margin);
    CGContextStrokePath(ctx);
    
    float scale = 1.0f;
    int q = (int)_data.count / _gridStep;
    scale = (CGFloat)(q * _gridStep) / (CGFloat)(_data.count - 1);
    
    // draw grid
    //中间空格线样式
    CGContextRef cty = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(cty);
    CGContextSetLineWidth(cty, 2);
    CGContextSetStrokeColorWithColor(cty, [[UIColor colorWithRed:238/256.0 green:214/256.0 blue:219/256.0 alpha:1] CGColor]);
    //Y轴线条样式
    for(int i=0;i<_gridStep;i++) {
        //坐标
        CGPoint point = CGPointMake((1 + i) * _axisWidth / _gridStep * scale + _margin, _margin);
        //画线
        CGContextSetLineWidth(cty, 2);
        //表格线
        CGContextMoveToPoint(cty, point.x, point.y);
        CGContextAddLineToPoint(cty, point.x, _axisHeight + _margin);
        CGContextStrokePath(cty);
        //最底突出指示线
        CGContextSetLineWidth(cty, 2);
        CGContextMoveToPoint(cty, point.x, _axisHeight + _margin + 1);
        CGContextAddLineToPoint(cty, point.x, _axisHeight + _margin + 4);
        CGContextStrokePath(cty);
    }
    //X轴线条样式
    for(int i=0;i<_gridStep;i++) {
        CGContextSetLineWidth(cty, 2);
        
        CGPoint point = CGPointMake(_margin, (i) * _axisHeight / _gridStep + _margin);
        
        CGContextMoveToPoint(cty, point.x, point.y);
        CGContextAddLineToPoint(cty, _axisWidth + _margin, point.y);
        CGContextStrokePath(cty);
    }
}

- (void)strokeChart
{
    if([_data count] == 0) {
        NSLog(@"Warning: no data provided for the chart");
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *noPath = [UIBezierPath bezierPath];
    UIBezierPath* fill = [UIBezierPath bezierPath];
    UIBezierPath* noFill = [UIBezierPath bezierPath];
    
    CGFloat scale = _axisHeight / _max;
    NSNumber* first = _data[0];
    
    for(int i=1;i<_data.count;i++) {
        NSNumber* last = _data[i - 1];
        NSNumber* number = _data[i];
        
        CGPoint p1 = CGPointMake(_margin + (i - 1) * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [last floatValue] * scale);
        
        CGPoint p2 = CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [number floatValue] * scale);
        
        [fill moveToPoint:p1];
        [fill addLineToPoint:p2];
        [fill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [fill addLineToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
        
        [noFill moveToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p2.x, _axisHeight + _margin)];
        [noFill addLineToPoint:CGPointMake(p1.x, _axisHeight + _margin)];
    }
    
    
    [path moveToPoint:CGPointMake(_margin, _axisHeight + _margin - [first floatValue] * scale)];
    [noPath moveToPoint:CGPointMake(_margin, _axisHeight + _margin)];
    
    for(int i=1;i<_data.count;i++) {
        NSNumber* number = _data[i];
        
        [path addLineToPoint:CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [number floatValue] * scale)];
        [noPath addLineToPoint:CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin)];
    }
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.frame = self.bounds;
    fillLayer.bounds = self.bounds;
    fillLayer.path = fill.CGPath;
    fillLayer.strokeColor = nil;
    fillLayer.fillColor = [_color colorWithAlphaComponent:0.25].CGColor;
    fillLayer.lineWidth = 0;
    fillLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:fillLayer];
    
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.bounds = self.bounds;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [_color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 3;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pathLayer];
    
    CABasicAnimation *fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = 1;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.fromValue = (id)noFill.CGPath;
    fillAnimation.toValue = (id)fill.CGPath;
    [fillLayer addAnimation:fillAnimation forKey:@"path"];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = (__bridge id)(noPath.CGPath);
    pathAnimation.toValue = (__bridge id)(path.CGPath);
    [pathLayer addAnimation:pathAnimation forKey:@"path"];
    //创建小圆点
    [self performSelector:@selector(createPointImageView) withObject:self afterDelay:1];
}
//创建小圆点
- (void)createPointImageView{
    CGFloat pointScale = _axisHeight / _max;
    //最后小圆点的坐标
    CGFloat lastX = 0.0;
    CGFloat lastY = 0.0;
    for(int i=1;i<_data.count;i++) {
        NSNumber* last = _data[i - 1];
        NSNumber* number = _data[i];
        CGPoint p1 = CGPointMake(_margin + (i - 1) * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [last floatValue] * pointScale);
        CGPoint p2 = CGPointMake(_margin + i * (_axisWidth / (_data.count - 1)), _axisHeight + _margin - [number floatValue] * pointScale);
        lastX = p2.x;
        lastY = p2.y;
        //小圆点
        UIImageView *pointImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sell_img_dot"]];
        pointImageView.alpha = 0;
        pointImageView.center = CGPointMake(p1.x, p1.y);
        pointImageView.bounds = CGRectMake(0, 0, 10, 10);
        pointImageView.backgroundColor = CLEAR;
        [self addSubview:pointImageView];
        [UIView animateWithDuration:0.5 animations:^{
            pointImageView.alpha = 1;
        }];
    }
    //小圆点
    UIImageView *pointImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sell_img_dot"]];
    pointImageView.alpha = 0;
    pointImageView.center = CGPointMake(lastX, lastY);
    pointImageView.bounds = CGRectMake(0, 0, 10, 10);
    pointImageView.backgroundColor = CLEAR;
    [self addSubview:pointImageView];
    [UIView animateWithDuration:0.5 animations:^{
        pointImageView.alpha = 1;
    }];
}

- (void)setDefaultParameters
{
    _color = [UIColor fsLightBlue];
    _gridStep = 3;
    _margin = 5.0f;
    _axisWidth = self.frame.size.width - 2 * _margin;
    _axisHeight = self.frame.size.height - 2 * _margin;
    _axisColor = [UIColor colorWithWhite:0.7 alpha:1];
    
}

- (CGFloat)getUpperRoundNumber:(CGFloat)value forGridStep:(int)gridStep
{
    // We consider a round number the following by 0.5 step instead of true round number (with step of 1)
    CGFloat logValue = log10f(value);
    CGFloat scale = powf(10, floorf(logValue));
    CGFloat n = ceilf(value / scale * 2);
    
    int tmp = (int)(n) % gridStep;
    
    if(tmp != 0) {
        n += gridStep - tmp;
    }
    
    return n * scale / 2.0f;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
