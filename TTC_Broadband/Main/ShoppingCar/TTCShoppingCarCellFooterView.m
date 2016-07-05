//
//  TTCShoppingCarCellFooterView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCShoppingCarCellFooterView.h"

@interface TTCShoppingCarCellFooterView()
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIImageView *debtImageView;
@property (strong, nonatomic) UILabel *debtTitleLabel;
@property (strong, nonatomic) UILabel *debtPriceLabel;
@property (strong, nonatomic) UIImageView *rmbBRImageView;
@property (strong, nonatomic) UILabel *sumLabel;
@property (strong, nonatomic) UIImageView *rmbBLImageView;
@property (strong, nonatomic) UILabel *allPriceLabel;
@property (strong, nonatomic) UIButton *payButton;
@property (strong, nonatomic) UIButton *btnAllSelect;
@end

@implementation TTCShoppingCarCellFooterView
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
    self.clipsToBounds = YES;
    // 全选按钮
    _btnAllSelect = [[UIButton alloc]init];
    _btnAllSelect.selected = YES;
    [_btnAllSelect setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:0];
    [_btnAllSelect addTarget:self action:@selector(allSelectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnAllSelect];
    
    //下划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithRed:220/256.0 green:220/256.0 blue:223/256.0 alpha:1];
    [self addSubview:_lineView];
    //debtImageView
    _debtImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_debt"]];
    _debtImageView.hidden = YES;
    [self addSubview:_debtImageView];
    //欠费
    _debtTitleLabel = [[UILabel alloc] init];
    _debtTitleLabel.hidden = YES;
    _debtTitleLabel.text = @"欠费";
    _debtTitleLabel.textColor = LIGHTDARK;
    _debtTitleLabel.font = FONTSIZESBOLD(40/2);
    [self addSubview:_debtTitleLabel];
    //欠费价格
    _debtPriceLabel = [[UILabel alloc] init];
    _debtPriceLabel.hidden = YES;
    _debtPriceLabel.text = @"200.00";
    _debtPriceLabel.textAlignment = NSTextAlignmentRight;
    _debtPriceLabel.font = FONTSIZESBOLD(58/2);
    _debtPriceLabel.textColor = ORANGE;
    [self addSubview:_debtPriceLabel];
    //rmb(右大)
    _rmbBRImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_big_right"]];
    _rmbBRImageView.hidden = YES;
    [self addSubview:_rmbBRImageView];
    //总计
    _sumLabel = [[UILabel alloc] init];
    _sumLabel.textColor = [UIColor lightGrayColor];
    _sumLabel.text = @"总计：";
    _sumLabel.font = FONTSIZESBOLD(35/2);
    [self addSubview:_sumLabel];
    //rmb(左大)
    _rmbBLImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_big_left"]];
    [self addSubview:_rmbBLImageView];
    //总价
    _allPriceLabel = [[UILabel alloc] init];
    _allPriceLabel.text = @"600.00";
    _allPriceLabel.textColor = [UIColor orangeColor];
    _allPriceLabel.font = FONTSIZESBOLD(50/2);
    [self addSubview:_allPriceLabel];
    //立即付款
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.backgroundColor = DARKBLUE;
    [_payButton setTitle:@"结    算" forState:UIControlStateNormal];
    [_payButton setTitleColor:WHITE forState:UIControlStateNormal];
    [_payButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _payButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = 4;
    [self addSubview:_payButton];
}
- (void)setSubViewLayout{
    //下划线
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(129/2);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    //debtImageView
    [_debtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(55/2);
        make.left.mas_equalTo(60/2);
    }];
    //欠费
    [_debtTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_debtImageView.mas_centerY);
        make.left.mas_equalTo(_debtImageView.mas_right).with.offset(18/2);
    }];
    //欠费价格
    [_debtPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-58/2);
        make.top.mas_equalTo(46/2);
    }];
    //rmb(右大)
    [_rmbBRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_debtPriceLabel.mas_left).with.offset(-30/2);
        make.top.mas_equalTo(_debtPriceLabel.mas_top).with.offset(12);
    }];
    // 全选
    [_btnAllSelect mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(20);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(60);
    }];
    //总计
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(self.btnAllSelect.mas_right).with.offset(10);
    }];
    //rmb(左大)
    [_rmbBLImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(2);
        make.left.mas_equalTo(_sumLabel.mas_right).with.offset(10/2);
    }];
    //总价
    [_allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_rmbBLImageView.mas_right).with.offset(20/2);
    }];
    //立即付款
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_debtPriceLabel.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(190/2);
        make.height.mas_equalTo(60/2);
    }];
}

#pragma mark 全选
- (void) allSelectedBtnClick:(UIButton *)button{
    
    [_btnAllSelect setImage:button.selected?[UIImage imageNamed:@"debt_btn_normal"]:[UIImage imageNamed:@"debt_btn_selected"] forState:0];
    if (button.selected) {
        
        button.selected = NO;
    }
    else{
        
        button.selected = YES;
    }
    if ([self.footerViewdelegate respondsToSelector:@selector(btnAllSelectedWithButton:)]) {
        
        [self.footerViewdelegate btnAllSelectedWithButton:button];
    }
}
// 根据单选状态改变全选的状态
- (void) changeAllSelectButtonStatus:(BOOL)singleBtnFlag{
    _btnAllSelect.selected = singleBtnFlag;
    [_btnAllSelect setImage:singleBtnFlag?[UIImage imageNamed:@"debt_btn_selected"]:[UIImage imageNamed:@"debt_btn_normal"] forState:0];
}

#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{

    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCShoppingCarCellFooterView" object:self userInfo:nil];
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载总价
- (void)loadAllPrice:(NSString *)allPrice{
    // 当按钮选择后才显示
    _allPriceLabel.text = allPrice;
}
@end
