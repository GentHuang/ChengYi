//
//  TTCUserLocateScrollView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateScrollView.h"
#define kMaxWidth (975/2)
#define kButtonHeight (23/2)
#define kButtonTag 5000
@interface TTCUserLocateScrollView()<UITextFieldDelegate>
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *textBackView;
//@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *typeButton;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *memoryBackView;
@property (strong, nonatomic) UIView *downBackView;
@property (strong, nonatomic) UILabel *hintLabel;
@property (strong, nonatomic) UIButton *scanButton;
@end
@implementation TTCUserLocateScrollView
#pragma mark - Init methods
- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    //ContentView
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = LIGHTGRAY;
    [self addSubview:_contentView];
}
- (void)setSubViewLayout{
    //contentView
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self);
    }];
    //textBackView
    _textBackView = [[UIView alloc] init];
    _textBackView.backgroundColor = WHITE;
    _textBackView.layer.borderWidth = 0.5;
    _textBackView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [_contentView addSubview:_textBackView];
    [_textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(140);
    }];
    //textView
    UIView *textBoardView = [[UIView alloc] init];
    textBoardView.layer.borderWidth = 0.5;
    textBoardView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    textBoardView.layer.masksToBounds = YES;
    textBoardView.layer.cornerRadius = 5;
    [_textBackView addSubview:textBoardView];
    [textBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textBackView.mas_top).with.offset(20);
        make.left.mas_equalTo(280/2);
        make.right.mas_equalTo(-280/2);
        make.height.mas_equalTo(92/2);
    }];
    //选择类型按钮
    _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.backgroundColor = CLEAR;
    [_typeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_typeButton setTitle:@"客户证号" forState:UIControlStateNormal];
    [_typeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_typeButton setImage:[UIImage imageNamed:@"ucl_btn_dragDown"] forState:UIControlStateNormal];
    [_typeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    [_typeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -55, 0, 0)];
    [_textBackView addSubview:_typeButton];
    [_typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textBoardView.mas_left);
        make.top.bottom.mas_equalTo(textBoardView);
        make.width.mas_equalTo(130);
    }];
    //输入框
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = WHITE;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.textColor = [UIColor darkGrayColor];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.font = FONTSIZES(30/2);
    //输入键盘默认为数字
    _textField.keyboardType = UIKeyboardTypePhonePad;
    [textBoardView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_typeButton.mas_right).with.offset(15);
