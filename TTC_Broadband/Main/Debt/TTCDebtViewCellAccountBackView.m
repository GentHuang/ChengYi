//
//  TTCDebtViewCellAccountBackView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCDebtViewCellAccountBackView.h"
@interface TTCDebtViewCellAccountBackView()
@property (strong, nonatomic) UILabel *accountNameLabel;
@property (strong, nonatomic) UIImageView *accountRMBImageView;
@property (strong, nonatomic) UILabel *accountLabel;
@property (strong, nonatomic) UIButton *accountButton;
@property (strong, nonatomic) UILabel *totalPriceLabel;
@property (strong, nonatomic) UILabel *totalPriceNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@end
@implementation TTCDebtViewCellAccountBackView
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
    //未开发票总额
    _accountNameLabel = [[UILabel alloc] init];
    _accountNameLabel.textAlignment = NSTextAlignmentRight;
    _accountNameLabel.text = @"欠费总额：";
    _accountNameLabel.textColor = [UIColor lightGrayColor];
    _accountNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_accountNameLabel];
    //RMB图片
    _accountRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb"]];
    [self addSubview:_accountRMBImageView];
    //总价
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.text = @"0.00";
    _accountLabel.textColor = DARKBLUE;
    _accountLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_accountLabel];
    //缴欠费
    _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _accountButton.layer.masksToBounds = YES;
    _accountButton.layer.cornerRadius = 3;
    _accountButton.backgroundColor = DARKBLUE;
    [_accountButton setTitle:@"缴欠费" forState:UIControlStateNormal];
    [_accountButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _accountButton.titleLabel.font = FONTSIZESBOLD(31/2);
    [self addSubview:_accountButton];
    //已选欠费
    _totalPriceLabel = [[UILabel alloc] init];
    _totalPriceLabel.text = @"0.00";
    _totalPriceLabel.textColor = [UIColor lightGrayColor];
    _totalPriceLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_totalPriceLabel];
    //rmb
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb"]];
    [self addSubview:_rmbImageView];
    //已选欠费
    _totalPriceNameLabel = [[UILabel alloc] init];
    _totalPriceNameLabel.text = @"已选欠费：";
    _totalPriceNameLabel.textColor = [UIColor lightGrayColor];
    _totalPriceNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_totalPriceNameLabel];
}
- (void)setSubViewLayout{
    //未开发票总额
    [_accountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(60/2);
        make.width.mas_equalTo(120);
    }];
    //RMB图片
    [_accountRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(1);
        make.left.mas_equalTo(_accountNameLabel.mas_right).with.offset(10);
    }];
    //总价
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_accountRMBImageView.mas_right).with.offset(2);
    }];
    //缴欠费
    [_accountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60/2);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(174/2);
        make.height.mas_equalTo(53/2);
    }];
    //已选欠费
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_accountButton.mas_left).with.offset(-36/2);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    //rmb
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_totalPriceLabel.mas_left).with.offset(-2);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(1);
    }];
    //已选欠费
    [_totalPriceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_rmbImageView.mas_left).with.offset(0);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed{
    self.buttonBlock(nil);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCDebtViewCellAccountBackView" object:self userInfo:nil];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载总价
- (void)loadPrice:(NSString *)price{
    _accountLabel.text = price;
    if ([price isEqualToString:@"0"]) {
        _accountButton.enabled = NO;
    }
}
//加载已选欠费
- (void)loadTotalPrice:(NSString *)totalPrice{
    _totalPriceLabel.text = totalPrice;
}
//加载总额名称，是否隐藏已选欠费，按钮名称
- (void)loadPriceNameWithPriceName:(NSString *)priceName hide:(BOOL)isHide buttonTitle:(NSString *)buttonTitle{
    _accountNameLabel.text = priceName;
    _totalPriceLabel.hidden = isHide;
    _rmbImageView.hidden = isHide;
    _totalPriceNameLabel.hidden = isHide;
    [_accountButton setTitle:buttonTitle forState:UIControlStateNormal];
}
@end
