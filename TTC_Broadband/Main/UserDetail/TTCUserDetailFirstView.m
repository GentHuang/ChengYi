//
//  TTCUserDetailFirstView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailFirstView.h"
//Macro
#define kButtonWidth (768/5)//4
#define kButtonTag 78000
#define kLabelTag 79000
@implementation TTCUserDetailFirstView
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    self.backgroundColor = WHITE;
    //创建按钮
    NSArray *imageArray = @[[UIImage imageNamed:@"udel_img_fir1"],[UIImage imageNamed:@"udel_img_fir2"],[UIImage imageNamed:@"udel_img_fir3"],[UIImage imageNamed:@"udel_img_fir4"],[UIImage imageNamed:@"udel_img_fir5"]];
//    NSArray *imageArray = @[[UIImage imageNamed:@"udel_img_fir1"],[UIImage imageNamed:@"udel_img_fir2"],[UIImage imageNamed:@"udel_img_fir3"]];
    for (int i = 0; i < imageArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        allButton.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
        allButton.layer.borderWidth = 0.5;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = WHITE;
        [allButton setImage:imageArray[i] forState:UIControlStateNormal];
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kButtonWidth);
            make.left.mas_equalTo(i*kButtonWidth-0.5);
        }];
    }
}
- (void)setSubViewLayout{
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    int selectedIndex = (int)(button.tag - kButtonTag);
    self.stringBlock([NSString stringWithFormat:@"%d",selectedIndex]);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载价格
- (void)loadPriceWithArray:(NSArray *)dataArray{
    for (int i = 0; i < dataArray.count; i ++) {
        UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
        allLabel.text = dataArray[i];
    }
}
@end

