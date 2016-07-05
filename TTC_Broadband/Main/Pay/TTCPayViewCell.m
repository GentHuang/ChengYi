//
//  TTCPayViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPayViewCell.h"
//Macro
#define kButtonTag 11000
@interface TTCPayViewCell()<UITextFieldDelegate>
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) UIView *informationBackView;
@property (strong, nonatomic) UILabel *informationUserLabel;
@property (strong, nonatomic) UILabel *informationSellManLabel;
@property (strong, nonatomic) UIView *choseBackView;
@property (strong, nonatomic) UILabel *choseLabel;
@property (strong, nonatomic) NSArray *choseArray;
@property (strong, nonatomic) UITextField *choseTextField;
@property (strong, nonatomic) UILabel *chosePlaceholderLabel;
@property (strong, nonatomic) UIView *countBackView;
@property (strong, nonatomic) UILabel *countNameLabel;
@property (strong, nonatomic) UIImageView *countRMBImageView;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) UIView *payInfoBackView;
@property (strong, nonatomic) UILabel *payInfoLabel;
@property (strong, nonatomic) UIView *payOrderBackView;
@property (strong, nonatomic) UILabel *orderNameLabel;
@property (strong, nonatomic) UIImageView *orderRMBImageView;
@property (strong, nonatomic) UILabel *orderPriceLabel;
@property (strong, nonatomic) UIView *orderLineView;
@property (strong, nonatomic) UILabel *orderCountNameLabel;
@property (strong, nonatomic) UILabel *orderCountLabel;
@property (strong, nonatomic) UIImageView *orderCountRMBImageView;
@property (strong, nonatomic) UILabel *orderUserLabel;
@property (strong, nonatomic) UILabel *orderSellManLabel;
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *customerLabel;
@property (strong, nonatomic) UILabel *sellManLabel;
@property (strong, nonatomic) UILabel *totalNameLabel;
@property (strong, nonatomic) UIImageView *totalRMBView;
@property (strong, nonatomic) UILabel *totalLabel;
@end

