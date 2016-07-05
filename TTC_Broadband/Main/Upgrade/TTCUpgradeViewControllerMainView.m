//
//  TTCUpgradeViewControllerMainView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/3.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCUpgradeViewControllerMainView.h"
#import "TTCUpgradeViewControllerDragView.h"
//Macro
#define kBackTag 82000
#define kDragViewTag 83000
#define kTextFieldTag 84000
#define kButtonTag 85000
@interface TTCUpgradeViewControllerMainView()<UIGestureRecognizerDelegate,UITextViewDelegate>
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIButton *sureButton;
@property (strong, nonatomic) UIButton *addAddressButton;
@property (strong, nonatomic) UIButton *upgradeButton;
@property (strong, nonatomic) UIView *upgradeBackView;
@property (strong, nonatomic) NSString *oldTopBoxString;
@property (strong, nonatomic) NSString *oldCardNumString;
@property (strong, nonatomic) NSString *createModeString;
@property (strong, nonatomic) NSString *feeTypeString;
@property (strong, nonatomic) NSString *setupString;
@property (strong, nonatomic) NSString *mainSeconderyString;
@property (strong, nonatomic) NSString *mainCardString;
@property (strong, nonatomic) NSString *topBoxString;
@property (strong, nonatomic) NSString *cardNumString;
@end

