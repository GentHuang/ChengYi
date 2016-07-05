//
//  TTCOrderRecordViewCellSetDetailView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewCellSetDetailView.h"
@interface TTCOrderRecordViewCellSetDetailView()
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *timesLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UIButton *buyButton;
@property (strong, nonatomic) UIButton *payButton;
@end

@implementation TTCOrderRecordViewCellSetDetailView
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
    //前置图片
    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_img1"]];
    _cellImageView.hidden = YES;
    [self addSubview:_cellImageView];
    //高清营销方案
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"高清营销方案";
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = FONTSIZESBOLD(30/2);
    _nameLabel.textColor = LIGHTDARK;
    [self addSubview:_nameLabel];
    //rmb
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb2"]];
    _rmbImageView.hidden = YES;
    [self addSubview:_rmbImageView];
    //价钱
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.hidden = YES;
    _priceLabel.text = @"100.00";
    _priceLabel.textColor = [UIColor lightGrayColor];
    _priceLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_priceLabel];
    //件数
    _timesLabel = [[UILabel alloc] init];
    _timesLabel.hidden = YES;
    _timesLabel.text = @"X2";
    _timesLabel.textColor = [UIColor lightGrayColor];
    _timesLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_timesLabel];
    //时间
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.hidden = YES;
    _dateLabel.text = @"开始时间 2015-07 结束时间 2015-09";
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_dateLabel];
    //打印受理单
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.hidden = YES;
    [_buyButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _buyButton.backgroundColor = DARKBLUE;
    [_buyButton setTitle:@"打印受理单" forState:UIControlStateNormal];
    [_buyButton setTitleColor:WHITE forState:UIControlStateNormal];
    _buyButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = 4;
    [self addSubview:_buyButton];
    //前往支付
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _payButton.backgroundColor = DARKBLUE;
    [_payButton setTitle:@"前往支付" forState:UIControlStateNormal];
    [_payButton setTitleColor:WHITE forState:UIControlStateNormal];
    _payButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = 4;
    [self addSubview:_payButton];
}
- (void)setSubViewLayout{
    //前置图片
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(54/2);
    }];
    //高清营销方案
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
//        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(40/2);
        make.left.mas_equalTo(57/2);
        make.right.mas_equalTo(-57/2);
        make.height.mas_equalTo(self.mas_height);
    }];
    //rmb
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(26/2);
    }];
    //价钱
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_rmbImageView.mas_right).with.offset(5);
        make.top.mas_equalTo(_rmbImageView.mas_top).with.offset(-4);
    }];
    //件数
    [_timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right).with.offset(56/2);
        make.top.mas_equalTo(_priceLabel.mas_top);
    }];
    //时间
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.top.mas_equalTo(_priceLabel.mas_bottom).with.offset(21/2);
    }];
    //前往支付
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-57/2);
        make.width.mas_equalTo(175/2);
        make.height.mas_equalTo(50/2);
    }];
    //打印受理单
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_payButton.mas_left).with.offset(-5);
        make.width.mas_equalTo(175/2);
        make.height.mas_equalTo(50/2);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _payButton) {
        //前往支付
        self.indexBlock(0);
    }else if (button == _buyButton){
        //打印受理单
        self.indexBlock(1);
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载套餐详细内容
- (void)loadWithPname:(NSString *)pname createtime:(NSString *)createtime fees:(NSString *)fees count:(NSString *)count{
    if ([pname isEqualToString:@"2"]) {
        pname = @"充值账本";
    }
    _nameLabel.text = pname;
    NSString *dateString = [createtime stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
    _dateLabel.text = [NSString stringWithFormat:@"开始时间 %@",dateString];
    _priceLabel.text = fees;
    _timesLabel.text = [NSString stringWithFormat:@"X%@",count];
}
//加载套餐详细内容(销售明细)
- (void)loadWithTitle:(NSString *)title stime:(NSString *)stime price:(NSString *)price etime:(NSString *)etime{
    _nameLabel.text = title;
    NSRange range = [stime rangeOfString:@" "];
    NSString *stimeString = [stime substringToIndex:range.location];
    range = [etime rangeOfString:@" "];
    NSString *etimeString = [etime substringToIndex:range.location];
    _dateLabel.text = [NSString stringWithFormat:@"开始时间 %@ 结束时间 %@",stimeString,etimeString];
    _priceLabel.text = price;
    _timesLabel.text = @"";
}
//显示前往支付
- (void)goToPay:(BOOL)isAll{
    _payButton.hidden = isAll;
}
@end
