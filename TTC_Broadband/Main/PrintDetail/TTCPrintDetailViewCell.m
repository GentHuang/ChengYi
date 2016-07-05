//
//  TTCPrintDetailViewCell.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintDetailViewCell.h"
//Macro
#define kPrinterButtonTag 10000
#define kTextTag 11000
#define kButtonTag 12000
#define kLableTag 13000
@interface TTCPrintDetailViewCell()<UITextFieldDelegate>
@property (strong, nonatomic) UIView *fillInBackView;
@property (strong, nonatomic) UILabel *fillInTotalNameLabel;
@property (strong, nonatomic) UIImageView *fillInRMBImageView;
@property (strong, nonatomic) UILabel *fillInPriceLabel;
@property (strong, nonatomic) UIButton *fillInButton;
@property (strong, nonatomic) UILabel *bookNumNameLabel;
@property (strong, nonatomic) UILabel *bookNumLabel;
@property (strong, nonatomic) UILabel *fillInNumberLabel;
@property (strong, nonatomic) UITextField *fillInNumberTextField;
@property (strong, nonatomic) UIView *printerBackView;
@property (strong, nonatomic) UILabel *printerChoseLabel;
@property (strong, nonatomic) UIButton *printerRefreshButton;
@property (assign, nonatomic) int printerCount;
@property (strong, nonatomic) NSArray *printerNameArray;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) UIImageView *dragImageView;

@property (strong, nonatomic) UIView *choseBackView;
@property (strong, nonatomic) UILabel *choseLabel;
@property (strong, nonatomic) NSArray *choseArray;
@property (strong, nonatomic) NSString *payWayString;

//记录打印机数量
@property (assign, nonatomic) int numberCount;
@end

