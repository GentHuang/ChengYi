//
//  TTCShoppingCarCellOtherView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCShoppingCarCellOtherView.h"

#define kButtonTag 86000

@interface TTCShoppingCarCellOtherView()<UITextFieldDelegate>
@property (assign, nonatomic) int orderCount;
@property (strong, nonatomic) UIImageView *otherImageView;
@property (strong, nonatomic) UILabel *otherBusinessNameLabel;
@property (strong, nonatomic) UILabel *otherMainNumberLabel;
@property (strong, nonatomic) UILabel *otherSecondNumberLabel;
@property (strong, nonatomic) UIImageView *rmbSLImageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *timesLabel;
@property (strong, nonatomic) UILabel *monthLabel;
@property (strong, nonatomic) UIImageView *rmbSRImageView;
@property (strong, nonatomic) UILabel *bigPriceLabel;
@property (strong, nonatomic) UILabel *commenPriceLabel;
@property (strong, nonatomic) UIView *lineView;
// 加减商品数目按钮
@property (strong, nonatomic) NSArray *buttonArray;
// 商品的数量
@property (strong, nonatomic) UITextField *countTextField;
// 商品价格
@property (copy, nonatomic) NSString *goodsPrice;
@property (copy, nonatomic) NSString *goodsName;
@end
@implementation TTCShoppingCarCellOtherView
// 初始化数组
- (void)initData{
    _buttonArray = @[[UIImage imageNamed:@"pro_btn_decrease"],[UIImage imageNamed:@"pro_btn_add"]];
}
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor];
        [self initData];
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //图片
    _otherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_digital"]];
    [self addSubview:_otherImageView];
    //业务名称
    _otherBusinessNameLabel = [[UILabel alloc] init];
    _otherBusinessNameLabel.text = @"数字基本包";
    _otherBusinessNameLabel.textColor = LIGHTDARK;
    _otherBusinessNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_otherBusinessNameLabel];
    //主机
    _otherMainNumberLabel = [[UILabel alloc] init];
    _otherMainNumberLabel.hidden = YES;
    _otherMainNumberLabel.text = @"055644 - 主机 4656787873839";
    _otherMainNumberLabel.textColor = [UIColor lightGrayColor];
    _otherMainNumberLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_otherMainNumberLabel];
    //副机
    _otherSecondNumberLabel = [[UILabel alloc] init];
    _otherSecondNumberLabel.hidden = YES;
    _otherSecondNumberLabel.text = @"055644 - 副机 4656787873839";
    _otherSecondNumberLabel.textColor = [UIColor lightGrayColor];
    _otherSecondNumberLabel.font = FONTSIZESBOLD(24/2);
    [self addSubview:_otherSecondNumberLabel];
    //rmb图片(小左)
    _rmbSLImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_small_left"]];
    [self addSubview:_rmbSLImageView];
    //价钱
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = @"100.00";
    _priceLabel.textColor = [UIColor orangeColor];
    _priceLabel.font = FONTSIZESBOLD(28/2);
    [self addSubview:_priceLabel];
    //倍数
    _timesLabel = [[UILabel alloc] init];
    _timesLabel.text = @"×2";
    _timesLabel.textColor = [UIColor lightGrayColor];
    _timesLabel.font = FONTSIZESBOLD(28/2);
    [self addSubview:_timesLabel];
    //使用月份
    _monthLabel = [[UILabel alloc] init];
    _monthLabel.text = @"12个月";
    _monthLabel.hidden = YES;
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    _monthLabel.textColor = [UIColor lightGrayColor];
    _monthLabel.font = FONTSIZESBOLD(24/2);
    _monthLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _monthLabel.layer.borderWidth = 0.5;
    _monthLabel.layer.masksToBounds = YES;
    _monthLabel.layer.cornerRadius = 4;
    [self addSubview:_monthLabel];
    //价钱（大）
    _bigPriceLabel = [[UILabel alloc] init];
    _bigPriceLabel.text = @"109.00";
    _bigPriceLabel.textColor = ORANGE;
    _bigPriceLabel.textAlignment = NSTextAlignmentRight;
    _bigPriceLabel.font = FONTSIZESBOLD(50/2);
    [self addSubview:_bigPriceLabel];
    //rmb图片(小右)
    _rmbSRImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_img_rmb_small_right"]];
    [self addSubview:_rmbSRImageView];
    //标准价
    _commenPriceLabel = [[UILabel alloc] init];
    _commenPriceLabel.hidden = YES;
    _commenPriceLabel.text = @"标准价 ：266.0";
    _commenPriceLabel.textColor = [UIColor lightGrayColor];
    _commenPriceLabel.textAlignment = NSTextAlignmentRight;
    _commenPriceLabel.font = FONTSIZESBOLD(26/2);
    [self addSubview:_commenPriceLabel];
    //划线
    _lineView = [[UIView alloc] init];
    _lineView.hidden = YES;
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    
    // goods数量的加减
    __weak __typeof (&*self)weaks = self;
    for (int i = 0; i < _buttonArray.count; i ++) {
        
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setBackgroundImage:_buttonArray[i] forState:UIControlStateNormal];
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:allButton];
            
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(weaks.otherBusinessNameLabel.mas_bottom).with.offset(15);
            make.left.mas_equalTo(weaks.mas_left).with.offset(i == 0?260:355);
        }];
       
        if (i == 0) {
            //周期输入框
            _countTextField = [[UITextField alloc] init];
            _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
            _countTextField.delegate = self;
            _countTextField.textColor = LIGHTDARK;
            //[_countTextField addTarget:self action:@selector(sureCountNum) forControlEvents:UIControlEventEditingChanged];
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
                make.left.mas_equalTo(allButton.mas_right).with.offset(14);
                make.width.mas_equalTo(90/2);
                make.height.mas_equalTo(allButton.mas_height);
            }];
        }
    }
}
- (void)setSubViewLayout{
    //其他模式
    //图片
    [_otherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(10/2);
        make.height.width.mas_equalTo(218/2);
    }];
    //业务名称
    [_otherBusinessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_otherImageView.mas_top).with.offset(55/2);
        make.left.mas_equalTo(_otherImageView.mas_right).with.offset(48/2);
    }];
    //主机
    [_otherMainNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_otherBusinessNameLabel.mas_bottom).with.offset(15/2);
        make.left.mas_equalTo(_otherBusinessNameLabel.mas_left);
    }];
    //副机
    [_otherSecondNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_otherMainNumberLabel.mas_bottom).with.offset(15/2);
        make.left.mas_equalTo(_otherBusinessNameLabel.mas_left);
    }];
    //rmb图片(小左)
    [_rmbSLImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_otherSecondNumberLabel.mas_bottom).with.offset(-5);
        make.left.mas_equalTo(_otherBusinessNameLabel.mas_left);
    }];
    //价钱
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_rmbSLImageView.mas_bottom).with.offset(3);
        make.left.mas_equalTo(_rmbSLImageView.mas_right).with.offset(12/2);
    }];
    //倍数
    [_timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_priceLabel.mas_bottom);
        make.left.mas_equalTo(_priceLabel.mas_right).with.offset(12/2);
    }];
    //使用月份
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(57/2);
        make.right.mas_equalTo(-58/2);
        make.width.mas_equalTo(108/2);
        make.height.mas_equalTo(40/2);
    }];
    //价钱(大)
    [_bigPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_monthLabel.mas_bottom).with.offset(25/2);
        make.right.mas_equalTo(_monthLabel.mas_right);
    }];
    //rmb图片(小右)
    [_rmbSRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_bigPriceLabel.mas_bottom).with.offset(-7);
        make.right.mas_equalTo(_bigPriceLabel.mas_left).with.offset(-23/2);
    }];
    //标准价
    [_commenPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bigPriceLabel.mas_bottom).with.offset(22/2);
        make.right.mas_equalTo(_monthLabel.mas_right);
    }];
    //划线
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commenPriceLabel.mas_centerY);
        make.left.right.mas_equalTo(_commenPriceLabel);
        make.height.mas_equalTo(1);
    }];
}

