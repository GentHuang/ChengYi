//
//  TTCNewUserViewControllerMainView.m
//  TTC_Broadband
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCNewUserViewControllerMainView.h"
#import "TTCNewUserViewControllerDragView.h"
#import "TTCNewUserViewControllerAddressDragView.h"
//add
#import "TTCNewUserViewSingleSelectedView.h"

//Macro
#define kBackTag 72000
#define kDragViewTag 73000
#define kTextFieldTag 74000
#define kButtonTag 75000
#define kSingleSelectedTag 76000
#define KLabalWidth 130
@interface TTCNewUserViewControllerMainView()<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIButton *sureButton;
@property (strong, nonatomic) UIButton *addAddressButton;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) NSString *lastAddressString;
@property (strong, nonatomic) NSString *createModeString;
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) NSString *serveTypeString;
@property (strong, nonatomic) NSString *feeTypeString;
@property (strong, nonatomic) NSString *setupString;
@property (strong, nonatomic) NSString *mainCardString;
@property (strong, nonatomic) NSString *cardNumString;
@property (strong, nonatomic) NSString *topBoxString;
@property (strong, nonatomic) NSString *CMString;
@property (strong, nonatomic) NSString *cardNumDeviceString;
@property (strong, nonatomic) NSString *topBoxDeviceString;
@property (strong, nonatomic) NSString *CMDeviceString;
@property (strong, nonatomic) NSString *broadAccountString;
@property (strong, nonatomic) NSString *broadPWDString;
@property (strong, nonatomic) NSString *broadSuffixString;
@property (strong, nonatomic) NSString *houseIDString;
@property (strong, nonatomic) NSArray *broadSuffixArray;
@property (strong, nonatomic) NSArray *addressArray;


@end
@implementation TTCNewUserViewControllerMainView
#pragma mark - Init methods
- (void)initData{
    //标题名称
    _titleArray = @[@"地址:",@"尾地址:",@"开户模式:",@"支付方式",@"用户类型:",@"收费类型:",@"上门安装:",@"所属主卡:",@"智能卡:",@"机顶盒:",@"EOC:",@"智能卡设备来源:",@"机顶盒设备来源:",@"EOC设备来源:",@"宽带账号",@"宽带密码:",@"宽带后缀:"];
    //资料初始化
    _houseIDString = @"";
    _addressString = @"";
    _lastAddressString = @"";
    _createModeString = @"";
    _serveTypeString = @"";
    _feeTypeString = @"";
    _setupString = @"";
    _mainCardString = @"";
    _cardNumString = @"";
    _topBoxString = @"";
    _CMString = @"";
    _payWayString = @"";
    _cardNumDeviceString = @"";
    _topBoxDeviceString = @"";
    _CMDeviceString = @"";
    _broadAccountString = @"";
    _broadPWDString = @"";
    _broadSuffixString = @"";
}
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
    self.backgroundColor = WHITE;
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //背景
    _backView.backgroundColor = [UIColor redColor];
    _backView = [[UIView alloc] init];
    
#if 1
    //数据未返回时隐藏视图
    _backView.hidden = YES;
    __block  TTCNewUserViewControllerMainView  *selfvc = self;
    //记录back
    UIView *backTagView;
#endif
    [self addSubview:_backView];
    //创建信息列表
    UIView *lastView;

    for (int i = 0,j = 0; i < _titleArray.count; i ++) {
        //标题名称
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = _titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
//        titleLabel.backgroundColor = [UIColor orangeColor];
        titleLabel.font = FONTSIZESBOLD(30/2);
        titleLabel.textColor = LIGHTDARK;
        [_backView addSubview:titleLabel];
#if 1
        if (i<11) {
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(135/2+i*(30/2+60/2));
                make.right.mas_equalTo(-1000/2);
                make.width.mas_equalTo(KLabalWidth);
            }];
        }else if (i==11||i==12||i==13){
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(135/2+i*(30/2+60/2)+60/2*j);
                make.right.mas_equalTo(-1000/2);
                make.width.mas_equalTo(KLabalWidth);
            }];
            j++;
        }else if (i >13){
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(135/2+i*(30/2+60/2)+(j+1)*60/2);
                make.right.mas_equalTo(-1000/2);
                make.width.mas_equalTo(KLabalWidth);
            }];
        }
         lastView = titleLabel;
        