@implementation TTCPrintDetailViewCell
#pragma mark - Init methods
- (void)initData{
    //printerNameArray
    _printerNameArray = @[@"输入打印机IP",@"输入打印机端口"];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
    //选择支付方式
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
    //填写模式
    //背景
    _fillInBackView = [[UIView alloc] init];
    _fillInBackView.hidden = YES;
    [self.contentView addSubview:_fillInBackView];
    //打印发票
    _fillInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fillInButton.layer.masksToBounds = YES;
    _fillInButton.layer.cornerRadius = 3;
    _fillInButton.backgroundColor = DARKBLUE;
    [_fillInButton setTitle:@"确认打印" forState:UIControlStateNormal];
    [_fillInButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _fillInButton.titleLabel.font = FONTSIZESBOLD(38/2);
    [_fillInBackView addSubview:_fillInButton];
    //已经把确认打印的按钮移动到最底部 所以隐藏
    _fillInButton.hidden = YES;
    //未开发票总额：
    _fillInTotalNameLabel = [[UILabel alloc] init];
    _fillInTotalNameLabel.text = @"未开发票总额：";
    _fillInTotalNameLabel.textColor = [UIColor lightGrayColor];
    _fillInTotalNameLabel.font = FONTSIZESBOLD(30/2);
    [_fillInBackView addSubview:_fillInTotalNameLabel];
    //RMB
    _fillInRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"debt_img_rmb"]];
    [_fillInBackView addSubview:_fillInRMBImageView];
    //价格
    _fillInPriceLabel = [[UILabel alloc] init];
    _fillInPriceLabel.text = @"0.00";
    _fillInPriceLabel.textColor = [UIColor lightGrayColor];
    _fillInPriceLabel.font = FONTSIZESBOLD(30/2);
    [_fillInBackView addSubview:_fillInPriceLabel];
    //选择发票本号
    _bookNumNameLabel = [[UILabel alloc] init];
    _bookNumNameLabel.text = @"选择发票本号";
    _bookNumNameLabel.textColor = LIGHTDARK;
    _bookNumNameLabel.font = FONTSIZESBOLD(26/2);
    [_fillInBackView addSubview:_bookNumNameLabel];
    //选择发票本号
    _bookNumLabel = [[UILabel alloc] init];
    _bookNumLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [_bookNumLabel addGestureRecognizer:tap];
    _bookNumLabel.backgroundColor = CLEAR;
    _bookNumLabel.layer.borderWidth = 0.5;
    _bookNumLabel.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _bookNumLabel.layer.masksToBounds = YES;
    _bookNumLabel.layer.cornerRadius = 3;
    [_fillInBackView addSubview:_bookNumLabel];
    //下拉箭头
    _dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ucl_btn_dragDown"]];
    [_bookNumLabel addSubview:_dragImageView];
    //填写发票编号
    _fillInNumberLabel = [[UILabel alloc] init];
    _fillInNumberLabel.text = @"填写发票编号";
    _fillInNumberLabel.textColor = LIGHTDARK;
    _fillInNumberLabel.font = FONTSIZESBOLD(26/2);
    [_fillInBackView addSubview:_fillInNumberLabel];
    //填写发票编号
    _fillInNumberTextField = [[UITextField alloc] init];
    _fillInNumberTextField.backgroundColor = CLEAR;
    _fillInNumberTextField.layer.borderWidth = 0.5;
    _fillInNumberTextField.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
    _fillInNumberTextField.layer.masksToBounds = YES;
    _fillInNumberTextField.layer.cornerRadius = 3;
    _fillInNumberTextField.borderStyle = UITextBorderStyleNone;
    _fillInNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_fillInNumberTextField addTarget:self action:@selector(inputInvnoString:) forControlEvents:UIControlEventEditingChanged];
    _fillInNumberTextField.delegate = self;
    [_fillInBackView addSubview:_fillInNumberTextField];
    //选择支付
    //背景
    _choseBackView = [[UIView alloc] init];
    [_fillInBackView addSubview:_choseBackView];
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
        [allButton addTarget:self action:@selector(changeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    
    //打印机模式
    //背景
    _printerBackView = [[UIView alloc] init];
    _printerBackView.hidden = YES;
    [self.contentView addSubview:_printerBackView];
    //选择打印机
    _printerChoseLabel = [[UILabel alloc] init];
    _printerChoseLabel.text = @"选择打印机";
    _printerChoseLabel.textColor = LIGHTDARK;
    _printerChoseLabel.font = FONTSIZESBOLD(26/2);
    [_printerBackView addSubview:_printerChoseLabel];
    //刷新打印机
    _printerRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_printerRefreshButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_printerRefreshButton setTitleColor:DARKBLUE forState:UIControlStateNormal];
    [_printerRefreshButton setTitle:@"刷新打印机" forState:UIControlStateNormal];
    [_printerRefreshButton setImage:[UIImage imageNamed:@"print_btn_refresh"] forState:UIControlStateNormal];
    _printerRefreshButton.titleLabel.font = FONTSIZESBOLD(26/2);
    [_printerBackView addSubview:_printerRefreshButton];
}
- (void)setSubViewLayout{
    //填写模式
    //背景
    [_fillInBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //打印发票
    [_fillInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-58/2);
        make.top.mas_equalTo(52/2);
        make.width.mas_equalTo(194/2);
        make.height.mas_equalTo(73/2);
    }];
    //未开发票总额：
    [_fillInTotalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60/2);
        make.centerY.mas_equalTo(_fillInButton.mas_centerY);
    }];
    //RMB
    [_fillInRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fillInTotalNameLabel.mas_top).with.offset(4);
        make.left.mas_equalTo(_fillInTotalNameLabel.mas_right);
    }];
    //价格
    [_fillInPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fillInTotalNameLabel.mas_top);
        make.left.mas_equalTo(_fillInRMBImageView.mas_right).with.offset(5);
    }];
    //填写发票抬头
    [_bookNumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fillInTotalNameLabel.mas_bottom).with.offset(38/2);
        make.left.mas_equalTo(_fillInTotalNameLabel.mas_left);
    }];
    //填写发票抬头
    [_bookNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bookNumNameLabel.mas_right).with.offset(26/2);
        make.centerY.mas_equalTo(_bookNumNameLabel.mas_centerY);
        make.height.mas_equalTo(50/2);
        make.width.mas_equalTo(820/2);
    }];
    //下拉箭头
    [_dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_bookNumLabel.mas_centerY);
        make.right.mas_equalTo(-5);
    }];
    //填写发票编号
    [_fillInNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bookNumNameLabel.mas_bottom).with.offset(38/2);
        make.left.mas_equalTo(_fillInTotalNameLabel.mas_left);
    }];
    //填写发票编号
    [_fillInNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bookNumNameLabel.mas_right).with.offset(26/2);
        make.centerY.mas_equalTo(_fillInNumberLabel.mas_centerY);
        make.height.mas_equalTo(50/2);
        make.width.mas_equalTo(820/2);
    }];
    //选择支付
    //背景
    [_choseBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fillInNumberTextField.mas_bottom).with.offset(20);
        make.height.mas_equalTo(170);
        make.left.right.mas_equalTo(0);
    }];
    //总计
    [_choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(60/2);
    }];
    //打印机模式
    //背景
    [_printerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    //选择打印机
    [_printerChoseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44/2);
        make.left.mas_equalTo(60/2);
    }];
    //刷新打印机
    [_printerRefreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43/2);
        make.right.mas_equalTo(-60/2);
    }];
}
#pragma mark - Event response
//带Tag的按钮点击
- (void)tagButtonPressed:(UIButton *)button{
    for (int i = 0; i < _printerCount; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:(i+kPrinterButtonTag)];
        allButton.selected = NO;
    }
    button.selected = YES;
}
//点击按钮
- (void)changeButtonPressed:(UIButton *)button{
    for (int i = 0; i < 4; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:(i+kButtonTag)];
        allButton.selected = NO;
    }
    button.selected = YES;
    // 原来的 /* 00：钱袋支付；11：广电银行支付；22：银行卡无卡支付；33：第三方支付C：现金支付99：微信支付2:POS支付 */
     //   0  是现金，2是刷卡支付  W是微信支付
    switch (button.tag - kButtonTag) {
        case 0:
            self.payWayString = @"0";
            break;
        case 1:
            self.payWayString = @"2";
            break;
        case 2:
            self.payWayString = @"W";
            break;
        case 3:
            self.payWayString = @"";
            break;
        default:
            break;
    }
    self.changeBlock(_payWayString);
}
//全局按钮点击
- (void)buttonPressed:(UIButton *)button{
    [self packUpKeyBoard];
    self.stringBlock(button.titleLabel.text);
}
//收起键盘
- (void)packUpKeyBoard{
    [_fillInNumberTextField resignFirstResponder];
    [_fillInNumberTextField endEditing:YES];
}
//输入打印机IP和端口号
- (void)inputIPAndPrortWithTextField:(UITextField*)textField{
//    UITextField *ipTextField = (UITextField *)[self viewWithTag:0+kTextTag];
//    [_userDefault setValue:ipTextField.text forKey:@"IP"];
//    UITextField *portTextField = (UITextField *)[self viewWithTag:1+kTextTag];
//    [_userDefault setValue:portTextField.text forKey:@"端口"];
    //存储输入的IP
    [_userDefault setValue:textField.text forKey:@"IP"];
    //添加固定端口
    [_userDefault setValue:@"9100" forKey:@"端口"];

}
//
- (void)inputInvnoString:(UITextField *)textfield{
    if (textfield == _fillInNumberTextField) {
        //填写发票编号
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_fillInNumberTextField.text forKey:@"发票编号"];
        [userDefault synchronize];
    }
}
//点击下拉选择本号
- (void)tapPressed{
    self.tapBlock(nil);
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITextFieldDelegate Method
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"请求发票本号" object:self];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_fillInNumberTextField resignFirstResponder];
    return YES;
}
#pragma mark - Other methods
//选择Cell类型
- (void)selectCellType:(CellType)type{
    switch (type) {
        case 0:
            [self useFillInType];
            break;
        case 1:
            [self usePrinterType];
            break;
        default:
            break;
    }
}
//填写模式
- (void)useFillInType{
    _fillInBackView.hidden = NO;
    _printerBackView.hidden = YES;
}
//选择打印机模式
- (void)usePrinterType{
    _fillInBackView.hidden = YES;
    _printerBackView.hidden = NO;
}
//添加打印机
- (void)loadPrinterWithNumber:(int)number{
    _printerCount = number;
    
    if ([_printerBackView subviews].count>2) {//已经有两个子视图
        //清除子视图
        [self deleteChildView];
    }

    for (int i = 0; i < number; i ++) {
        //打印机按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTag:(i+kPrinterButtonTag)];
        [button addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = CLEAR;
        [button setImage:[UIImage imageNamed:@"print_btn_print_nol"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"print_btn_print_sel"] forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@"打印机%d",i+1] forState:UIControlStateNormal];
        [button setTitleColor:LIGHTDARK forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-22, 0, 0, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(140/2, -110, 0, 0)];
        button.titleLabel.font = FONTSIZESBOLD(24/2);
        [_printerBackView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_printerChoseLabel.mas_bottom).with.offset(20/2);
            make.left.mas_equalTo(60/2+i*(142/2+62/2));
            make.height.mas_equalTo(180/2);
        }];
        //输入IP和端口
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = _printerNameArray[i];
        nameLabel.textColor = LIGHTDARK;
        nameLabel.font = FONTSIZESBOLD(26/2);
        nameLabel.tag = i+kLableTag;
        [_printerBackView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button.mas_bottom).with.offset(i*(60/2)+(60/2));
            make.left.mas_equalTo(60/2);
        }];
        //填写框
        UITextField *inputTextField = [[UITextField alloc] init];
        inputTextField.tag = kTextTag+i;
        [inputTextField addTarget:self action:@selector(inputIPAndPrortWithTextField:) forControlEvents:UIControlEventEditingChanged];//UIControlEventEditingChanged
        //设置IP和端口
        NSString *ipString = [_userDefault valueForKey:@"IP"];
        NSString *portString = [_userDefault valueForKey:@"端口"];
        //添加固定端口
        [_userDefault setValue:@"9100" forKey:@"端口"];
        if (ipString.length > 0) {
            NSLog(@"刷新%@",ipString);
        }else{
//            ipString = @"192.168.200.188";
//            portString = @"9100";
            ipString = @"0.0.0.0";
            portString = @"9100";
        }
        if (i == 0) {
            inputTextField.text = ipString;
            [_userDefault setValue:ipString forKey:@"IP"];
        }else{
            inputTextField.text = portString;
        }
        inputTextField.delegate = self;
        inputTextField.backgroundColor = CLEAR;
        inputTextField.delegate = self;
        inputTextField.layer.borderWidth = 0.5;
        inputTextField.layer.borderColor = [UIColor colorWithRed:229/256.0 green:229/256.0 blue:229/256.0 alpha:1].CGColor;
        inputTextField.layer.masksToBounds = YES;
        inputTextField.layer.cornerRadius = 3;
        inputTextField.borderStyle = UITextBorderStyleNone;
        [_printerBackView addSubview:inputTextField];
        [inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(280/2);
            make.centerY.mas_equalTo(nameLabel.mas_centerY);
            make.height.mas_equalTo(50/2);
            make.width.mas_equalTo(820/2);
        }];
    }
}
- (void)deleteChildView {
    //移除循环创建的视图
    for (int i = 0; i<_printerCount; i++) {
        UIButton *button = (UIButton*)[_printerBackView viewWithTag:i+kPrinterButtonTag];
        [button removeFromSuperview];
        UILabel *nameLabel =(UILabel*)[_printerBackView viewWithTag:i+kLableTag];
        [nameLabel removeFromSuperview];
        UITextField *textFile = (UITextField*)[_printerBackView viewWithTag:i+kTextTag];
        [textFile removeFromSuperview];
    }
}

//加载价格
- (void)loadPrice:(NSString *)price{
    _fillInPriceLabel.text = price;
}
//加载发票本号
- (void)loadBooknoLabelWithBookno:(NSString *)bookno{
    _bookNumLabel.text = bookno;
}
//加载发票编号
- (void)loadInvoNumWithInvoNum:(NSString *)invoString{
    _fillInNumberTextField.text = invoString;
}
@end
