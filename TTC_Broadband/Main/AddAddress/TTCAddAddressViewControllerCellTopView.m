//
//  TTCAddAddressViewControllerCellTopView.m
//  TTC_Broadband
//
//  Created by apple on 16/1/4.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCAddAddressViewControllerCellTopView.h"

@interface TTCAddAddressViewControllerCellTopView()<UITextFieldDelegate>
@property (strong, nonatomic) NSArray *titleNameArray;
@property (strong, nonatomic) UILabel *areaLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) NSString *factorString;
@end

@implementation TTCAddAddressViewControllerCellTopView
#pragma mark - Init methods
- (void)initData{
    //标题名称数组
    _titleNameArray = @[@"业务区:",@"查询条件:"];
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
    //业务区 查询条件
    for (int i = 0; i < _titleNameArray.count; i ++) {
        //标题名称
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = _titleNameArray[i];
        titleLabel.textColor = LIGHTDARK;
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = FONTSIZESBOLD(30/2);
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(77/2+i*(30/2+83/2));
            make.right.mas_equalTo(-1000/2);
        }];
        //背景
        UIView *backView = [[UIView alloc] init];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 4;
        backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        backView.layer.borderWidth = 0.5;
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.left.mas_equalTo(titleLabel.mas_right).with.offset(10);
            make.width.mas_equalTo(785/2);
            make.height.mas_equalTo(93/2);
        }];
        if (i == 0) {
            //业务区
            _areaLabel = [[UILabel alloc] init];
            _areaLabel.text = @"大连";
            _areaLabel.textColor = LIGHTDARK;
            _areaLabel.textAlignment = NSTextAlignmentRight;
            _areaLabel.font = FONTSIZESBOLD(30/2);
            [backView addSubview:_areaLabel];
            [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView.mas_left).with.offset(10);
                make.centerY.mas_equalTo(backView.mas_centerY);
            }];
        }else if(i == 1){
            //查询条件
            //输入框
            _textField = [[UITextField alloc] init];
            _textField.backgroundColor = WHITE;
            _textField.delegate = self;
            _textField.borderStyle = UITextBorderStyleNone;
            _textField.textColor = [UIColor darkGrayColor];
            _textField.textAlignment = NSTextAlignmentLeft;
            _textField.font = FONTSIZES(30/2);
            [backView addSubview:_textField];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(backView.mas_left).with.offset(10);
                make.top.bottom.right.mas_equalTo(0);
            }];
            //搜索框
            _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _searchButton.backgroundColor = CLEAR;
            [_searchButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_searchButton setImage:[UIImage imageNamed:@"ucl_btn_search"] forState:UIControlStateNormal];
            [_searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, -0, 0, 0)];
            [backView addSubview:_searchButton];
            [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_textField.mas_right);
                make.top.bottom.mas_equalTo(_textField);
            }];
        }
    }
}
- (void)setSubViewLayout{
    
}
#pragma mark - Event response
- (void)buttonPressed:(UIButton *)button{
//    NSArray *factorArray = [_textField.text componentsSeparatedByString:@" "];
//    _factorString = [factorArray lastObject];
    //清楚空格
    _factorString = [_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"添加地址-查询" object:self userInfo:@{@"查询条件":_factorString}];
}
#pragma mark - Data request
#pragma mark - Protocol methods
//UITextFieldDelegate Method
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @" ";
}
#pragma mark - Other methods
//加载业务区
- (void)loadArea:(NSString *)areaString{
    _areaLabel.text = areaString;
}
//收起键盘
- (void)packUpKeyBoard{
    [_textField resignFirstResponder];
}
@end