@implementation TTCPayViewCell
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
    //选择支付
    //背景
    _choseBackView = [[UIView alloc] init];
    _choseBackView.hidden = YES;
    [self.contentView addSubview:_choseBackView];
    //总计
    _totalNameLabel = [[UILabel alloc] init];
    _totalNameLabel.text = @"支付总计：";
    _totalNameLabel.textColor = LIGHTDARK;
    _totalNameLabel.font = FONTSIZESBOLD(30/2);
    [_choseBackView addSubview:_totalNameLabel];
    //rmb
    _totalRMBView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_big_left"]];
    [_choseBackView addSubview:_totalRMBView];
    //总计
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.text = @"100.00";
    _totalLabel.textColor = [UIColor orangeColor];
    _totalLabel.font = FONTSIZESBOLD(50/2);
    [_choseBackView addSubview:_totalLabel];
    //支付方式
    _choseLabel = [[UILabel alloc] init];
    _choseLabel.text = @"支付方式";
    _choseLabel.textColor = LIGHTDARK;
    _choseLabel.font = FONTSIZESBOLD(30/2);
    [_choseBackView addSubview:_choseLabel];
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
            make.top.mas_equalTo(_choseLabel.mas_bottom).with.offset(i*(80/2)+24/2);
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
    _choseTextField.delegate = self;
    _choseTextField.backgroundColor = CLEAR;
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
    //欠费总额
    //背景
    _countBackView = [[UIView alloc] init];
    _countBackView.hidden = YES;
    [self.contentView addSubview:_countBackView];
    //欠费
    _countNameLabel = [[UILabel alloc] init];
    _countNameLabel.text = @"欠费";
    _countNameLabel.textColor = [UIColor lightGrayColor];
    _countNameLabel.font = FONTSIZESBOLD(30/2);
    [_countBackView addSubview:_countNameLabel];
    //欠费
    _countLabel = [[UILabel alloc] init];
    _countLabel.text = @"380";
    _countLabel.textAlignment = NSTextAlignmentRight;
    _countLabel.textColor = [UIColor orangeColor];
    _countLabel.font = FONTSIZESBOLD(40/2);
    [_countBackView addSubview:_countLabel];
    //rmb
    _countRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_big_left"]];
    [_countBackView addSubview:_countRMBImageView];
    //订单信息
    //背景
    _payInfoBackView = [[UIView alloc] init];
    _payInfoBackView.hidden = YES;
    [self.contentView addSubview:_payInfoBackView];
    //订单方案
    //背景
    _payOrderBackView = [[UIView alloc] init];
    _payOrderBackView.hidden = YES;
    [self.contentView addSubview:_payOrderBackView];
    //信息
    _payInfoLabel = [[UILabel alloc] init];
    _payInfoLabel.text = @"订单信息  2015-10-23 18:30";
    _payInfoLabel.textColor = [UIColor lightGrayColor];
    _payInfoLabel.font = FONTSIZESBOLD(30/2);
    [_payOrderBackView addSubview:_payInfoLabel];
    //前置图片
    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_img1"]];
    [_payOrderBackView addSubview:_cellImageView];
    //高清营销方案
    _orderNameLabel = [[UILabel alloc] init];
    _orderNameLabel.text = @"高清营销方案";
    _orderNameLabel.textColor = LIGHTDARK;
    _orderNameLabel.font = FONTSIZESBOLD(30/2);
    [_payOrderBackView addSubview:_orderNameLabel];
    //rmb
    _orderRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb2"]];
    [_payOrderBackView addSubview:_orderRMBImageView];
    //价格
    _orderPriceLabel = [[UILabel alloc] init];
    _orderPriceLabel.text = @"100.00   X2";
    _orderPriceLabel.textColor = [UIColor lightGrayColor];
    _orderPriceLabel.font = FONTSIZESBOLD(24/2);
    [_payOrderBackView addSubview:_orderPriceLabel];
    //下划线
    _orderLineView = [[UIView alloc] init];
    _orderLineView.backgroundColor = [UIColor lightGrayColor];
    [_payOrderBackView addSubview:_orderLineView];
    //总计
    _orderCountNameLabel = [[UILabel alloc] init];
    _orderCountNameLabel.text = @"小计：";
    _orderCountNameLabel.textAlignment = NSTextAlignmentRight;
    _orderCountNameLabel.textColor = [UIColor lightGrayColor];
    _orderCountNameLabel.font = FONTSIZESBOLD(24/2);
    [_payOrderBackView addSubview:_orderCountNameLabel];
    //rmb
    _orderCountRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb1"]];
    [_payOrderBackView addSubview:_orderCountRMBImageView];
    //总计
    _orderCountLabel = [[UILabel alloc] init];
    _orderCountLabel.text = @"100.00";
    _orderCountLabel.textAlignment = NSTextAlignmentRight;
    _orderCountLabel.textColor = [UIColor orangeColor];
    _orderCountLabel.font = FONTSIZESBOLD(40/2);
    [_payOrderBackView addSubview:_orderCountLabel];
    //客户
    _customerLabel = [[UILabel alloc] init];
    _customerLabel.text = @"客户 李四";
    _customerLabel.textColor = [UIColor lightGrayColor];
    _customerLabel.font = FONTSIZESBOLD(31/2);
    _customerLabel.textAlignment = NSTextAlignmentRight;
    [_payOrderBackView addSubview:_customerLabel];
    //营销人员
    _sellManLabel = [[UILabel alloc] init];
    _sellManLabel.textColor = [UIColor lightGrayColor];
    _sellManLabel.text = @"操作员 中山营业厅 李四";
    _sellManLabel.font = FONTSIZESBOLD(24/2);
    _sellManLabel.textAlignment = NSTextAlignmentRight;
    [_payOrderBackView addSubview:_sellManLabel];
}
- (void)setSubViewLayout{
    //信息类型
    //背景
    [_informationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //用户
    [_informationUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(38/2);
    }];
    //营销人员
    [_informationSellManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-70/2);
    }];
    //选择支付
    //背景
    [_choseBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //总计
    [_totalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(30/2);
    }];
    //rmb
    [_totalRMBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_totalNameLabel.mas_centerY).with.offset(2);
        make.left.mas_equalTo(_totalNameLabel.mas_right);
    }];
    //总计
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_totalNameLabel.mas_centerY).with.offset(0);
        make.left.mas_equalTo(_totalRMBView.mas_right).with.offset(2);
    }];
    //支付方式
    [_choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_totalNameLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(30/2);
    }];
    //备注
    [_choseTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-34/2);
        make.left.mas_equalTo(30/2);
        make.right.mas_equalTo(-70/2);
        make.height.mas_equalTo(65/2);
    }];
    //placeholder
    [_chosePlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_choseTextField.mas_centerY);
        make.left.mas_equalTo(10);
    }];
    //欠费总额
    [_countBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //欠费
    [_countNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(38/2);
    }];
    //欠费
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView).with.offset(1);
        make.right.mas_equalTo(-70/2);
    }];
    //rmb
    [_countRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView).with.offset(0);
        make.right.mas_equalTo(_countLabel.mas_left).with.offset(-12/2);
    }];
    //订单信息
    //背景
    [_payInfoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //订单方案
    //背景
    [_payOrderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //前置图片
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13/2);
        make.left.mas_equalTo(38/2);
        make.width.height.mas_equalTo(135/2);
    }];
    //高清营销方案
    [_orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30/2);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(20);
    }];
    //rmb
    [_orderRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderNameLabel.mas_bottom).with.offset(32/2);
        make.left.mas_equalTo(_orderNameLabel.mas_left);
    }];
    //价格
    [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderNameLabel.mas_bottom).with.offset(24/2);
        make.left.mas_equalTo(_orderRMBImageView.mas_right).with.offset(2);
    }];
    //下划线
    [_orderLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderPriceLabel.mas_bottom).with.offset(30/2);
        make.left.mas_equalTo(38/2);
        make.right.mas_equalTo(-70/2);
        make.height.mas_equalTo(0.5);
    }];
    //信息
    [_payInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderLineView.mas_bottom).with.offset(8);
        make.left.mas_equalTo(38/2);
    }];
    //总计
    [_orderCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_cellImageView.mas_centerY);
        make.right.mas_equalTo(-70/2);
    }];
    //rmb
    [_orderCountRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_cellImageView.mas_centerY).with.offset(2);
        make.right.mas_equalTo(_orderCountLabel.mas_left).with.offset(-2);
    }];
    //总计
    [_orderCountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_cellImageView.mas_centerY).with.offset(2);
        make.right.mas_equalTo(_orderCountRMBImageView.mas_left);
    }];
    //客户
    [_customerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderLineView.mas_bottom).with.offset(8);
        make.right.mas_equalTo(-70/2);
    }];
    //营销人员
    [_sellManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_customerLabel.mas_bottom).with.offset(5);
        make.right.mas_equalTo(-70/2);
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
    //    00：钱袋支付；11：广电银行支付；22：银行卡无卡支付；33：第三方支付C：现金支付99：微信支付2:POS支付
    switch (button.tag - kButtonTag) {
        case 0:
            self.payWayString = @"C";
            break;
        case 1:
            self.payWayString = @"2";
            break;
        case 2:
            self.payWayString = @"99";
            break;
        case 3:
            self.payWayString = @"";
            break;
        default:
            break;
    }
    self.stringBlock(_payWayString);
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITextFieldDelegate Method
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _chosePlaceholderLabel.hidden = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        _chosePlaceholderLabel.hidden = NO;
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
    _countBackView.hidden = YES;
    _payInfoBackView.hidden = YES;
    _payOrderBackView.hidden = YES;
}
//选择支付类型
- (void)useChoseType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = NO;
    _countBackView.hidden = YES;
    _payInfoBackView.hidden = YES;
    _payOrderBackView.hidden = YES;
}
//欠费总额
- (void)useCountType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = YES;
    _countBackView.hidden = NO;
    _payInfoBackView.hidden = YES;
    _payOrderBackView.hidden = YES;
}
//订单信息
- (void)usePayInfoType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = YES;
    _countBackView.hidden = YES;
    _payInfoBackView.hidden = NO;
    _payOrderBackView.hidden = YES;
}
//订单方案
- (void)usePayOrderType{
    _informationBackView.hidden = YES;
    _choseBackView.hidden = YES;
    _countBackView.hidden = YES;
    _payInfoBackView.hidden = YES;
    _payOrderBackView.hidden = NO;
}