//        make.top.bottom.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.right.equalTo(textBoardView.mas_right).offset(-60);
    }];
    //提示信息
    _hintLabel = [[UILabel alloc] init];
    _hintLabel.userInteractionEnabled = NO;
    _hintLabel.text = @"输入提示：请输入客户证号号码 如:939919120";
    _hintLabel.textColor = [UIColor lightGrayColor];
    _hintLabel.numberOfLines = 0;
    _hintLabel.font = FONTSIZES(30/2);
    [_textBackView addSubview:_hintLabel];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textBoardView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(textBoardView.mas_left);
        make.right.mas_equalTo(textBoardView.mas_right);
    }];
    //searchButton
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.backgroundColor = CLEAR;
    [_searchButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_searchButton setImage:[UIImage imageNamed:@"ucl_btn_search"] forState:UIControlStateNormal];
    [_searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, -0, 0, 0)];
    [_textBackView addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_textField.mas_right);
        make.right.mas_equalTo(textBoardView.mas_right);
        make.top.bottom.mas_equalTo(_textField);
    }];
    //扫一扫
    _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scanButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_scanButton setBackgroundImage:[UIImage imageNamed:@"newUser_btn_scan"] forState:UIControlStateNormal];
    [_textBackView addSubview:_scanButton];
    [_scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textField.mas_right).with.offset(20);
        make.centerY.mas_equalTo(_searchButton.mas_centerY);
    }];
    //需求更改了位置
    _scanButton.hidden = YES;
    //下半部背景
    _downBackView = [[UIView alloc] init];
    _downBackView.backgroundColor = WHITE;
    _downBackView.layer.borderWidth = 0.5;
    _downBackView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [_contentView addSubview:_downBackView];
    [_downBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textBackView.mas_bottom).with.offset(25/2);
        make.left.right.mas_equalTo(0);
    }];
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = BLACK;
    _titleLabel.text = @"定位历史";
    _titleLabel.font = FONTSIZES(30/2);
    [_downBackView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(280/2);
        make.top.mas_equalTo(100/2);
    }];
    //清空按钮
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_clearButton setImage:[UIImage imageNamed:@"ucl_img_clear"] forState:UIControlStateNormal];
    [_clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [_clearButton setTitleColor:BLACK forState:UIControlStateNormal];
    _clearButton.titleLabel.font = FONTSIZES(30/2);
    [_downBackView addSubview:_clearButton];
    [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-280/2);
        make.top.mas_equalTo(100/2);
    }];
    //下划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_downBackView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.right.mas_equalTo(_clearButton.mas_right);
        make.top.mas_equalTo(_clearButton.mas_bottom).with.offset(34/2);
        make.height.mas_equalTo(0.5);
    }];
    //记录背景
    _memoryBackView = [[UIView alloc] init];
    _memoryBackView.backgroundColor = WHITE;
    [_downBackView addSubview:_memoryBackView];
    [_memoryBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lineView);
        make.width.mas_equalTo(_lineView.mas_width);
        make.top.mas_equalTo(_lineView.mas_bottom).with.offset(50/2);
    }];
    [_downBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_memoryBackView.mas_bottom).with.offset(30);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_downBackView.mas_bottom).with.offset(30);
    }];
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress)];
    [self addGestureRecognizer:tap];
}
#pragma mark - Event response
//点击按钮(全局)
- (void)buttonPressed:(UIButton *)button{
    if (button == _searchButton) {
        //搜索按钮
        if ([_textField.text isEqualToString:@""]) {
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入客户ID" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }else{
            self.stringBlock(_textField.text);
        }
        self.tapBlock(nil);
    }else if (button == _clearButton){
        //清空按钮
        self.stringBlock(@"清空");
        self.tapBlock(nil);
    }else if (button == _typeButton){
        //选择客户定位类型
        self.stringBlock(@"客户定位类型");
    }else if (button == _scanButton){
        //扫一扫
        self.stringBlock(@"扫一扫");
    }
    [_textField resignFirstResponder];
}
//点击记录按钮(带Tag)
- (void)tagButtonPressed:(UIButton *)button{
    [_textField resignFirstResponder];
    _textField.text = button.titleLabel.text;
    self.tapBlock(nil);
}
//收起键盘
- (void)tapPress{
    [_textField resignFirstResponder];
    self.tapBlock(nil);
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载记录数据
- (void)loadMemoryRecordWithArray:(NSArray *)dataArray{
    if (dataArray.count > 0) {
        UIView *lastView;
        CGFloat currX = 0;
        for (int i = 0,j = 0;  i < dataArray.count; i ++) {
            //根据字符计算Label的宽度
            NSString *contentString = dataArray[i];
            CGRect bounds = [contentString boundingRectWithSize:CGSizeMake(1000, kButtonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONTSIZES(kButtonHeight)} context:nil];
            CGFloat labelWidth = bounds.size.width+20;
            CGFloat labelX = labelWidth+30/2;
            currX += labelX;
            //创建Button
            UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [allButton setTag:(i+kButtonTag)];
            [allButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            allButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            allButton.layer.borderWidth = 0.5;
            allButton.layer.masksToBounds = YES;
            allButton.layer.cornerRadius = 5;
            allButton.backgroundColor = WHITE;
            [allButton setTitle:contentString forState:UIControlStateNormal];
            [allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            allButton.titleLabel.font = FONTSIZES(kButtonHeight);
            [_memoryBackView addSubview:allButton];
            //换行判断
            if ((currX-30/2) > kMaxWidth) {
                currX = labelX;
                j ++;
                [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(j*(66/2+46/2));
                    make.width.mas_equalTo(labelWidth);
                    make.left.mas_equalTo(0);
                    make.height.mas_equalTo(66/2);
                }];
                lastView = allButton;
                continue;
            }
            if (i == 0) {
                [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(j*(66/2+46/2));
                    make.width.mas_equalTo(labelWidth);
                    make.left.mas_equalTo(0);
                    make.height.mas_equalTo(66/2);
                }];
            }else{
                [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(j*(66/2+46/2));
                    make.width.mas_equalTo(labelWidth);
                    make.left.mas_equalTo(lastView.mas_right).with.offset(30/2);
                    make.height.mas_equalTo(66/2);
                }];
            }
            lastView = allButton;
        }
        [_memoryBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lastView.mas_bottom);
        }];
    }else{
        [self deleteSubView:_memoryBackView];
    }
}
//清空子View
- (void)deleteSubView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}
//加载客户登录类型
- (void)loadTypeWithType:(NSString *)type{
    [_typeButton setTitle:type forState:UIControlStateNormal];
}
//切换提示
- (void)changeHintWithType:(int)type{
    switch (type) {
        case 1:{
            _hintLabel.text = @"输入提示：姓名与地址之间请用/(斜杠)分开。如：张三/辽宁省大连市金州区南山路1号1单元1层1房";
            _textField.keyboardType = UIKeyboardTypeDefault;
        }
            break;
        case 2:{
            _hintLabel.text = @"输入提示：请输入客户证号号码 如:939919120";
            //输入键盘默认为数字
            _textField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case 3:
        {
            _hintLabel.text = @"输入提示：请输入机顶盒里智能卡号号码 如:8411002196649000";
            //输入键盘默认为数字
            _textField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case 4:
            _hintLabel.text = @"客户编码";
            //输入键盘默认为数字
            _textField.keyboardType = UIKeyboardTypePhonePad;
            break;
        case 5:
        {
            _hintLabel.text = @"输入提示：请输入机主身份证号码/军官证号码 如:210281197712000000";
            //输入键盘默认为数字
            _textField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case 6:
        {
            _hintLabel.text = @"输入提示：请输入办理时电话号码  如:13941000000";
            //输入键盘默认为数字
            _textField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case 7:
            _hintLabel.text = @"地址";
            break;
        default:
            _hintLabel.text = @"";
            break;
    }
}
#pragma mark---
//扫一扫
- (void)loadScanStringWithScanString:(NSString *)scanString{
    NSArray *scanArray = [scanString componentsSeparatedByString:@" "];
    if([[scanArray firstObject] isEqualToString:@"客户定位"]){
        _textField.text = [scanArray lastObject];
    }
}

@end
