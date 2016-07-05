//
//  TTCMeViewCellHeaderView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCMeViewCellHeaderView.h"
//Macro
#define kButtonWidth (768/2)
#define kButtonTag 88000
#define kLabelTag 89000
@implementation TTCMeViewCellHeaderView
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    self.backgroundColor = WHITE;
    //创建按钮
    NSArray *imageArray = @[[UIImage imageNamed:@"me_btn_1"],[UIImage imageNamed:@"me_btn_2"]];
    for (int i = 0; i < imageArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = WHITE;
        allButton.layer.borderColor = [LINEGRAY CGColor];
        allButton.layer.borderWidth = 0.5;
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
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    int selectedIndex = (int)(button.tag - kButtonTag);
    self.stringBlock([NSString stringWithFormat:@"%d",selectedIndex]);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
@end