#endif
#if 1
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(135/2+i*(30/2+60));//(135/2+i*(30/2+55/2))//(135/2+i*(30/2+60))
//            make.right.mas_equalTo(-1000/2);
//        }];
//         lastView = titleLabel;
        if (i==6||i==11||i==12||i==13||i==16) {
            TTCNewUserViewSingleSelectedView *singleSelectedView = [[TTCNewUserViewSingleSelectedView alloc]init];
            singleSelectedView.userInteractionEnabled = YES;
            [_backView addSubview:singleSelectedView];
            [self bringSubviewToFront:_backView];
            singleSelectedView.tag = kSingleSelectedTag+i;
            [singleSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLabel.mas_top).offset(-10/2);
                make.left.equalTo(titleLabel.mas_right).with.offset(40/2);
                make.right.equalTo(_backView.mas_right).offset(-100);
                make.height.mas_equalTo (70);
            }];
            __block TTCNewUserViewSingleSelectedView *singleView = singleSelectedView;
            singleSelectedView.stringBlock = ^(NSString *string){
                [selfvc SinglebuttonPressedView:singleView withString:string ];
            };
            lastView= singleSelectedView;
            if (i==16)break;
        }else {
            //背景框
            UIView *backView = [[UIView alloc] init];
            backView.tag = i + kBackTag;
            backView.userInteractionEnabled = YES;
            backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            backView.layer.borderWidth = 0.5;
            backView.layer.masksToBounds = YES;
            backView.layer.cornerRadius = 4;
            [_backView addSubview:backView];
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(titleLabel.mas_centerY);
                make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                make.right.mas_equalTo(-300/2);
                make.height.mas_equalTo(70/2);
            }];
            backTagView = backView;
            //内容标签
            UITextField *textField = [[UITextField alloc] init];
            textField.tag = i + kTextFieldTag;
            textField.font = FONTSIZESBOLD(28/2);
            textField.textColor = [UIColor lightGrayColor];
            textField.delegate = self;
            [textField addTarget:self action:@selector(inputWithText:) forControlEvents:UIControlEventEditingChanged];
            [backView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backView.mas_centerY);
                make.left.mas_equalTo(3);
                make.right.mas_equalTo(-3);
            }];
            if (i == 0 ||i==2|| i == 3 || i == 4 || i == 5 ) {
                //不可填写信息
                textField.enabled = NO;
                [textField mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                }];
            }
            if (i == 15) {
                //密码输入
                textField.secureTextEntry = YES;
            }
            //下拉箭头
            UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
            dragImageView.hidden = YES;
            [backView addSubview:dragImageView];
            [dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0).with.offset(-4);
                make.centerY.mas_equalTo(backView.mas_centerY);
            }];
            //添加下来框
            if (i == 0 || i == 2 || i == 3 || i == 4 || i == 5 ) {
                //显示下拉箭头的项目
                dragImageView.hidden = NO;
                //点击手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewPressed:)];
                [backTagView addGestureRecognizer:tap];
                //DragView
                if (i == 0) {
                    //添加地址
                    TTCNewUserViewControllerAddressDragView *dragView = [[TTCNewUserViewControllerAddressDragView alloc] init];
                    dragView.tag = i + kDragViewTag;
                    [_backView addSubview:dragView];
                    [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(backTagView.mas_bottom);
                        make.left.right.mas_equalTo(backView);
                    }];
                }else{
                    //其他
                    TTCNewUserViewControllerDragView *dragView = [[TTCNewUserViewControllerDragView alloc] init];
                    dragView.tag = i + kDragViewTag;
                    [_backView addSubview:dragView];
                    [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(backTagView.mas_bottom);
                        make.left.right.mas_equalTo(backTagView);
                    }];
                    if (i != 16) {
                        dragView.stringBlock = ^(NSString *string){
                            textField.text = string;
                            [self inputWithText:textField];
                        };
                    }
                }
            }
            
        }
        if (i == 0) {
            //添加地址
            _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_addAddressButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            _addAddressButton.layer.masksToBounds = YES;
            _addAddressButton.layer.cornerRadius = 4;
            _addAddressButton.backgroundColor = DARKBLUE;
            [_addAddressButton setTitle:@"添加地址" forState:UIControlStateNormal];
            [_addAddressButton setTitleColor:WHITE forState:UIControlStateNormal];
            
            _addAddressButton.titleLabel.font = FONTSIZESBOLD(28/2);
            [_backView addSubview:_addAddressButton];
            [_addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backTagView.mas_centerY);
                make.left.mas_equalTo(backTagView.mas_right).with.offset(30/2);
                make.width.mas_equalTo(140/2);
                make.height.mas_equalTo(54/2);
            }];
        }
        if (i == 8 || i == 9 || i == 10) {
            //扫码按钮
            UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [scanButton setTag:i+kButtonTag];
            [scanButton setBackgroundImage:[UIImage imageNamed:@"newUser_btn_scan"] forState:UIControlStateNormal];
            [scanButton addTarget:self action:@selector(scanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:scanButton];
            [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backTagView.mas_centerY);
                make.left.mas_equalTo(backTagView.mas_right).with.offset(30/2);
            }];
        }
        
