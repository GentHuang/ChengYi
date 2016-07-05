//
//  TTCOrderRecordViewCellSetFooterView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewCellSetFooterView.h"
@interface TTCOrderRecordViewCellSetFooterView()
@property (strong, nonatomic) UILabel *totalNameLabel;
@property (strong, nonatomic) UIImageView *rmbLeftImageView;
@property (strong, nonatomic) UILabel *totalLabel;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *payTypeLabel;
@end

@implementation TTCOrderRecordViewCellSetFooterView
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
    //总金额
    _totalNameLabel = [[UILabel alloc] init];
    _totalNameLabel.text = @"总金额：";
    _totalNameLabel.textColor = [UIColor lightGrayColor];
    _totalNameLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_totalNameLabel];
    //RMB(左)
    _rmbLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb1"]];
    [self addSubview:_rmbLeftImageView];
    //总价
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.textColor = [UIColor orangeColor];
    _totalLabel.font = FONTSIZESBOLD(30/2);
    _totalLabel.text = @"10.00";
    [self addSubview:_totalLabel];
    //受理人
    _userLabel = [[UILabel alloc] init];
    _userLabel.textAlignment = NSTextAlignmentRight;
    _userLabel.text = @"中山营业厅销售部 张三";
    _userLabel.textColor = [UIColor lightGrayColor];
    _userLabel.font = FONTSIZESBOLD(26/2);
    [self addSubview:_userLabel];
    //下划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    //支付类型
    _payTypeLabel = [[UILabel alloc] init];
    _payTypeLabel.text = @"";
    _payTypeLabel.textColor = [UIColor lightGrayColor];
    _payTypeLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_payTypeLabel];
}
- (void)setSubViewLayout{
    //总金额
    [_totalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(57/2);
    }];
    //RMB(左)
    [_rmbLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_totalNameLabel.mas_bottom).with.offset(-2.5);
        make.left.mas_equalTo(_totalNameLabel.mas_right);
    }];
    //总价
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_rmbLeftImageView.mas_right).with.offset(2);
    }];
    //支付类型
    [_payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_totalLabel.mas_right).with.offset(70/2);
    }];
    //受理人
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-57/2);
    }];
    //下划线
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(1);
        make.left.mas_equalTo(54/2);
        make.right.mas_equalTo(-50/2);
        make.height.mas_equalTo(0.5);
    }];

}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载总金额 营销人员部门 姓名
- (void)loadPrice:(NSString *)price sellManDepName:(NSString *)depName name:(NSString *)name{
    _totalLabel.text = price;
    _userLabel.text = [NSString stringWithFormat:@"%@ %@",depName,name];
}
//加载支付状态
- (void)loadTypeLabelWithTypeString:(NSString *)string{
    _payTypeLabel.text = [NSString stringWithFormat:@"支付状态:%@",string];
}
@end
