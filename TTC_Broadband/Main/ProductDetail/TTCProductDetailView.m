//
//  TTCProductDetailView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//View
#import "TTCProductDetailView.h"
//Macro
#define kButtonTag 36000
#define kButtonYearTag 36100

@interface TTCProductDetailView()<UIAlertViewDelegate,UITextFieldDelegate>
@property (assign, nonatomic) int orderCount;
@property (assign, nonatomic) CGFloat price;
@property (strong, nonatomic) UIView *topBackView;
@property (strong, nonatomic) UIImageView *viewImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *priceNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *addressNameLabel;
@property (strong, nonatomic) UIView *addressBackView;
@property (strong, nonatomic) UIImageView *dragImageVIew;
@property (strong, nonatomic) UITapGestureRecognizer *addressTap;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) NSArray *buttonArray;
@property (strong, nonatomic) UITextField *countTextField;
@property (strong, nonatomic) UILabel *totalLabel;
@property (strong, nonatomic) UIImageView *totalRMBImageView;
@property (strong, nonatomic) UILabel *totalNameLabel;
@property (strong, nonatomic) UIButton *buyButton;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) NSArray *databuyArray;
@end

@implementation TTCProductDetailView
- (void)initData{
    _buttonArray = @[[UIImage imageNamed:@"pro_btn_decrease"],[UIImage imageNamed:@"pro_btn_add"]];
    _databuyArray = @[@"3月",@"6月",@"1年",@"2年"];
}
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    _canBuy = YES;
    self.orderCount = 1;
    self.backgroundColor = WHITE;
    //viewImageView
    _viewImageView = [[UIImageView alloc] init];
    [self addSubview:_viewImageView];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = BLACK;
    _titleLabel.text = @"";
    _titleLabel.font = FONTSIZES(30/2);
    [self addSubview:_titleLabel];
    //描述
    _descLabel = [[UILabel alloc] init];
    _descLabel.numberOfLines = 2;
    _descLabel.textColor = [UIColor lightGrayColor];
    _descLabel.text = @"";
    _descLabel.font = FONTSIZES(24/2);
    [self addSubview:_descLabel];
    //产品标准价(名字)
    _priceNameLabel = [[UILabel alloc] init];
    _priceNameLabel.text = @"产品标准价";
    _priceNameLabel.textColor = [UIColor lightGrayColor];
    _priceNameLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_priceNameLabel];
    //￥图标
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_rmb"]];
    [self addSubview:_rmbImageView];
    //价格
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"";
    _priceLabel.textColor = ORANGE;
    _priceLabel.font = FONTSIZESBOLD(50/2);
    [self addSubview:_priceLabel];
    //选择用户
    _addressNameLabel = [[UILabel alloc] init];
    _addressNameLabel.text = @"选择用户";
    _addressNameLabel.textColor = [UIColor lightGrayColor];
    _addressNameLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_addressNameLabel];
    //用户背景
    _addressBackView = [[UIView alloc] init];
    _addressBackView.layer.borderWidth = 0.5;
    _addressBackView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _addressBackView.layer.masksToBounds = YES;
    _addressBackView.layer.cornerRadius = 4;
    //用户列表
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.text = @"";
    _addressLabel.textColor = [UIColor lightGrayColor];
    _addressLabel.font = FONTSIZESBOLD(24/2);
    [_addressBackView addSubview:_addressLabel];
    //点击手势
    _addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_addressBackView addGestureRecognizer:_addressTap];
    [self addSubview:_addressBackView];
    //下拉图标
    _dragImageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
    [_addressBackView addSubview:_dragImageVIew];
    //创建增加和减少按钮
    for (int i = 0; i < _buttonArray.count; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setBackgroundImage:_buttonArray[i] forState:UIControlStateNormal];
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_viewImageView.mas_bottom);
            make.left.mas_equalTo(_addressBackView.mas_left).with.offset(i*(180/2));
        }];
        if (i == 0) {
            //周期输入框
            _countTextField = [[UITextField alloc] init];
            _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
            _countTextField.delegate = self;
            _countTextField.textColor = LIGHTDARK;
            //            [_countTextField addTarget:self action:@selector(sureCountNum) forControlEvents:UIControlEventEditingChanged];
            _countTextField.keyboardType = UIKeyboardTypeNumberPad;
            _countTextField.font = FONTSIZESBOLD(24/2);
            _countTextField.textAlignment = NSTextAlignmentCenter;
            _countTextField.layer.masksToBounds = YES;
            _countTextField.layer.cornerRadius = 5;
            _countTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _countTextField.layer.borderWidth = 0.5;
            [self addSubview:_countTextField];
            [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(allButton.mas_centerY);
                make.left.mas_equalTo(allButton.mas_right).with.offset(20/2);
                make.width.mas_equalTo(90/2);
                make.height.mas_equalTo(allButton.mas_height);
            }];
        }
    }
    //总计
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.text = @"0.00";
    _totalLabel.textAlignment = NSTextAlignmentRight;
    _totalLabel.textColor = [UIColor orangeColor];
    _totalLabel.font = FONTSIZESBOLD(50/2);
    [self addSubview:_totalLabel];
    //rmb
    _totalRMBImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_small_left"]];
    [self addSubview:_totalRMBImageView];
    //总计
    _totalNameLabel = [[UILabel alloc] init];
    _totalNameLabel.textAlignment = NSTextAlignmentRight;
    _totalNameLabel.text = @"总计：";
    _totalNameLabel.textColor = [UIColor lightGrayColor];
    _totalNameLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_totalNameLabel];
    //add
    //订购一年或者两年按钮
    for (int i = 0; i< _databuyArray.count; i++) {
        UIButton *Yearbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:Yearbutton];
        //        Yearbutton.backgroundColor = [UIColor orangeColor];
        Yearbutton.tag =kButtonYearTag+i;
        [Yearbutton setTitle:_databuyArray[i] forState:UIControlStateNormal];
        [Yearbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [Yearbutton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
        [Yearbutton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
        [Yearbutton addTarget:self action:@selector(yearButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        //图片和文字的位置
        Yearbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [Yearbutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [Yearbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [Yearbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_countTextField.mas_bottom).offset(25);
            make.left.mas_equalTo(_addressBackView.mas_left).with.offset(i*(210/2));
            make.width.mas_equalTo(180/2);
            make.height.mas_equalTo(44/2);
        }];
    }
    
    //马上订购
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.backgroundColor = DARKBLUE;
    [_buyButton addTarget:self action:@selector(buyOrAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_buyButton setTitle:@"马上订购" forState:UIControlStateNormal];
    _buyButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = 4;
    [self addSubview:_buyButton];
    //加入购物车
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton addTarget:self action:@selector(buyOrAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _addButton.backgroundColor = ORANGE;
    [_addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    _addButton.titleLabel.font = FONTSIZESBOLD(31/2);
    _addButton.layer.masksToBounds = YES;
    _addButton.layer.cornerRadius = 4;
    [self addSubview:_addButton];
}
- (void)setSubViewLayout{
    //ViewImageView
    [_viewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(92/2);
        make.left.mas_equalTo(73/2);
        make.width.height.mas_equalTo(390/2);
    }];
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_viewImageView.mas_top);
        make.left.mas_equalTo(_viewImageView.mas_right).with.offset(74/2);
        make.height.mas_equalTo(30/2);
    }];
    //描述
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(20/2);
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.width.mas_equalTo(772/2);
    }];
    //产品标准价(名字)
    [_priceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLabel.mas_bottom).with.offset(30/2);
        make.left.mas_equalTo(_descLabel.mas_left);
    }];
    //￥图片
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(-2);
        make.left.mas_equalTo(_priceNameLabel.mas_right).with.offset(42/2);
    }];
    //价格
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_rmbImageView.mas_right).with.offset(14/2);
    }];
    //选择用户
    [_addressNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceNameLabel.mas_left);
        make.top.mas_equalTo(_priceNameLabel.mas_bottom).with.offset(54/2);
    }];
    //用户背景
    [_addressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceNameLabel.mas_left);
        make.top.mas_equalTo(_addressNameLabel.mas_bottom).with.offset(35/2);
        make.width.mas_equalTo(817/2);
        make.height.mas_equalTo(54/2);
    }];
    //用户
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addressBackView.mas_centerY);
        make.left.mas_equalTo(18/2);
    }];
    //下拉图标
    [_dragImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addressBackView.mas_centerY);
        make.right.mas_equalTo(_addressBackView.mas_right).with.offset(-4);
    }];
    //总计
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_countTextField.mas_bottom).with.offset(4);
        make.right.mas_equalTo(_addressBackView.mas_right);
    }];
    //rmb
    [_totalRMBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_countTextField.mas_bottom).with.offset(-2);
        make.right.mas_equalTo(_totalLabel.mas_left).with.offset(-22/2);
    }];
    //总计
    [_totalNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_countTextField.mas_bottom);
        make.right.mas_equalTo(_totalRMBImageView.mas_left).with.offset(-3);
    }];
    //立即订购
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33/2);//-73/2
        make.left.mas_equalTo(_addressBackView.mas_left);
        make.width.mas_equalTo(220/2);
        make.height.mas_equalTo(60/2);
    }];
    //加入购物车
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33/2);//-73/2
        make.left.mas_equalTo(_buyButton.mas_right).with.offset(90/2);
        make.width.mas_equalTo(220/2);
        make.height.mas_equalTo(60/2);
    }];
    
}
#pragma mark - Event response
//点击按钮（马上订购，加入购物车）
- (void)buyOrAddButtonPressed:(UIButton *)button{
    self.stringBlock(button.titleLabel.text);
}
//点击Tap
- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.tapBlock(tap);
}
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    //如果点击这里则取消年份选择
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.selected = NO;
    }
    
    if ((button.tag - kButtonTag)==0) {
        //减少周期
        if (self.orderCount > 1) {
            self.orderCount --;
        }
    }else{
        //增加周期
        self.orderCount ++;
    }
    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
}
//订购一年两年按钮
- (void)yearButtonPress:(UIButton*)button {
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.selected = NO;
        if (button.tag - kButtonYearTag ==i) {
            switch (i) {
                case 0:{
                    //购买3个月
                    self.orderCount =3;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                case 1:{
                    //购买6个月
                    self.orderCount =6;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                case 2:{
                    //购买12个月
                    self.orderCount =1*12;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                case 3:{
                    //购买24个月
                    self.orderCount =2*12;
                    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
                    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
                }
                    break;
                default:
                    break;
            }
            
            
        }
    }
    button.selected = YES;
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        _canBuy = YES;
        _orderCount = 1;
        _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
    }
}
//UITextFieldDelegate Method
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSScanner* scan = [NSScanner scannerWithString:_countTextField.text];
    int val;
    if(!([scan scanInt:&val] && [scan isAtEnd])){
        _canBuy = NO;
        //判断是否数字
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确月份" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }else{
        //判断是否大于0
        if ([_countTextField.text intValue] <= 0) {
            _canBuy = NO;
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订购周期至少为1个月" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }else{
            _canBuy = YES;
            self.orderCount = [_countTextField.text intValue];
            _totalLabel.text = [NSString stringWithFormat:@"%.02f",(CGFloat)(self.orderCount*_price)];
        }
    }
}
#pragma mark - Other methods
//读取地址
- (void)loadAddressString:(NSString *)address{
    _addressLabel.text = address;
}
////弹出View
//- (void)dragDownView{
//    //mainView下拉动画
//    [UIView beginAnimations:@"DragDown" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    CGFloat dragHeight = [UIImage imageNamed:@"pro_img_drag"].size.height;
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(718/2+dragHeight);
//    }];
//    [self layoutIfNeeded];
//    [UIView commitAnimations];
//}
////收起View
//- (void)packUpView{
//    //mainView收起动画
//    [UIView beginAnimations:@"PackUp" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(718/2);
//    }];
//    [self layoutIfNeeded];
//    [UIView commitAnimations];
//}
//收起键盘(确定购买数量)
- (void)hideKeyBoard{
    [_countTextField resignFirstResponder];
}
//加载数据
- (void)loadTitle:(NSString *)title intro:(NSString *)intro price:(NSString *)price smallimg:(NSString *)smallimg firstUserKeyno:(NSString *)firstUserKeyno firstUserPermark:(NSString *)firstUserPermark{
    _price = [price floatValue];
    _titleLabel.text = title;
    _descLabel.text = intro;
    _priceLabel.text = price;
    [_viewImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMGURL,smallimg]]];
    _totalLabel.text = [NSString stringWithFormat:@"%.02f",(self.orderCount*[price floatValue])];
    
    if ([firstUserPermark isEqualToString:@"0"]) {
        firstUserPermark = @"模拟";
    }else if ([firstUserPermark isEqualToString:@"1"]) {
        firstUserPermark = @"数字";
    }else if ([firstUserPermark isEqualToString:@"2"]) {
        firstUserPermark = @"宽带";
    }else if ([firstUserPermark isEqualToString:@"3"]) {
        firstUserPermark = @"互动";
    }else if ([firstUserPermark isEqualToString:@"4"]) {
        firstUserPermark = @"智能";
    }
    
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@",firstUserPermark,firstUserKeyno];
}
//根据客户是否登录选择视图模式
- (void)selectViewModel:(viewMode)mode{
    switch (mode) {
        case 0:
            [self useLogViewMode];
            break;
        case 1:
            [self useUnLogViewMode];
            break;
        default:
            break;
    }
}
//已登录
- (void)useLogViewMode{
    _addressNameLabel.hidden = NO;
    _addressBackView.hidden = NO;
    for (int i = 0; i < _buttonArray.count; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        allButton.hidden = NO;
    }
    //年份购买
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.hidden = NO;
    }
    _totalLabel.hidden = NO;
    _totalRMBImageView.hidden = NO;
    _totalNameLabel.hidden = NO;
    _countTextField.hidden = NO;
    //立即订购
    [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33/2);//-73/2
    }];
    //加入购物车
    [_addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33/2);//-73/2
    }];
    
}
//未登录
- (void)useUnLogViewMode{
    _addressNameLabel.hidden = YES;
    _addressBackView.hidden = YES;
    for (int i = 0; i < _buttonArray.count; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        allButton.hidden = YES;
    }
    //年份购买
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.hidden = YES;
    }
    _totalLabel.hidden = YES;
    _totalRMBImageView.hidden = YES;
    _totalNameLabel.hidden = YES;
    _countTextField.hidden = YES;
    //立即订购
    [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-120);
    }];
    //加入购物车
    [_addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-120);
    }];
}
//隐藏购买年份月份按钮
- (void)hiddeBUyYearOrMonthlyButton{
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.hidden = YES;
    }
}
//显示购买年份月份按钮
- (void)showBuyYearOrMonthlyButton {
    for (int i = 0; i<_databuyArray.count; i++) {
        UIButton *buyButton = (UIButton*)[self viewWithTag:kButtonYearTag+i];
        buyButton.hidden = NO;
    }
}

@end
