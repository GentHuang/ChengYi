//
//  TTCSellCountViewCellTopView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
#import "TTCSellCountViewCellTopView.h"
//Macro
#define kButtonTag 13000
#define kButtonWidth (513/2)
#define kLabelTag 33000
@interface TTCSellCountViewCellTopView()
@property (assign, nonatomic) NSString *buttonString;
@end
@implementation TTCSellCountViewCellTopView
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
    //创建按钮
    //创建按钮
    NSArray *imageArray = @[[UIImage imageNamed:@"sell_img_account"],[UIImage imageNamed:@"sell_img_account"],[UIImage new]];
    NSArray *titleArray = @[@"本月销售额",@"今日销售额",@"月度排名"];
    NSArray *priceArray = @[@"0.00",@"0.00",@"0"];
    for (int i = 0; i < imageArray.count; i ++) {
        //按钮
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = WHITE;
        allButton.layer.borderColor = [LINEGRAY CGColor];
        allButton.layer.borderWidth = 0.5;
        [allButton setImage:imageArray[i] forState:UIControlStateNormal];
        [allButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        allButton.titleLabel.font = FONTSIZESBOLD(33/2);
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(-40, -5, 0, 0)];
        [allButton setTitleEdgeInsets:UIEdgeInsetsMake(-40, 0, 0, 0)];
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kButtonWidth);
            make.left.mas_equalTo(i*kButtonWidth-0.5);
        }];
        //金额或排名显示
//        UIView *backView = [[UIView alloc] init];
//        backView.userInteractionEnabled = NO;
//        [self addSubview:backView];
//        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(65/2);
//            make.left.right.bottom.mas_equalTo(0);
//        }];
        if (i <= 1) {
            //金额标题
            UILabel *allLabel = [[UILabel alloc] init];
            allLabel.tag = i + kLabelTag;
            allLabel.userInteractionEnabled = NO;
            allLabel.textColor = ORANGE;
            allLabel.textAlignment = NSTextAlignmentCenter;
            allLabel.font = FONTSIZESBOLD(56/2);
            allLabel.text = priceArray[i];
            [allButton addSubview:allLabel];
            [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-45/2);
                make.centerX.mas_equalTo(allButton.mas_centerX);
            }];
            //rmb
            UIImageView *rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_rmb"]];
            rmbImageView.userInteractionEnabled = NO;
            [allButton addSubview:rmbImageView];
            [rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(allLabel.mas_bottom).with.offset(-8);
                make.right.mas_equalTo(allLabel.mas_left).with.offset(-20/2);
            }];
        }else{
            //金额标题
            UILabel *allLabel = [[UILabel alloc] init];
            allLabel.tag = i + kLabelTag;
            allLabel.userInteractionEnabled = NO;
            allLabel.textColor = ORANGE;
            allLabel.textAlignment = NSTextAlignmentLeft;
            allLabel.font = FONTSIZESBOLD(56/2);
            allLabel.text = priceArray[i];
            [allButton addSubview:allLabel];
            [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-45/2);
                make.centerX.mas_equalTo(allButton.mas_centerX);
            }];
            //排名
            UILabel *rankLabel = [[UILabel alloc] init];
            rankLabel.text = @"第        名";
            rankLabel.textColor = ORANGE;
            rankLabel.font = FONTSIZESBOLD(20/2);
            [allButton addSubview:rankLabel];
            [rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(allLabel.mas_bottom).with.offset(-6);
                make.centerX.mas_equalTo(allButton.mas_centerX);
            }];
//            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(rankLabel.mas_right);
//                make.bottom.mas_equalTo(rankLabel.mas_bottom);
//            }];
        }
    }
}
- (void)setSubViewLayout{
    
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    self.buttonString = button.titleLabel.text;
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:self.buttonString object:self userInfo:nil];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//载入顶部数据
- (void)loadWithMSales:(NSString *)mSales dSales:(NSString *)dSales ranking:(NSString *)ranking{
    for (int i = 0; i < 3; i ++) {
        UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
        switch (i) {
            case 0:
                allLabel.text = mSales;
                break;
            case 1:
                allLabel.text = dSales;
                break;
            case 2:
                allLabel.text = ranking;
                break;
            default:
                break;
        }
    }
}

@end