//加载欠费
- (void)loadCount:(NSString *)count{
    _countLabel.text = count;
}
//加载用户名和营销人员信息
- (void)loadUserName:(NSString *)userName sellManName:(NSString *)sellManName sellManDepName:(NSString *)sellManDepName{
    _informationUserLabel.text = [NSString stringWithFormat:@"客户 %@",userName];
    _informationSellManLabel.text = [NSString stringWithFormat:@"操作员   %@   %@",sellManDepName,sellManName];
    
    _customerLabel.text = [NSString stringWithFormat:@"客户 %@",userName];
    _sellManLabel.text = [NSString stringWithFormat:@"操作员 %@ %@",sellManDepName,sellManName];
}
//加载订单信息
- (void)loadPayInfo:(NSString *)payInfo{
    _payInfoLabel.text = [NSString stringWithFormat:@"订单信息   %@",payInfo];
}
//加载订单方案
- (void)loadTitle:(NSString *)title price:(NSString *)price count:(NSString *)count{
    _orderNameLabel.text = title;
    _orderPriceLabel.text = [NSString stringWithFormat:@"%@   X%@",price,count];
    _orderCountLabel.text = [NSString stringWithFormat:@"%.02f",[price floatValue]*[count intValue]];
}
//加载图片
- (void)loadCellImageWithImageString:(NSString *)imageString{
    if (imageString.length > 0) {
        if([imageString isEqualToString:@"开户"]){
            //开户
            _cellImageView.image = [UIImage imageNamed:@"pay_img_create"];
        }else if([imageString isEqualToString:@"升级"]){
            //升级
            _cellImageView.image = [UIImage imageNamed:@"pay_img_upgrade"];
        }else{
            [_cellImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMGURL,imageString]]];
        }
    }else{
        //无图片
        _cellImageView.image = [UIImage imageNamed:@"pay_img_unpay"];
    }
}
//加载总价
- (void)loadTotalPrice:(NSString *)price{
    _totalLabel.text = price;
}
@end
