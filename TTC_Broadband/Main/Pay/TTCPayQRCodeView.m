//
//  TTCPayQRCodeView.m
//  TTC_Broadband
//
//  Created by apple on 16/2/19.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCPayQRCodeView.h"
#define QRSIZE 320

@interface TTCPayQRCodeView()

@property (strong ,nonatomic)  UIImageView *backgroundImageView;
@property (strong , nonatomic) UIImageView *ShowQRCodeImageView;
//提示Label
@property (strong , nonatomic) UILabel *promptLabel;
@end

@implementation TTCPayQRCodeView

- (instancetype)init {
    if (self =[super init]) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    //背景大图
    _backgroundImageView = [[UIImageView alloc]init];
    [self addSubview:_backgroundImageView];
    _backgroundImageView.backgroundColor = WHITE;
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(350);
    }];
    //二维码图片
    _ShowQRCodeImageView = [[UIImageView alloc]init];
    [_backgroundImageView addSubview:_ShowQRCodeImageView];
    _ShowQRCodeImageView.backgroundColor = [UIColor whiteColor];
    
    [_ShowQRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_backgroundImageView);
        make.width.height.mas_equalTo(QRSIZE);
    }];
    //提示文字
    _promptLabel = [[UILabel alloc]init];
    [_backgroundImageView addSubview:_promptLabel];
    _promptLabel.text = @"扫一扫上面的二维码图案，即可购买";
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.font = [UIFont systemFontOfSize:20];
    _promptLabel.backgroundColor = WHITE;
    
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_ShowQRCodeImageView);
        make.top.mas_equalTo(_ShowQRCodeImageView.mas_bottom).offset(0);
        make.width.mas_equalTo(QRSIZE);
        make.height.mas_equalTo(30);
    }];
}
//显示二维码图片
- (void)ShowQRCodeImageViewWitURLString:(NSString *)urlString {
    //实例化二维码滤镜
    CIFilter *qrfilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [qrfilter setDefaults];
    //将字符串转换成NSData
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    [qrfilter setValue:data forKey:@"inputMessage"];
    //生成二维码
    CIImage *outputImage = [qrfilter outputImage];
    _ShowQRCodeImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:QRSIZE];
    
}
// 生成一个清晰的图片
-(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


//点击移除视图
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
@end
