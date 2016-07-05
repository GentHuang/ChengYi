//
//  TTCShoppingCarCellHeaderView.m
//  TTC_Broadband
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCShoppingCarCellHeaderView.h"

@interface TTCShoppingCarCellHeaderView()
@property (strong, nonatomic) UILabel *sellNameLabel;
@property (strong, nonatomic) UILabel *sellLabel;
@property (strong, nonatomic) UILabel *sellNumNameLabel;
@property (strong, nonatomic) UILabel *sellNumLabel;

@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UILabel *userNumNameLabel;
@property (strong, nonatomic) UILabel *userNumLabel;
@property (strong, nonatomic) UILabel *userPhoneNameLabel;
@property (strong, nonatomic) UILabel *userPhoneLabel;

@end

@implementation TTCShoppingCarCellHeaderView
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
    //营销人员
    _sellNameLabel = [[UILabel alloc] init];
    _sellNameLabel.text = @"营销人员";
    _sellNameLabel.textAlignment = NSTextAlignmentLeft;
    _sellNameLabel.textColor = [UIColor lightGrayColor];
    _sellNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_sellNameLabel];
    //营销人员(名字)
    _sellLabel = [[UILabel alloc] init];
    _sellLabel.text = @"张三";
    _sellLabel.textAlignment = NSTextAlignmentLeft;
    _sellLabel.textColor = LIGHTDARK;
    _sellLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_sellLabel];
    //工号
    _sellNumNameLabel = [[UILabel alloc] init];
    _sellNumNameLabel.text = @"工号";
    _sellNumNameLabel.textAlignment = NSTextAlignmentLeft;
    _sellNumNameLabel.textColor = [UIColor lightGrayColor];
    _sellNumNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_sellNumNameLabel];
    //工号
    _sellNumLabel = [[UILabel alloc] init];
    _sellNumLabel.text = @"张三";
    _sellNumLabel.textAlignment = NSTextAlignmentLeft;
    _sellNumLabel.textColor = LIGHTDARK;
    _sellNumLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_sellNumLabel];
    //客户
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.text = @"客       户";
    _userNameLabel.textAlignment = NSTextAlignmentRight;
    _userNameLabel.textColor = [UIColor lightGrayColor];
    _userNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userNameLabel];
    //客户(名字)
    _userLabel = [[UILabel alloc] init];
    _userLabel.text = @"李四";
    _userLabel.textAlignment = NSTextAlignmentRight;
    _userLabel.textColor = LIGHTDARK;
    _userLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userLabel];
    //卡号
    _userNumNameLabel = [[UILabel alloc] init];
    _userNumNameLabel.text = @"客户编号";
    _userNumNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNumNameLabel.textColor = [UIColor lightGrayColor];
    _userNumNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userNumNameLabel];
    //卡号
    _userNumLabel = [[UILabel alloc] init];
    _userNumLabel.text = @"张三";
    _userNumLabel.textAlignment = NSTextAlignmentLeft;
    _userNumLabel.textColor = LIGHTDARK;
    _userNumLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userNumLabel];
    //手机号
    _userPhoneNameLabel = [[UILabel alloc] init];
    _userPhoneNameLabel.text = @"手机号";
    _userPhoneNameLabel.textAlignment = NSTextAlignmentLeft;
    _userPhoneNameLabel.textColor = [UIColor lightGrayColor];
    _userPhoneNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userPhoneNameLabel];
    //手机号
    _userPhoneLabel = [[UILabel alloc] init];
    _userPhoneLabel.text = @"张三";
    _userPhoneLabel.textAlignment = NSTextAlignmentLeft;
    _userPhoneLabel.textColor = LIGHTDARK;
    _userPhoneLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userPhoneLabel];
}
- (void)setSubViewLayout{
    //营销人员
    [_sellNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25/2);
        make.left.mas_equalTo(60/2);
    }];
    //营销人员(名字)
    [_sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25/2);
        make.left.mas_equalTo(_sellNameLabel.mas_right).with.offset(5);
    }];
    //工号
    [_sellNumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25/2);
        make.left.mas_equalTo(_sellLabel.mas_right).with.offset(15);
    }];
    //工号
    [_sellNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25/2);
        make.left.mas_equalTo(_sellNumNameLabel.mas_right).with.offset(5);
    }];
    //客户
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25/2);
        make.left.mas_equalTo(60/2);
    }];
    //客户(名字)
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25/2);
        make.left.mas_equalTo(_userNameLabel.mas_right).with.offset(5);
    }];
    //卡号
    [_userNumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25/2);
        make.left.mas_equalTo(_sellNumNameLabel.mas_left);
    }];
    //卡号
    [_userNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25/2);
        make.left.mas_equalTo(_userNumNameLabel.mas_right).with.offset(5);
    }];
    //手机号
    [_userPhoneNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25/2);
        make.left.mas_equalTo(_userNumLabel.mas_right).with.offset(15);
    }];
    //手机号
    [_userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-25/2);
        make.left.mas_equalTo(_userPhoneNameLabel.mas_right).with.offset(5);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载用户名字 营销人员名字
- (void)loadUserName:(NSString *)name sellName:(NSString *)sellName{
    _sellLabel.text = sellName;
    _sellNumLabel.text = [SellManInfo sharedInstace].loginname;
    _userLabel.text = name;
    _userNumLabel.text = [CustomerInfo shareInstance].custid;
    _userPhoneLabel.text = [CustomerInfo shareInstance].phone;
}
@end
