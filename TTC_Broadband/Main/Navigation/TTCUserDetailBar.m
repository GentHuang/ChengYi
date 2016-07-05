//
//  TTCUserDetailBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserDetailBar.h"
//Macro
#define kTitleTag 6000
#define kButtonTag 7000
@interface TTCUserDetailBar()
@property (strong, nonatomic) UIImageView *userDetailBackgroundImageView;
@property (strong, nonatomic) UILabel *userDetailHeaderLabel;
@property (strong, nonatomic) UIImageView *userDetailAvatarImageView;
@property (strong, nonatomic) UIButton *leaveButton;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *buttonArray;
@property (strong, nonatomic) NSArray *buttonTitleArray;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIView *infoBackView;
@end
@implementation TTCUserDetailBar
#pragma mark - Init methods
- (void)initData{
    _imageArray = @[[UIImage imageNamed:@"nav_img_id_udel"],[UIImage imageNamed:@"nav_img_cardID_udel"],[UIImage imageNamed:@"nav_img_phone_udel"],[UIImage imageNamed:@"nav_img_address_udel"]];
    _buttonArray = @[[UIImage imageNamed:@"nav_btn_buy_udel"],[UIImage imageNamed:@"nav_btn_modified_udel"],[UIImage imageNamed:@"nav_btn_recored_udel"]];
    _buttonTitleArray = @[@"产品订购",@"修改资料",@"订单记录"];
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
    //首页模式
    self.barTintColor = CLEAR;
    //背景
    _userDetailBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_userDetailBackgroundImageView];
    //顶部标题
    _userDetailHeaderLabel = [[UILabel alloc] init];
    _userDetailHeaderLabel.textColor = WHITE;
    _userDetailHeaderLabel.textAlignment = NSTextAlignmentCenter;
    _userDetailHeaderLabel.text = @"客户详情";
    _userDetailHeaderLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_userDetailHeaderLabel];
    //客户离开
    _leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leaveButton.backgroundColor = CLEAR;
    [_leaveButton setImage:[UIImage imageNamed:@"nav_img_leave_udel"] forState:UIControlStateNormal];
    [_leaveButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_leaveButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 40, 0)];
    [self addSubview:_leaveButton];
    //头像
    _userDetailAvatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_customer"]];
    _userDetailAvatarImageView.backgroundColor = CLEAR;
    _userDetailAvatarImageView.layer.masksToBounds = YES;
    _userDetailAvatarImageView.layer.cornerRadius = 172/4;
    [self addSubview:_userDetailAvatarImageView];
    //创建信息列表
    //背景
    _infoBackView = [[UIView alloc] init];
    [self addSubview:_infoBackView];
    //列表
    UIView *lastView;
    for (int i = 0;  i < _imageArray.count+1; i ++) {
        if (i == 0) {
            //姓名
            _nameLabel = [[UILabel alloc] init];
            _nameLabel.text = @"李平";
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            _nameLabel.textColor = WHITE;
            _nameLabel.font = FONTSIZESBOLD(35/2);
            [_infoBackView addSubview:_nameLabel];
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
            }];
            lastView = _nameLabel;
        }else if(i == _imageArray.count){
            //地址
            //图标
            UIImageView *allImageView = [[UIImageView alloc] initWithImage:_imageArray[i-1]];
            [_infoBackView addSubview:allImageView];
            [allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).with.offset(10);
                make.left.mas_equalTo(_nameLabel.mas_left);
            }];
            //文字
            UILabel *allLabel = [[UILabel alloc] init];
            allLabel.tag = (i-1) + kTitleTag;
            allLabel.textColor = WHITE;
            allLabel.text = @"128371982371982";
            allLabel.font = FONTSIZESBOLD(29/2);
            allLabel.numberOfLines = 2;
            [_infoBackView addSubview:allLabel];
            [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).with.offset(10);
                make.left.mas_equalTo(allImageView.mas_right).with.offset(9);
            }];
        }else{
            //图标
            UIImageView *allImageView = [[UIImageView alloc] initWithImage:_imageArray[i-1]];
            [_infoBackView addSubview:allImageView];
            if (i == 1) {
                [allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_bottom).with.offset(10);
                    make.left.mas_equalTo(lastView.mas_left);
                }];
            }else{
                [allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_top).with.offset(2);
                    make.left.mas_equalTo(lastView.mas_right).with.offset(40/2);
                }];
            }
            lastView = allImageView;
            //文字
            UILabel *allLabel = [[UILabel alloc] init];
            allLabel.tag = (i-1) + kTitleTag;
            allLabel.textColor = WHITE;
            allLabel.text = @"128371982371982";
            allLabel.font = FONTSIZESBOLD(29/2);
            [_infoBackView addSubview:allLabel];
            [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(lastView.mas_bottom).with.offset(2);
                make.left.mas_equalTo(lastView.mas_right).with.offset(20/2);
            }];
            lastView = allLabel;
        }
    }
    [_infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userDetailAvatarImageView.mas_top).with.offset(5);
        make.left.mas_equalTo(_userDetailAvatarImageView.mas_right).with.offset(67/2);
        make.bottom.mas_equalTo(lastView.mas_bottom);
    }];
    //后退按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-140, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
}
- (void)setSubViewLayout{
    //首页模式
    //背景
    [_userDetailBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_userDetailHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //客户离开
    [_leaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STA_HEIGHT);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];
    //头像
    [_userDetailAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(155/2);
        make.width.height.mas_equalTo(172/2);
        make.top.mas_equalTo(153/2);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.mas_equalTo(100);
    }];
}
#pragma mark - Event response
//点击按钮(全局按钮)
- (void)buttonPressed:(UIButton *)button{
    if (button == _leaveButton) {
        self.stringBlock(@"客户离开");
    }else if(button == _backButton){
        self.stringBlock(@"后退");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置客户详情标题
- (void)loadUserDetailHeaderLabel:(NSString *)title{
    _userDetailHeaderLabel.text = title;
}
//载入客户信息
- (void)loadClientInformationWithCustid:(NSString *)custid  markno:(NSString *)markno phone:(NSString *)phone addr:(NSString *)addr name:(NSString *)name{
    //custid
    UILabel *allLabel = (UILabel *)[self viewWithTag:(0+kTitleTag)];
    allLabel.text = custid;
    //markno
    UILabel *marknoLabel = (UILabel *)[self viewWithTag:(1+kTitleTag)];
    marknoLabel.text = markno;
    //phone
    UILabel *phoneLabel = (UILabel *)[self viewWithTag:(2+kTitleTag)];
    phoneLabel.text = phone;
    //addr
    UILabel *addrLabel = (UILabel *)[self viewWithTag:(3+kTitleTag)];
    addrLabel.text = addr;
    //name
    _nameLabel.text = name;
}
@end