@implementation TTCUpgradeViewControllerMainView
#pragma mark - Init methods
- (void)initData{
    //标题名称
    _titleArray = @[@"旧机顶盒:",@"旧智能卡:",@"开户模式:",@"收费类型:",@"上门安装:",@"主副机:",@"所属主卡:",@"是否升级设备",@"机顶盒:",@"智能卡:"];
    //资料初始化
    _oldTopBoxString = @"";
    _oldCardNumString = @"";
    _createModeString = @"";
    _feeTypeString = @"";
    _setupString = @"";
    _mainSeconderyString = @"";
    _mainCardString = @"";
    _cardNumString = @"";
    _topBoxString = @"";
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
    //创建信息列表
    for (int i = 0; i < _titleArray.count; i ++) {
        //升级按钮
        if (i == 7) {
            _upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_upgradeButton addTarget:self action:@selector(upgradeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [_upgradeButton setTitle:_titleArray[i] forState:UIControlStateNormal];
            [_upgradeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_upgradeButton setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
            [_upgradeButton setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
            _upgradeButton.titleLabel.font = FONTSIZESBOLD(30/2);
            [self addSubview:_upgradeButton];
            [_upgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(135/2+i*(30/2+55/2));
                make.right.mas_equalTo(-1000/2);
            }];
            //是否升级设备背景
            _upgradeBackView = [[UIView alloc] init];
            [self addSubview:_upgradeBackView];
            [_upgradeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_upgradeButton.mas_bottom).with.offset(55/2);
                make.left.right.mas_equalTo(0);
                make.bottom.mas_equalTo(-TAB_HEIGHT);
            }];
            
        }else{
            //标题名称
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = _titleArray[i];
            titleLabel.textAlignment = NSTextAlignmentRight;
            titleLabel.font = FONTSIZESBOLD(30/2);
            titleLabel.textColor = LIGHTDARK;
            if (i > 7) {
                [_upgradeBackView addSubview:titleLabel];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo((i-8)*(30/2+55/2));
                    make.right.mas_equalTo(-1000/2);
                }];
            }else{
                [self addSubview:titleLabel];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(135/2+i*(30/2+55/2));
                    make.right.mas_equalTo(-1000/2);
                }];
            }
            //背景框
            UIView *backView = [[UIView alloc] init];
            backView.tag = i + kBackTag;
            backView.userInteractionEnabled = YES;
            backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            backView.layer.borderWidth = 0.5;
            backView.layer.masksToBounds = YES;
            backView.layer.cornerRadius = 4;
            if (i > 7) {
                [_upgradeBackView addSubview:backView];
            }else{
                [self addSubview:backView];
            }
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(titleLabel.mas_centerY);
                make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                make.right.mas_equalTo(-300/2);
                make.height.mas_equalTo(54/2);
            }];
            if (i == 0 || i == 1 || i == 8 || i == 9) {
                //扫码按钮
                UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [scanButton setTag:i+kButtonTag];
                [scanButton setBackgroundImage:[UIImage imageNamed:@"newUser_btn_scan"] forState:UIControlStateNormal];
                [scanButton addTarget:self action:@selector(scanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                if (i > 7) {
                    [_upgradeBackView addSubview:scanButton];
                }else{
                    [self addSubview:scanButton];
                }
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
            [textField addTarget:self action:@selector(inputWithText:) forControlEvents:UIControlEventEditingChanged];
            [backView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backView.mas_centerY);
                make.left.mas_equalTo(3);
                make.right.mas_equalTo(-3);
            }];
            if (i == 2 || i == 3 || i == 4 || i == 5) {
                //不可填写信息
                textField.enabled = NO;
                [textField mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                }];
            }
            //下拉箭头
            UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
            dragImageView.hidden = YES;
            [backView addSubview:dragImageView];
            [dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0).with.offset(-4);
                make.centerY.mas_equalTo(backView.mas_centerY);
            }];
            if (i == 2 || i == 3 || i == 4 || i == 5) {
                //显示下拉箭头的项目
                dragImageView.hidden = NO;
                //点击手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewPressed:)];
                [backView addGestureRecognizer:tap];
                //DragView
                TTCUpgradeViewControllerDragView *dragView = [[TTCUpgradeViewControllerDragView alloc] init];
                dragView.tag = i + kDragViewTag;
                if (i > 7) {
                    [_upgradeBackView addSubview:dragView];
                }else{
                    [self addSubview:dragView];
                }
                [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(backView.mas_bottom);
                    make.left.right.mas_equalTo(backView);
                }];
            }
        }
    }
    //确定
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius = 4;
    _sureButton.backgroundColor = DARKBLUE;
    [_sureButton setTitle:@"确 定" forState:UIControlStateNormal];
    [_sureButton setTitleColor:WHITE forState:UIControlStateNormal];
    _sureButton.titleLabel.font = FONTSIZESBOLD(51/2);
    [self addSubview:_sureButton];
}
- (void)setSubViewLayout{
    //确定
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-100);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(628/2);
        make.height.mas_equalTo(112/2);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _sureButton) {
        //确定
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"升级" object:self userInfo:@{@"旧机顶盒":_oldTopBoxString,@"旧智能卡":_oldCardNumString,@"开户模式":_createModeString,@"收费类型":_feeTypeString,@"上门安装":_setupString,@"主副机":_mainSeconderyString,@"所属主卡":_mainCardString,@"智能卡":_cardNumString,@"机顶盒":_topBoxString}];
    }
}
//扫码
- (void)scanButtonPressed:(UIButton *)button{
    int buttonTag = (int)(button.tag - kButtonTag);
    NSString *postName;
    switch (buttonTag) {
        case 0:
            //旧机顶盒
            postName = @"旧机顶盒";
            break;
        case 1:
            //旧智能卡
            postName = @"旧智能卡";
            break;
        case 8:
            //机顶盒
            postName = @"机顶盒";
            break;
        case 9:
            //智能卡
            postName = @"智能卡";
            break;
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
        TTCUpgradeViewControllerDragView *allView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:(i+kDragViewTag)];
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
    TTCUpgradeViewControllerDragView *dragView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:(backView.tag-kBackTag+kDragViewTag)];
    [dragView dragDownList];
    //选择赋值
    dragView.stringBlock = ^(NSString *string){
        for (UIView *subView in backView.subviews) {
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                textField.text = string;
                [self inputWithText:textField];
            }
        }
    };
}
//点击收起
- (void)tapPressed{
    for (int i = 0; i < _titleArray.count; i ++) {
        //收起下拉列表
        TTCUpgradeViewControllerDragView *allView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:(i+kDragViewTag)];
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
            //旧机顶盒
            _oldTopBoxString = textField.text;
            break;
        case 1:
            //旧智能卡
            _oldCardNumString = textField.text;
            break;
        case 2:
            //开户模式
            _createModeString = textField.text;
            break;
        case 3:
            //收费类型
            _feeTypeString = textField.text;
            break;
        case 4:
            //上门安装
            _setupString = textField.text;
            break;
        case 5:
            //主副机
            _mainSeconderyString = textField.text;
            break;
        case 6:
            //所属主卡
            _mainCardString = textField.text;
            break;
        case 8:
            //机顶盒
            _topBoxString = textField.text;
            break;
        case 9:
            //智能卡
            _cardNumString = textField.text;
            break;
        default:
            break;
    }
}
//升级设备
- (void)upgradeButtonPressed{
    self.buttonBlock(nil);
}
#pragma mark - Data request
#pragma mark - Protocol methods
//UIGestureRecognizerDelegate Method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
#pragma mark - Other methods
//加载开户模式，收费类型，上门安装，主副机
- (void)loadCreatModeArray:(NSArray *)creatModeArray feeTypeArray:(NSArray *)feeTypeArray setupArray:(NSArray *)setupArray mainSeconderyArray:(NSArray *)mainSeconderyArray{
    //开户模式
    TTCUpgradeViewControllerDragView *creatModeView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:2+kDragViewTag];
    [creatModeView loadWithDataArray:creatModeArray];
    //收费类型
    TTCUpgradeViewControllerDragView *feeTypeView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:3+kDragViewTag];
    [feeTypeView loadWithDataArray:feeTypeArray];
    //上门安装
    TTCUpgradeViewControllerDragView *setupView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:4+kDragViewTag];
    [setupView loadWithDataArray:setupArray];
    //主副机
    TTCUpgradeViewControllerDragView *mainSeconderyView = (TTCUpgradeViewControllerDragView *)[self viewWithTag:5+kDragViewTag];
    [mainSeconderyView loadWithDataArray:mainSeconderyArray];
}
//扫一扫
- (void)loadScanStringWithScanString:(NSString *)scanString{
    NSArray *scanArray = [scanString componentsSeparatedByString:@" "];
    if ([[scanArray firstObject] isEqualToString:@"旧机顶盒"]) {
        _oldTopBoxString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:0+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }else if([[scanArray firstObject] isEqualToString:@"旧智能卡"]){
        _oldCardNumString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:1+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }else if([[scanArray firstObject] isEqualToString:@"机顶盒"]){
        _topBoxString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:8+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }else if([[scanArray firstObject] isEqualToString:@"智能卡"]){
        _cardNumString = [scanArray lastObject];
        UITextField *textField = (UITextField *)[self viewWithTag:9+kTextFieldTag];
        textField.text = [scanArray lastObject];
    }
}
//是否升级设备
- (void)isUpgradeDevice:(BOOL)isUpgrade{
    _upgradeButton.selected = isUpgrade;
    _upgradeBackView.hidden = !isUpgrade;
}
@end