//点击按钮,货物周期的增多和减少
- (void)buttonPressed:(UIButton *)button{
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
    _bigPriceLabel.text = [NSString stringWithFormat:@"%.02f",_orderCount * [_goodsPrice floatValue]];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCShoppingCarCellOtherView"
                                                        object:self
                                                      userInfo:@{@"allCash":_bigPriceLabel.text,
                                                                 @"count":_countTextField.text,
                                                                 @"name":_goodsName}];
}

#pragma mark - UITextFieldDelegate

// 关闭键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_countTextField resignFirstResponder];
    return YES;
}

// 文字开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _orderCount = [textField.text floatValue];
    _countTextField.text = [NSString stringWithFormat:@"%d",self.orderCount];
    _bigPriceLabel.text = [NSString stringWithFormat:@"%.02f",_orderCount * [_goodsPrice floatValue]];
}



#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载产品详情
- (void)loadWithImage:(NSString *)smallimg title:(NSString *)title contents:(NSString *)contents price:(NSString *)price count:(NSString *)count{
    _goodsName = title;
    _orderCount = [count intValue];
    _countTextField.text = count;
    [_otherImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMGURL,smallimg]]];
    _otherBusinessNameLabel.text = title;
    _otherMainNumberLabel.text = contents;
    _priceLabel.text = price;
    _timesLabel.hidden = YES;
    _timesLabel.text = [NSString stringWithFormat:@"X%@",count];
    _bigPriceLabel.text = [NSString stringWithFormat:@"%.02f",[count intValue]*[price floatValue]];
    _goodsPrice = price;
}
@end