#else
        //背景框
        UIView *backView = [[UIView alloc] init];
        backView.tag = i + kBackTag;
        backView.userInteractionEnabled = YES;
        backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        backView.layer.borderWidth = 0.5;
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 4;
        [_backView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
            make.right.mas_equalTo(-300/2);
            make.height.mas_equalTo(70/2);
        }];
        if (i == 0) {
            //添加地址
            _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_addAddressButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            _addAddressButton.layer.masksToBounds = YES;
            _addAddressButton.layer.cornerRadius = 4;
            _addAddressButton.backgroundColor = DARKBLUE;
            [_addAddressButton setTitle:@"添加地址" forState:UIControlStateNormal];
            [_addAddressButton setTitleColor:WHITE forState:UIControlStateNormal];
            
            _addAddressButton.titleLabel.font = FONTSIZESBOLD(28/2);
            [_backView addSubview:_addAddressButton];
            [_addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backView.mas_centerY);
                make.left.mas_equalTo(backView.mas_right).with.offset(30/2);
                make.width.mas_equalTo(140/2);
                make.height.mas_equalTo(54/2);
            }];
        }
        if (i == 8 || i == 9||i == 10) {
            //扫码按钮
            UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [scanButton setTag:i+kButtonTag];
            [scanButton setBackgroundImage:[UIImage imageNamed:@"newUser_btn_scan"] forState:UIControlStateNormal];
            [scanButton addTarget:self action:@selector(scanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:scanButton];
            [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backView.mas_centerY);
                make.left.mas_equalTo(backView.mas_right).with.offset(30/2);
            }];
        }
        //内容标签
        UITextField *textField = [[UITextField alloc] init];
        textField.tag = i + kTextFieldTag;
        textField.font = FONTSIZESBOLD(28/2);
        textField.textColor = [UIColor lightGrayColor];
        textField.delegate = self;
        [textField addTarget:self action:@selector(inputWithText:) forControlEvents:UIControlEventEditingChanged];
        [backView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.left.mas_equalTo(3);
            make.right.mas_equalTo(-3);
        }];
        if (i == 0 || i == 2 || i == 3 || i == 4 || i == 5 || i == 6 || i == 11 || i == 12 || i == 13 || i == 16) {//
            //不可填写信息
            textField.enabled = NO;
            [textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
            }];
        }
        if (i<11 && i>6){
            textField.keyboardType = UIKeyboardTypePhonePad;
        }
        if (i==14) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        
        if (i == 15) {
            //密码输入
            textField.secureTextEntry = YES;
        }
        //下拉箭头
        UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
        dragImageView.hidden = YES;
        [backView addSubview:dragImageView];
        [dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0).with.offset(-4);
            make.centerY.mas_equalTo(backView.mas_centerY);
        }];
        //添加下来框
        if (i == 0 || i == 2 || i == 3 || i == 4 || i == 5 || i == 6 || i == 11 || i == 12 || i == 13 || i == 16) {//
            //显示下拉箭头的项目
            dragImageView.hidden = NO;
            //点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewPressed:)];
            [backView addGestureRecognizer:tap];
            //DragView
            if (i == 0) {
                //添加地址
                TTCNewUserViewControllerAddressDragView *dragView = [[TTCNewUserViewControllerAddressDragView alloc] init];
                dragView.tag = i + kDragViewTag;
                [_backView addSubview:dragView];
                [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(backView.mas_bottom);
                    make.left.right.mas_equalTo(backView);
                }];
            }else{
                //其他
                TTCNewUserViewControllerDragView *dragView = [[TTCNewUserViewControllerDragView alloc] init];
                dragView.tag = i + kDragViewTag;
                [_backView addSubview:dragView];
                [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(backView.mas_bottom);
                    make.left.right.mas_equalTo(backView);
                }];
                if (i != 16) {
                    dragView.stringBlock = ^(NSString *string){
                        textField.text = string;
                        [self inputWithText:textField];
                    };
                }
            }
        }
