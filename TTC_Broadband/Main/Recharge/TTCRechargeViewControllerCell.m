//
//  TTCRechargeViewControllerCell.m
//  TTC_Broadband
//
//  Created by apple on 15/12/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCRechargeViewControllerCell.h"
//Macro
#define kButtonTag 11000
@interface TTCRechargeViewControllerCell()<UITextFieldDelegate>
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) UIView *informationBackView;
@property (strong, nonatomic) UILabel *informationUserLabel;
@property (strong, nonatomic) UILabel *informationSellManLabel;
@property (strong, nonatomic) UILabel *informationRechargeNameLabel;
@property (strong, nonatomic) UIView *informationRechargeBackView;
@property (strong, nonatomic) UITextField *informationRechargeTextField;


@property (strong, nonatomic) UIView *choseBackView;
@property (strong, nonatomic) UILabel *choseLabel;
@property (strong, nonatomic) NSArray *choseArray;
@property (strong, nonatomic) UITextField *choseTextField;
@property (strong, nonatomic) UILabel *chosePlaceholderLabel;
@end

@implementation TTCRechargeViewControllerCell
#pragma mark - Init methods
- (void)initData{
    _choseArray = @[[UIImage imageNamed:@"pay_img1"],[UIImage imageNamed:@"pay_img2"],[UIImage imageNamed:@"pay_img3"]];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initData];
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark - Getters and setters
- (void)createUI{
    //信息类型
    //背景
    _informationBackView = [[UIView alloc] init];
    _informationBackView.hidden = YES;
    [self.contentView addSubview:_informationBackView];
    //用户
    _informationUserLabel = [[UILabel alloc] init];
    _informationUserLabel.text = @"用户 李四";
    _informationUserLabel.textColor = LIGHTDARK;
    _informationUserLabel.font = FONTSIZESBOLD(30/2);
    [_informationBackView addSubview:_informationUserLabel];
    //营销人员
    _informationSellManLabel = [[UILabel alloc] init];
    _informationSellManLabel.textAlignment = NSTextAlignmentRight;
    _informationSellManLabel.text = @"操作员";
    _informationSellManLabel.textColor = [UIColor lightGrayColor];
    _informationSellManLabel.font = FONTSIZESBOLD(24/2);
    [_informationBackView addSubview:_informationSellManLabel];
    //充值金额名称
    _informationRechargeNameLabel = [[UILabel alloc] init];
    _informationRechargeNameLabel.text = @"现金账本充值";
    _informationRechargeNameLabel.textColor = LIGHTDARK;
    _informationRechargeNameLabel.font = FONTSIZESBOLD(30/2);
    [_informationBackView addSubview:_informationRechargeNameLabel];
    //充值金额背景
    _informationRechargeBackView = [[UIView alloc] init];
    _informationRechargeBackView.layer.masksToBounds = YES;
    _informationRechargeBackView.layer.cornerRadius = 4;
    _informationRechargeBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _informationRechargeBackView.layer.borderWidth = 0.5;
    [_informationBackView addSubview:_informationRechargeBackView];
    //充值金额
    _informationRechargeTextField = [[UITextField alloc] init];
    _informationRechargeTextField.borderStyle = UITextBorderStyleNone;
    _informationRechargeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _informationRechargeTextField.delegate = self;
    //    [_informationRechargeTextField addTarget:self action:@selector(inputRechargePrice) forControlEvents:UIControlEventEditingChanged];
    [_informationRechargeBackView addSubview:_informationRechargeTextField];
    //选择支付
    //背景
    _choseBackView = [[UIView alloc] init];
    _choseBackView.hidden = YES;
    [self.contentView addSubview:_choseBackView];
    //支付方式
    _choseLabel = [[UILabel alloc] init];
    _choseLabel.text = @"支付方式";
    _choseLabel.textColor = LIGHTDARK;
    _choseLabel.font = FONTSIZESBOLD(30/2);
    [_choseBackView addSubview:_choseLabel];
    [_choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30/2);
        make.left.mas_equalTo(30/2);
    }];
    //创建选择列表
    for (int i = 0; i < _choseArray.count; i ++) {
        //按钮
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            allButton.selected = YES;
        }else{
            allButton.selected = NO;
        }
        allButton.backgroundColor = CLEAR;
        [allButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
        [allButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
        [allButton setImageEdgeInsets:UIEdgeInsetsMake(0, -127, 0, 0)];
        allButton.titleLabel.font = FONTSIZESBOLD(30/2);
        [_choseBackView addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_choseLabel.mas_bottom).with.offset(i*(80/2)+34/2);
            make.left.mas_equalTo(_choseLabel.mas_left);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(80/2);
        }];
        //标题
        UIImageView *allImageView = [[UIImageView alloc] initWithImage:_choseArray[i]];
        [_choseBackView addSubview:allImageView];
        [allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(allButton.mas_centerY);
            make.left.mas_equalTo(allButton.mas_left).with.offset(90/2);
        }];
    }
    //备注
    _choseTextField = [[UITextField alloc] init];
    _choseTextField.backgroundColor = CLEAR;
    _choseTextField.delegate = self;
    _choseTextField.layer.borderWidth = 0.5;
    _choseTextField.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _choseTextField.layer.masksToBounds = YES;
    _choseTextField.layer.cornerRadius = 5;
    _choseTextField.borderStyle = UITextBorderStyleNone;
    [_choseBackView addSubview:_choseTextField];
    //placeholder
    _chosePlaceholderLabel = [[UILabel alloc] init];
    _chosePlaceholderLabel.text = @"备注";
    _chosePlaceholderLabel.textColor = [UIColor lightGrayColor];
    _chosePlaceholderLabel.font = FONTSIZESBOLD(30/2);
    [_choseTextField addSubview:_chosePlaceholderLabel];
}
- (void)setSubViewLayout{
    //信息类型
    //背景
    [_informationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //用户
    [_informationUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(38/2);
    }];
    //营销人员
    [_informationSellManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_informationUserLabel.mas_centerY);
        make.right.mas_equalTo(-70/2);
    }];
    //充值金额名称
    [_informationRechargeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_informationUserLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_informationUserLabel.mas_left);
    }];
    //充值金额背景
    [_informationRechargeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_informationRechargeNameLabel.mas_centerY);
        make.left.mas_equalTo(_informationRechargeNameLabel.mas_right).with.offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(300);
    }];
    //充值金额
    [_informationRechargeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.right.mas_equalTo(0);
    }];
    //选择支付
    //背景
    [_choseBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //备注
    [_choseTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-54/2);
        make.left.mas_equalTo(30/2);
        make.right.mas_equalTo(-70/2);
        make.height.mas_equalTo(65/2);
    }];
    //placeholder
    [_chosePlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_choseTextField.mas_centerY);
        make.left.mas_equalTo(10);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    for (int i = 0; i < 4; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:(i+kButtonTag)];
        allButton.selected = NO;
    }
    button.selected = YES;
    switch (button.tag - kButtonTag) {
        case 0:
            //现金支付
            self.payWayString = @"C";
            break;
        case 1:
            //刷卡支付
            self.payWayString = @"2";
            break;
        case 2:
            //微信支付
            self.payWayString = @"99";
            break;
        case 3:
            self.payWayString = @"22";
            break;
        default:
            break;
    }
    self.stringBlock(_payWayString);
}
//输入金额
- (void)inputRechargePrice{
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"输入充值金额" object:self userInfo:@{@"rechargePrice":_informationRechargeTextField.text}];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITextFieldDelegate Method
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _choseTextField){
        _chosePlaceholderLabel.hidden = YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _informationRechargeTextField) {
        [self inputRechargePrice];
    }else if (textField == _choseTextField) {
        if ([textField.text isEqualToString:@""]) {
            _chosePlaceholderLabel.hidden = NO;
        }
    }
}
#pragma mark - Other methods
//选择Cell类型
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useInformationType];
            break;
        case 1:
            [self useChoseType];
            break;
        case 2:
            [self useCountType];
            break;
        case 3:
            [self usePayInfoType];
            break;
        case 4:
            [self usePayOrderType];
            break;
        default:
            break;
    }
}
//信息类型
- (void)useInformationType{
    _informationBackView.hidden = NO;
    _choseBackView.hidden = YES;
}
//选择支付类型
- (void)useChoseType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = NO;
}
//欠费总额
- (void)useCountType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = YES;
}
//订单信息
- (void)usePayInfoType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = YES;
}
//订单方案
- (void)usePayOrderType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = YES;
}
//加载用户名和营销人员信息
- (void)loadUserName:(NSString *)userName sellManName:(NSString *)sellManName sellManDepName:(NSString *)sellManDepName{
    _informationUserLabel.text = [NSString stringWithFormat:@"客户 %@",userName];
    _informationSellManLabel.text = [NSString stringWithFormat:@"操作员   %@   %@",sellManDepName,sellManName];
}
//加载充值的名称
- (void)loadRechargeNameWithName:(NSString *)name{
    _informationRechargeNameLabel.text = name;
}
//隐藏键盘
- (void)hideKeyBoard{
    [_informationRechargeTextField resignFirstResponder];
    [_choseTextField resignFirstResponder];
}
@end
