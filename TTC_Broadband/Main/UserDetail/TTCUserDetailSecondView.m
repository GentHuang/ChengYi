//
//  TTCUserDetailTTopView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailSecondView.h"
//Macro
#define kButtonWidth (515/2)
#define kButtonTag 8000
#define kLabelTag 9000
@implementation TTCUserDetailSecondView
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
    NSArray *imageArray = @[[UIImage imageNamed:@"udel_btn_sum"],[UIImage imageNamed:@"udel_btn_debt"],[UIImage imageNamed:@"udel_btn_ticket"]];
    NSArray *titleArray = @[@"余额",@"欠费",@"未开票"];
    for (int i = 0; i < imageArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = WHITE;
        [allButton setImage:imageArray[i] forState:UIControlStateNormal];
        [allButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        allButton.titleLabel.font = FONTSIZESBOLD(33/2);
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(40, -5, 0, 0)];
        [allButton setTitleEdgeInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kButtonWidth);
            make.left.mas_equalTo(i*kButtonWidth-0.5);
        }];
        //金额显示
        UILabel *allLabel = [[UILabel alloc] init];
        allLabel.textColor = ORANGE;
        allLabel.textAlignment = NSTextAlignmentCenter;
        allLabel.font = FONTSIZESBOLD(56/2);
        allLabel.text = @"99.00";
        allLabel.tag = i + kLabelTag;
        [self addSubview:allLabel];
        [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(allButton.mas_centerX);
            make.top.mas_equalTo(65/2);
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