#endif
        
    }
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView.mas_bottom).with.offset(150);
    }];
    
    //确定
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius = 4;
    _sureButton.backgroundColor = DARKBLUE;
    [_sureButton setTitle:@"确 定" forState:UIControlStateNormal];
    [_sureButton setTitleColor:WHITE forState:UIControlStateNormal];
    _sureButton.titleLabel.font = FONTSIZESBOLD(51/2);
    [_backView addSubview:_sureButton];
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(628/2);
        make.height.mas_equalTo(112/2);
    }];
    
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.width.mas_equalTo(self);
        //        make.top.mas_equalTo (self);
        //        make.right.and.left.mas_equalTo (self);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _sureButton) {
        //确定
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"开户" object:self userInfo:@{@"地址":_addressString,@"尾地址":_lastAddressString,@"开户模式":_createModeString,@"收费类型":_feeTypeString,@"上门安装":_setupString,@"所属主卡":_mainCardString,@"智能卡":_cardNumString,@"机顶盒":_topBoxString,@"Cm":_CMString,@"用户类型":_serveTypeString,@"支付方式":_payWayString,@"智能卡设备来源":_cardNumDeviceString,@"机顶盒设备来源":_topBoxDeviceString,@"EOC设备来源":_CMDeviceString,@"宽带账号":_broadAccountString,@"宽带密码":_broadPWDString,@"宽带后缀":_broadSuffixString,@"地址ID":_houseIDString}];
    }else if(button == _addAddressButton){
        //添加地址
        [[NSNotificationCenter defaultCenter] postNotificationName:@"添加地址" object:nil];
    }
}
//扫码
- (void)scanButtonPressed:(UIButton *)button{
    int buttonTag = (int)(button.tag - kButtonTag);
    NSString *postName;
    switch (buttonTag) {
        case 8:
            //智能卡
            postName = @"智能卡";
            break;
        case 9:
            //机顶盒
            postName = @"机顶盒";
            break;
        case 10:
            //机顶盒
            postName = @"EOC";
        default:
            break;
    }
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:postName object:self];
}
//点击下拉
- (void)dragViewPressed:(UITapGestureRecognizer *)tap{
    UIView *backView = (UIView *)[tap view];
    //点击下拉
    for (int i = 0; i < _titleArray.count; i ++) {
        //收起下拉列表
        TTCNewUserViewControllerDragView *allView = (TTCNewUserViewControllerDragView *)[self viewWithTag:(i+kDragViewTag)];
        if (allView) {
            [allView packUpList];
        }
        //收起键盘
        if (i == _titleArray.count - 1) {
            UITextView *textView = (UITextView *)[self viewWithTag:i+kTextFieldTag];
            [textView resignFirstResponder];
        }else{
            UITextField *textField = (UITextField *)[self viewWithTag:i+kTextFieldTag];
            [textField resignFirstResponder];
        }
    }
    TTCNewUserViewControllerDragView *dragView = (TTCNewUserViewControllerDragView *)[self viewWithTag:(backView.tag-kBackTag+kDragViewTag)];
    [dragView dragDownList];
}
//点击收起
- (void)tapPressed{
    for (int i = 0; i < _titleArray.count; i ++) {
        //收起下拉列表
        TTCNewUserViewControllerDragView *allView = (TTCNewUserViewControllerDragView *)[self viewWithTag:(i+kDragViewTag)];
        if (allView) {
            [allView packUpList];
        }
        //收起键盘
        if (i == _titleArray.count - 1) {
            UITextView *textView = (UITextView *)[self viewWithTag:i+kTextFieldTag];
            [textView resignFirstResponder];
        }else{
            UITextField *textField = (UITextField *)[self viewWithTag:i+kTextFieldTag];
            [textField resignFirstResponder];
        }
    }
}
//输入数据资料
- (void)inputWithText:(id)text{
    UITextField *textField = (UITextField *)text;
    switch (textField.tag - kTextFieldTag) {
        case 0:
            //地址
            _addressString = textField.text;
            break;
        case 1:
            //尾地址
            _lastAddressString = textField.text;
            break;
        case 2:
            //开户模式
            _createModeString = textField.text;
            break;
        case 3:
            //支付方式
            _payWayString = textField.text;
            break;
        case 4:
            //用户类型
            _serveTypeString = textField.text;
            break;
        case 5:
            //收费类型
            _feeTypeString = textField.text;
            break;
        case 6:
            //上门安装
            _setupString = textField.text;
            break;
        case 7:
            //所属主卡
            _mainCardString = textField.text;
            break;
        case 8:
            //智能卡
            _cardNumString = textField.text;
            break;
        case 9:
            //机顶盒
            _topBoxString = textField.text;
            break;
        case 10:
            //Cm
            _CMString = textField.text;
            break;
        case 11:
            //智能卡设备来源
            _cardNumDeviceString = textField.text;
            break;
        case 12:
            //机顶盒设备来源
            _topBoxDeviceString = textField.text;
            break;
        case 13:
            //EOC设备来源
            _CMDeviceString = textField.text;
            break;
        case 14:
            //宽带账号
            _broadAccountString = textField.text;
            break;
        case 15:
            //宽带密码
            _broadPWDString = textField.text;
            break;
        case 16:
            //宽带后缀
            _broadSuffixString = textField.text;
            break;
        default:
            break;
    }
    //     NSLog(@"输入的信息 %zd ==%@",textField.tag - kTextFieldTag,textField.text);
}

