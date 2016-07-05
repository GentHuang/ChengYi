//
//  TTCNewCustomViewControllerMainView.m
//  TTC_Broadband
//
//  Created by apple on 15/12/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCNewCustomViewControllerMainView.h"
#import "TTCNewCustomViewControllerDragView.h"
//Macro
#define kBackTag 62000
#define kDragViewTag 63000
#define kTextFieldTag 64000
#define KSingleButtonTag 65000
@interface TTCNewCustomViewControllerMainView()<UIGestureRecognizerDelegate,UITextViewDelegate>
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIButton *sureButton;
@property (strong, nonatomic) UIButton *addAddressButton;
@property (strong, nonatomic) NSString *areaString;
@property (strong, nonatomic) NSString *custNameString;
@property (strong, nonatomic) NSString *cardTypeString;
@property (strong, nonatomic) NSString *cardIDString;
@property (strong, nonatomic) NSString *MobileString;
@property (strong, nonatomic) NSString *custTypeString;
@property (strong, nonatomic) NSString *custSubTypeString;
@property (strong, nonatomic) NSString *shareString;
@property (strong, nonatomic) NSString *contactNameString;
@property (strong, nonatomic) NSString *contactAddString;
@property (strong, nonatomic) NSString *remarkString;
//存储数据
@property (strong, nonatomic) NSArray *shareArray;
@end
@implementation TTCNewCustomViewControllerMainView
#pragma mark - Init methods
- (void)initData{
    //标题名称
    _titleArray = @[@"业务区:",@"客户名称:",@"证件类型:",@"证件号码:",@"手机:",@"客户类别:",@"客户子类型:",@"农村文化共享户:",@"联系人:",@"联系地址:",@"备注:"];
    //初始化
    _areaString = @"";
    //客户名称
    _custNameString = @"";
    //证件类型
    _cardTypeString = @"";
    //证件号码
    _cardIDString = @"";
    //手机
    _MobileString = @"";
    //客户类别
    _custTypeString = @"";
    //客户子类型
    _custSubTypeString = @"";
    //农村文化共享户
    _shareString = @"";
    //联系人
    _contactNameString = @"";
    //联系地址
    _contactAddString = @"";
    //备注
    _remarkString = @"";
    _shareArray = @[@"是",@"否"];
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
        //标题名称
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = _titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = FONTSIZESBOLD(30/2);
        titleLabel.textColor = LIGHTDARK;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(135/2+i*(30/2+55/2));
            make.right.mas_equalTo(-1000/2);
        }];
        //必填项标明
        UILabel *pointLabel = [[UILabel alloc] init];
        pointLabel.text = @"*";
        pointLabel.textAlignment = NSTextAlignmentRight;
        pointLabel.font = FONTSIZESBOLD(30/2);
        pointLabel.textColor = RED;
        [self addSubview:pointLabel];
        [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.right.mas_equalTo(titleLabel.mas_left);
        }];
        if (i == 7 || i == 10) {
            //非必要项则隐藏
            pointLabel.hidden = YES;
        }
        //---add----
        if (i==7) {
            UIView *lastView;
            for (int j = 0; j<2; j++) {
                
                UIButton *singleButon = [UIButton buttonWithType:UIButtonTypeCustom];
                [singleButon addTarget:self action:@selector(singlebuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [singleButon setImage:[UIImage imageNamed:@"debt_btn_normal"] forState:UIControlStateNormal];
                [singleButon setImage:[UIImage imageNamed:@"debt_btn_selected"] forState:UIControlStateSelected];
                [singleButon setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
                singleButon.titleLabel.font = FONTSIZESBOLD(28/2);
                singleButon.tag = KSingleButtonTag+j;
                //给button添加隐藏的标题
                [self addSubview:singleButon];
                //文字
                UILabel *singleNameLabel = [[UILabel alloc]init];
                singleNameLabel.text = _shareArray[j];
                singleNameLabel.textAlignment = NSTextAlignmentRight;
                singleNameLabel.font = FONTSIZESBOLD(30/2);
                singleNameLabel.textColor = LIGHTDARK;
                [self addSubview:singleNameLabel];
                if (j==0) {
                    [singleButon mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(titleLabel.mas_centerY);
                        make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                        make.width.height.mas_equalTo(40/2);
//                        make.height.mas_equalTo(50/2);
                    }];
                    //label
                    singleNameLabel.text =_shareArray[j];
                    [singleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(singleButon.mas_centerY);;
                        make.left.mas_equalTo(singleButon.mas_right).offset(15/2);
                    }];
                    lastView = singleNameLabel;
                }else{
                    
                    [singleButon mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(titleLabel.mas_centerY);
                        make.left.mas_equalTo(lastView.mas_right).with.offset(70/2);
                        make.width.height.mas_equalTo(40/2);
//                        make..mas_equalTo(50/2);
                    }];
                    [singleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(singleButon.mas_centerY);;
                        make.left.mas_equalTo(singleButon.mas_right).offset(15/2);
                    }];
                    lastView = singleButon;
                }
            }
        //---------------------
        }else{
            //背景框
            UIView *backView = [[UIView alloc] init];
            backView.tag = i + kBackTag;
            backView.userInteractionEnabled = YES;
            backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            backView.layer.borderWidth = 0.5;
            backView.layer.masksToBounds = YES;
            backView.layer.cornerRadius = 4;
            [self addSubview:backView];
            if (i == _titleArray.count - 1) {
                //备注
                [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(titleLabel.mas_top).with.offset(0);
                    make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                    make.right.mas_equalTo(-300/2);
                    make.height.mas_equalTo(250/2);
                }];
            }else{
                //其他
                [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(titleLabel.mas_centerY);
                    make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                    make.right.mas_equalTo(-300/2);
                    make.height.mas_equalTo(70/2);
                }];
            }
            //内容标签
            if (i == _titleArray.count - 1) {
                //备注
                UITextView *textView = [[UITextView alloc] init];
                textView.tag = i + kTextFieldTag;
                textView.font = FONTSIZESBOLD(28/2);
                textView.textColor = [UIColor lightGrayColor];
                textView.delegate = self;
                [backView addSubview:textView];
                [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                    make.left.mas_equalTo(3);
                    make.right.mas_equalTo(-3);
                }];
            }else{
                //其他
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
                if (i == 2 || i == 5 || i == 6 ) {
                    //不可填写信息
                    textField.enabled = NO;
                    [textField mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(-15);
                    }];
                    //下拉箭头
                    UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
                    dragImageView.hidden = YES;
                    [backView addSubview:dragImageView];
                    [dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(0).with.offset(-4);
                        make.centerY.mas_equalTo(backView.mas_centerY);
                    }];
                    //显示下拉箭头的项目
                    dragImageView.hidden = NO;
                    //点击手势
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewPressed:)];
                    [backView addGestureRecognizer:tap];
                    //DragView
                    TTCNewCustomViewControllerDragView *dragView = [[TTCNewCustomViewControllerDragView alloc] init];
                    dragView.tag = i + kDragViewTag;
                    [self addSubview:dragView];
                    [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(backView.mas_bottom);
                        make.left.right.mas_equalTo(backView);
                    }];
                    //选择赋值
                    dragView.stringBlock = ^(NSString *string){
                        textField.text = string;
                        [self inputWithText:textField];
                    };
                }
                if (i ==3||i==4) {
                    textField.keyboardType = UIKeyboardTypePhonePad;
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
                [self addSubview:_addAddressButton];
                [_addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(backView.mas_centerY);
                    make.left.mas_equalTo(backView.mas_right).with.offset(30/2);
                    make.width.mas_equalTo(140/2);
                    make.height.mas_equalTo(70/2);
                }];
            }
        }
        
        //add
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
//点击下拉
- (void)dragViewPressed:(UITapGestureRecognizer *)tap{
    UIView *backView = (UIView *)[tap view];
    //点击下拉
    for (int i = 0; i < _titleArray.count; i ++) {
        //收起下拉列表
        TTCNewCustomViewControllerDragView *allView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:(i+kDragViewTag)];
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
    TTCNewCustomViewControllerDragView *dragView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:(backView.tag-kBackTag+kDragViewTag)];
    [dragView dragDownList];
}
//点击收起
- (void)tapPressed{
    for (int i = 0; i < _titleArray.count; i ++) {
        //收起下拉列表
        TTCNewCustomViewControllerDragView *allView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:(i+kDragViewTag)];
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
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if (button == _sureButton) {
        //确定
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"新建开户" object:self userInfo:@{@"业务区":_areaString,@"客户名称":_custNameString,@"证件类型":_cardTypeString,@"证件号码":_cardIDString,@"手机":_MobileString,@"客户类别":_custTypeString,@"客户子类型":_custSubTypeString,@"农村文化共享户":_shareString,@"联系人":_contactNameString,@"联系地址":_contactAddString,@"备注":_remarkString}];
    }else if (button == _addAddressButton){
        //添加地址
        [[NSNotificationCenter defaultCenter] postNotificationName:@"添加地址" object:nil];
    }
}
//单选按钮
- (void)singlebuttonPressed:(UIButton*)button {
    for (int i =0; i<2; i++) {
        UIButton *singleButton = (UIButton*)[self viewWithTag:i+KSingleButtonTag ];
        singleButton.selected = NO;
    }
    button.selected = YES;
    //    self.stringBlock();
    NSLog(@"%@",_shareArray[button.tag-KSingleButtonTag]);
//    _shareString
    
}
//输入数据资料
- (void)inputWithText:(id)text{
    UITextField *textField = (UITextField *)text;
    switch (textField.tag - kTextFieldTag) {
        case 0:
            //业务区
            _areaString = textField.text;
            break;
        case 1:
            //客户名称
            _custNameString = textField.text;
            break;
        case 2:
            //证件类型
            _cardTypeString = textField.text;
            break;
        case 3:
            //证件号码
            _cardIDString = textField.text;
            break;
        case 4:
            //手机
            _MobileString = textField.text;
            break;
        case 5:
            //客户类别
            _custTypeString = textField.text;
            break;
        case 6:
            //客户子类型
            _custSubTypeString = textField.text;
            break;
        case 7:
            //农村文化共享户
//            _shareString = textField.text;
            break;
        case 8:
            //联系人
            _contactNameString = textField.text;
            break;
        case 9:
            //联系地址
            _contactAddString = textField.text;
            break;
        default:
            break;
    }
}
#pragma mark - Data request
#pragma mark - Protocol methods
//UITextViewDelegate Method
- (void)textViewDidChange:(UITextView *)textView{
    //备注
    if (textView.tag == 10+kTextFieldTag) {
        _remarkString = textView.text;
    }
}
//UIGestureRecognizerDelegate Method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
#pragma mark - Other methods
//加载证件类型，客户类别，客户子类型，农村文化共享户
- (void)loadAreaWithCardTypeArray:(NSArray *)cardTypeArray custTypeArray:(NSArray *)custTypeArray custSubTypeArray:(NSArray *)custSubTypeArray shareArray:(NSArray *)shareArray{
    //证件类型
    TTCNewCustomViewControllerDragView *cardTypeDragView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:2+kDragViewTag];
    [cardTypeDragView loadWithDataArray:cardTypeArray];
    //客户类别
    TTCNewCustomViewControllerDragView *custTypeDragView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:5+kDragViewTag];
    [custTypeDragView loadWithDataArray:custTypeArray];
    //客户子类别
    TTCNewCustomViewControllerDragView *custSubTypeDragView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:6+kDragViewTag];
    [custSubTypeDragView loadWithDataArray:custSubTypeArray];
    //农村文化共享户
    TTCNewCustomViewControllerDragView *shareDragView = (TTCNewCustomViewControllerDragView *)[self viewWithTag:7+kDragViewTag];
    [shareDragView loadWithDataArray:shareArray];
}
//加载业务区
- (void)loadWithAreaString:(NSString *)areaString{
    UITextField *textField = (UITextField *)[self viewWithTag:kTextFieldTag];
    textField.text = areaString;
}
@end
