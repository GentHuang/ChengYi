//
//  TTCModifiedDataMainView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//View
#import "TTCModifiedDataMainView.h"
#import "TTCModifiedDataDragView.h"
//Macro
#define kLabelTag 12000
#define kDragViewTag 13000
#define kTextFieldTag 14000
@interface TTCModifiedDataMainView()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIButton *OKButton;
@property (strong, nonatomic) NSArray *titleArray;
@end
@implementation TTCModifiedDataMainView
#pragma mark - Init methods
- (void)dataInit{
    _titleArray = @[@"客户证号：",@"客户名称：",@"客户类型：",@"证件类型：",@"证件号码：",@"手机号码：",@"联系电话：",@"所属分公司：",@"联系地址："];
}
- (instancetype)init{
    if (self = [super init]) {
        [self dataInit];
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
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_customer"]];
    [self addSubview:_avatarImageView];
    //确定
    _OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_OKButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    _OKButton.layer.masksToBounds = YES;
    _OKButton.layer.cornerRadius = 4;
    _OKButton.backgroundColor = DARKBLUE;
    [_OKButton setTitle:@"确 定" forState:UIControlStateNormal];
    [_OKButton setTitleColor:WHITE forState:UIControlStateNormal];
    _OKButton.titleLabel.font = FONTSIZESBOLD(51/2);
    //add  要求是暂时隐藏
    _OKButton.hidden = YES;
    [self addSubview:_OKButton];
    //创建资料列表
    for (int i = 0; i < _titleArray.count; i ++) {
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = _titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = FONTSIZESBOLD(30/2);
        titleLabel.textColor = LIGHTDARK;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_avatarImageView.mas_bottom).with.offset(40+i*(30/2+55/2));
            make.right.mas_equalTo(-1000/2);
        }];
        if(i == 0){
            //客户证号
            UILabel *IDLabel = [[UILabel alloc] init];
            IDLabel.tag = i + kLabelTag;
            IDLabel.text = @"87654321";
            IDLabel.font = FONTSIZESBOLD(28/2);
            IDLabel.textColor = [UIColor lightGrayColor];
            IDLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:IDLabel];
            [IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(titleLabel.mas_centerY);
//              make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                make.right.mas_equalTo(-300/2);
            }];
        }else{
            //背景框
            UIView *backView = [[UIView alloc] init];
            backView.userInteractionEnabled = NO;
            backView.tag = i+kLabelTag;
            //            backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            //            backView.layer.borderWidth = 0.5;
            //            backView.layer.masksToBounds = YES;
            //            backView.layer.cornerRadius = 4;
            [self addSubview:backView];
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(titleLabel.mas_centerY);
                make.left.mas_equalTo(titleLabel.mas_right).with.offset(40/2);
                make.right.mas_equalTo(-300/2);
                make.height.mas_equalTo(54/2);
            }];
            //内容标签
            UITextField *textFiled = [[UITextField alloc] init];
            textFiled.tag = i+kTextFieldTag;
            textFiled.borderStyle = UITextBorderStyleNone;
            textFiled.font = FONTSIZESBOLD(28/2);
            textFiled.textColor = [UIColor lightGrayColor];
            textFiled.textAlignment = NSTextAlignmentRight;
            [backView addSubview:textFiled];
            [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(backView.mas_centerY);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
            }];
            if (i == 1 || i == 4 || i == 5 || i == 6 || i == 8) {
                //客户名称 证件号码 手机号码 邮政编码 联系地址 高级备注
                textFiled.userInteractionEnabled = YES;
            }else{
                //客户类型 证件类型
                textFiled.userInteractionEnabled = NO;
                //点击手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewPressed:)];
                [backView addGestureRecognizer:tap];
                //下拉箭头
                UIImageView *dragImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_btn_dragdown"]];
                [backView addSubview:dragImageView];
                dragImageView.hidden = YES;
                [dragImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(0).with.offset(-4);
                    make.centerY.mas_equalTo(backView.mas_centerY);
                }];
                //DragView
                TTCModifiedDataDragView *dragView = [[TTCModifiedDataDragView alloc] init];
                dragView.tag = i+kDragViewTag;
                [self addSubview:dragView];
                [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(backView.mas_bottom);
                    make.left.right.mas_equalTo(backView);
                }];
            }
        }
    }
}
- (void)setSubViewLayout{
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(115/2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    //确定
    [_OKButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
        TTCModifiedDataDragView *allView = (TTCModifiedDataDragView *)[self viewWithTag:(i+kDragViewTag)];
        if (allView) {
            [allView packUpList];
        }
    }
    TTCModifiedDataDragView *dragView = (TTCModifiedDataDragView *)[self viewWithTag:(backView.tag-kLabelTag+kDragViewTag)];
    [dragView dragDownList];
    //选择赋值
    dragView.stringBlock = ^(NSString *string){
        for (UIView *subView in backView.subviews) {
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                textField.text = string;
            }
        }
    };
}
//点击按钮
- (void)buttonPressed{
    self.stringBlock(@"TTCModifiedDataMainView");
}
//点击收起
- (void)tapPressed{
    for (int i = 0; i < _titleArray.count; i ++) {
        TTCModifiedDataDragView *allView = (TTCModifiedDataDragView *)[self viewWithTag:(i+kDragViewTag)];
        if (allView) {
            [allView packUpList];
        }
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UIGestureRecognizerDelegate Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
#pragma mark - Other methods
//载入数据
- (void)loadWithCustname:(NSString *)custname custid:(NSString *)custid mobile:(NSString *)mobile addr:(NSString *)addr cardtype:(NSString *)cardtype icno:(NSString *)icno markno:(NSString *)markno cardno:(NSString *)cardno pgroupname:(NSString *)pgroupname phone:(NSString *)phone custtype:(NSString *)custtype areaname:(NSString *)areaname{
    for (int i = 0; i < _titleArray.count; i ++) {
        UITextField *textField = (UITextField *)[self viewWithTag:i+kTextFieldTag];
        UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
        switch (i) {
            case 0:
                //客户证号
                allLabel.text = markno;
                break;
            case 1:
                //客户名称
                textField.text = custname;
                break;
            case 2:{
                //客户类型
                switch ([custtype intValue]) {
                    case 0:
                        textField.text = @"个人客户";
                        break;
                    case 1:
                        textField.text = @"集团客户";
                        break;
                    case 2:
                        textField.text = @"商业客户";
                        break;
                    case 3:
                        textField.text = @"专线客户";
                        break;
                    default:
                        textField.text = @"";
                        break;
                }
            }
                break;
            case 3:{
                //证件类型
                if ([cardtype isEqualToString:@"A"]) {
                    cardtype = @"残疾证";
                }else{
                    switch ([cardtype intValue]) {
                        case 0:
                            cardtype = @"其他类型";
                            break;
                        case 1:
                            cardtype = @"身份证";
                            break;
                        case 2:
                            cardtype = @"户口本";
                            break;
                        case 3:
                            cardtype = @"军官证";
                            break;
                        case 4:
                            cardtype = @"警官证";
                            break;
                        case 5:
                            cardtype = @"志愿兵证";
                            break;
                        case 6:
                            cardtype = @"士兵证";
                            break;
                        case 7:
                            cardtype = @"护照";
                            break;
                        case 8:
                            cardtype = @"证件遗失证明";
                            break;
                        case 9:
                            cardtype = @"单位证明，营业执照";
                            break;
                        default:
                            break;
                    }
                }
                textField.text = cardtype;
            }
                break;
            case 4:
                //证件号码
                textField.text = cardno;
                break;
            case 5:
                //手机号码
                textField.text = mobile;
                break;
            case 6:
                //联系电话
                textField.text = phone;
                break;
            case 7:
                //所属分公司
                textField.text = areaname;
                break;
            case 8:
                //联系地址
                textField.text = addr;
                break;
            default:
                textField.text = @"";
                break;
        }
    }
}
@end