//单选视图按钮
- (void)SinglebuttonPressedView:(UIView*)view withString:(NSString*)string{
    
    switch (view.tag - kSingleSelectedTag) {
        case 2:
            //开户模式
            _createModeString = string;
            break;
        case 6:
            //上门安装
            _setupString = string;
            break;
        case 11:
            //智能卡设备来源
            _cardNumDeviceString = string;
            break;
        case 12:
            //机顶盒设备来源
            _topBoxDeviceString = string;
            break;
        case 13:
            //EOC设备来源
            _CMDeviceString = string;
            break;
        case 16:
            //宽带后缀
            _broadSuffixString = string;
            break;
        default:
            break;
    }
}

#pragma mark - Data request
#pragma mark - Protocol methods
//UITextFieldDelegate Method
//UITextFieldDelegate Method
//选择单选按钮
#if 0
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger textFieldIndex = textField.tag - kTextFieldTag;
    //编辑状态 视图网上移动
    if (textFieldIndex >= 14) {//14
        [UIView animateWithDuration:2 animations:^{
            [self setContentOffset:CGPointMake(0, 630) animated:YES];
        }];
    }else if (textFieldIndex==7){
        [UIView animateWithDuration:2 animations:^{
            [self setContentOffset:CGPointMake(0, 200) animated:YES];
        }];
    }else if(textFieldIndex>=8&&textFieldIndex<11){
        [UIView animateWithDuration:2 animations:^{
            [self setContentOffset:CGPointMake(0, 300) animated:YES];
        }];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger textFieldIndex = textField.tag - kTextFieldTag;
    //编辑完成恢复原来的位置
    if (textFieldIndex >= 14) {//14
        [UIView animateWithDuration:3 animations:^{
            [self setContentOffset:CGPointMake(0, 550) animated:YES];
        }];
    }else if (textFieldIndex==7){
        [UIView animateWithDuration:2 animations:^{
            [self setContentOffset:CGPointMake(0, 150) animated:YES];
        }];
    }else if(textFieldIndex>=8&&textFieldIndex<11){
        [UIView animateWithDuration:2 animations:^{
            [self setContentOffset:CGPointMake(0, 200) animated:YES];
        }];
    }
}
#else
//UITextFieldDelegate Method
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger textFieldIndex = textField.tag - kTextFieldTag;
    if (textFieldIndex >= 14) {
        [self setContentOffset:CGPointMake(0, 230) animated:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger textFieldIndex = textField.tag - kTextFieldTag;
    if (textFieldIndex >= 14) {
        [self setContentOffset:CGPointMake(0, 230) animated:YES];
    }
}
#endif

//UIGestureRecognizerDelegate Method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        NSLog(@"UITableViewCellContentView ----");
        return NO;
    }
    return  YES;
}
#pragma mark - Other methods
//开户模式，支付方式，用户类型，收费类型，上门安装，主副机，智能卡设备来源，机顶盒设备来源，EOC设备来源，宽带后缀，开户地址
- (void)loadCreatModeArray:(NSArray *)creatModeArray payWayArray:(NSArray *)payWayArray serveTypeArray:(NSArray *)serveTypeArray feeTypeArray:(NSArray *)feeTypeArray setupArray:(NSArray *)setupArray cardDeviceArray:(NSArray *)cardDeviceArray topBoxDeviceArray:(NSArray *)topBoxDeviceArray cmDeviceArray:(NSArray *)cmDeviceArray broadSuffixArray:(NSArray *)broadSuffixArray broadDicArray:(NSArray *)broadDicArray addressArray:(NSArray *)addressArray{
    
    //开户模式
    TTCNewUserViewControllerDragView *creatModeView = (TTCNewUserViewControllerDragView *)[self viewWithTag:2+kDragViewTag];
    [creatModeView loadWithDataArray:creatModeArray];
    //支付方式
    TTCNewUserViewControllerDragView *payWayView = (TTCNewUserViewControllerDragView *)[self viewWithTag:3+kDragViewTag];
    [payWayView loadWithDataArray:payWayArray];
    //用户类型
    TTCNewUserViewControllerDragView *serveTypeView = (TTCNewUserViewControllerDragView *)[self viewWithTag:4+kDragViewTag];
    [serveTypeView loadWithDataArray:serveTypeArray];
    //收费类型
    TTCNewUserViewControllerDragView *feeTypeView = (TTCNewUserViewControllerDragView *)[self viewWithTag:5+kDragViewTag];
    [feeTypeView loadWithDataArray:feeTypeArray];
#if 0
    
    //上门安装
    TTCNewUserViewControllerDragView *setupView = (TTCNewUserViewControllerDragView *)[self viewWithTag:6+kDragViewTag];
    [setupView loadWithDataArray:setupArray];
    //智能卡设备来源
    TTCNewUserViewControllerDragView *cardDeviceView = (TTCNewUserViewControllerDragView *)[self viewWithTag:11+kDragViewTag];
    [cardDeviceView loadWithDataArray:cardDeviceArray];
    
    //机顶盒设备来源
    TTCNewUserViewControllerDragView *topBoxDeviceView = (TTCNewUserViewControllerDragView *)[self viewWithTag:12+kDragViewTag];
    [topBoxDeviceView loadWithDataArray:topBoxDeviceArray];
    
    //EOC设备来源
    TTCNewUserViewControllerDragView *cmDeviceView = (TTCNewUserViewControllerDragView *)[self viewWithTag:13+kDragViewTag];
    [cmDeviceView loadWithDataArray:cmDeviceArray];
    //宽带后缀
    TTCNewUserViewControllerDragView *broadSuffixView = (TTCNewUserViewControllerDragView *)[self viewWithTag:16+kDragViewTag];
    _broadSuffixArray = broadDicArray;
    broadSuffixView.stringBlock = ^(NSString *string){
        UITextField *textField = (UITextField *)[self viewWithTag:16 + kTextFieldTag];
        //宽带后缀
        NSString *sufficString = @"";
        for (NSDictionary *dic in _broadSuffixArray) {
            sufficString = [dic objectForKey:string];
            if (sufficString.length > 0) {
                if ([sufficString isEqualToString:@"0"]) {
                    sufficString = @"";
                }
                break;
            }
        }
        UITextField *broadAccountTextField = (UITextField *)[self viewWithTag:14+kTextFieldTag];
        NSRange range = [broadAccountTextField.text rangeOfString:@"@"];
        NSString *accountString;
        if (range.location != NSNotFound) {
            accountString = [broadAccountTextField.text substringToIndex:range.location];
        }else{
            accountString = broadAccountTextField.text;
        }
        broadAccountTextField.text = [NSString stringWithFormat:@"%@%@",accountString,sufficString];
        textField.text = string;
        [self inputWithText:textField];
        [self inputWithText:broadAccountTextField];
    };
    [broadSuffixView loadWithDataArray:broadSuffixArray];
    
#else
    //    //开户模式 2
    //    TTCNewUserViewSingleSelectedView *creatModeView = (TTCNewUserViewSingleSelectedView *)[self viewWithTag:2+kSingleSelectedTag];
    //    [creatModeView getTwoLineButtonDataWithArray:creatModeArray];
    //上门安装 6
    TTCNewUserViewSingleSelectedView *setupView = (TTCNewUserViewSingleSelectedView *)[self viewWithTag:6+kSingleSelectedTag];
    [setupView getDataWithArray:setupArray];
    //智能卡设备来源 11
    TTCNewUserViewSingleSelectedView *cardDeviceView = (TTCNewUserViewSingleSelectedView *)[self viewWithTag:11+kSingleSelectedTag];
    [cardDeviceView getDataWithArray:cardDeviceArray];
    //机顶盒设备来源 12
    TTCNewUserViewSingleSelectedView *topBoxDeviceView = (TTCNewUserViewSingleSelectedView *)[self viewWithTag:12+kSingleSelectedTag];
    [topBoxDeviceView getDataWithArray:topBoxDeviceArray];
    //EOC设备来源 13
    TTCNewUserViewSingleSelectedView *EODSingleSelecte = (TTCNewUserViewSingleSelectedView*)[self viewWithTag:kSingleSelectedTag+13];
    [EODSingleSelecte getDataWithArray:cmDeviceArray];
    //宽带 16
    TTCNewUserViewSingleSelectedView *testSingleSelecte = (TTCNewUserViewSingleSelectedView*)[self viewWithTag:kSingleSelectedTag+16];
    _broadSuffixArray = broadDicArray;
    
    testSingleSelecte.stringBlock = ^(NSString *string){
        TTCNewUserViewSingleSelectedView *BroadButtonSelected = (TTCNewUserViewSingleSelectedView *)[self viewWithTag:16 + kSingleSelectedTag];
        //宽带后缀
        NSString *sufficString = @"";
        for (NSDictionary *dic in _broadSuffixArray) {
            sufficString = [dic objectForKey:string];
            if (sufficString.length > 0) {
                if ([sufficString isEqualToString:@"0"]) {
                    sufficString = @"";
                }
                break;
            }
        }
        UITextField *broadAccountTextField = (UITextField *)[self viewWithTag:14+kTextFieldTag];
        NSRange range = [broadAccountTextField.text rangeOfString:@"@"];
        NSString *accountString;
        if (range.location != NSNotFound) {
            accountString = [broadAccountTextField.text substringToIndex:range.location];
        }else{
            accountString = broadAccountTextField.text;
        }
        broadAccountTextField.text = [NSString stringWithFormat:@"%@%@",accountString,sufficString];
        
        [self SinglebuttonPressedView:BroadButtonSelected withString:string];
        [self inputWithText:broadAccountTextField];
    };
    [testSingleSelecte  getDataWithArray:broadSuffixArray];
    //数据返回显示视图
    _backView.hidden = NO;
#endif
    //开户地址
    TTCNewUserViewControllerAddressDragView *addressView = (TTCNewUserViewControllerAddressDragView *)[self viewWithTag:0+kDragViewTag];
    _addressArray = addressArray;
    addressView.stringBlock = ^(NSString *string){
        //开户地址
        for (NSDictionary *dic in _addressArray) {
            NSString *allAddr = [NSString stringWithFormat:@"%@%@",[dic.allValues firstObject],[dic.allKeys firstObject]];
            if ([string isEqualToString:allAddr]) {
                UITextField *addrTextField = (UITextField *)[self viewWithTag:0+kTextFieldTag];
                addrTextField.text = [dic.allValues firstObject];
                UITextField *endAddrTextField = (UITextField *)[self viewWithTag:1+kTextFieldTag];
                endAddrTextField.text = [dic.allKeys firstObject];
                [self inputWithText:addrTextField];
                [self inputWithText:endAddrTextField];
                break;
            }
        }
    };
    [addressView loadWithDataArray:addressArray];
    
}
//扫一扫
- (void)loadScanStringWithScanString:(NSString *)scanString{
    NSArray *scanArray = [scanString componentsSeparatedByString:@" "];
    if([[scanArray firstObject] isEqualToString:@"机顶盒"]){
        _topBoxString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:9+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }else if([[scanArray firstObject] isEqualToString:@"智能卡"]){
        _cardNumString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:8+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }else if([[scanArray firstObject] isEqualToString:@"EOC"]){
        _CMDeviceString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:10+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }
}
//地址
- (void)loadAddressStringWithAddressString:(NSString *)addrString{
    _addressString = addrString;
    UITextField *textField = (UITextField *)[self viewWithTag:0+kTextFieldTag];
    textField.text = _addressString;
}
//尾地址
- (void)loadLastAddressStringWithAddressString:(NSString *)lastAddrString{
    _lastAddressString = lastAddrString;
    UITextField *textField = (UITextField *)[self viewWithTag:1+kTextFieldTag];
    textField.text = _lastAddressString;
}
//add
//添加客户账户
- (void)loadUserbroadAccountString:(NSString*)broadAccountString {
    _broadAccountString = broadAccountString;
    UITextField *textField = (UITextField *)[self viewWithTag:14+kTextFieldTag];
    textField.text = _broadAccountString;
}

@end
