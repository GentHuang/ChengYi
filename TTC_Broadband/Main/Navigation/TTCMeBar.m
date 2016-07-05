//
//  TTCMeBar.m
//  TTC_Broadband
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCMeBar.h"
//Macro
#define kFirstPageTag 1000
#define kLabelTag 20000

@interface TTCMeBar()
@property (strong, nonatomic) UIImageView *firstPageBackgroundImageView;
@property (strong, nonatomic) UILabel *firstPageHeaderLabel;
@property (strong, nonatomic) UIButton *firstPageInformationButton;
@property (strong, nonatomic) UIImageView *firstPageAvatarImageView;
@property (strong, nonatomic) UIButton *firstPageScanButton;
@property (strong, nonatomic) NSArray *firstPageButtonImageArray;
@property (strong, nonatomic) NSArray *firstPageButtonTitleArray;
@property (strong, nonatomic) UIView *infoBackView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIView *redPointView;
@property (strong, nonatomic) UIButton *leaveButton;

@end
@implementation TTCMeBar
#pragma mark - Init methods
- (void)initData{
    //首页模式
    _firstPageButtonImageArray = @[[UIImage imageNamed:@"nav_img_scan"],[UIImage imageNamed:@"nav_btn_list"]];
    //图片
    _imageArray = @[[UIImage imageNamed:@"nvc_img_1_sellCount"],[UIImage imageNamed:@"nvc_img_2_sellCount"],[UIImage imageNamed:@"nvc_img_4_sellCount"],[UIImage imageNamed:@"nvc_img_4_sellCount"]];
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
    self.barTintColor = WHITE;
    //背景
    _firstPageBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_firstPageBackgroundImageView];
    //客户离开
    _leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leaveButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _leaveButton.backgroundColor = CLEAR;
    _leaveButton.hidden = YES;
    [_leaveButton setImage:[UIImage imageNamed:@"nav_img_leave_udel"] forState:UIControlStateNormal];
    _leaveButton.titleLabel.font = FONTSIZESBOLD(29/2);
    [_leaveButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_leaveButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_leaveButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leaveButton];
    //顶部标题
    _firstPageHeaderLabel = [[UILabel alloc] init];
    _firstPageHeaderLabel.textColor = WHITE;
    _firstPageHeaderLabel.textAlignment = NSTextAlignmentCenter;
    _firstPageHeaderLabel.text = @"首页";
    _firstPageHeaderLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_firstPageHeaderLabel];
    //信息按钮
    _firstPageInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstPageInformationButton.backgroundColor = CLEAR;
    _firstPageInformationButton.hidden = YES;
    [_firstPageInformationButton setImage:[UIImage imageNamed:@"nav_btn_message_me"] forState:UIControlStateNormal];
    [_firstPageInformationButton setTitleColor:WHITE forState:UIControlStateNormal];
    [_firstPageInformationButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    _firstPageInformationButton.titleLabel.font = FONTSIZESBOLD(29/2);
    _firstPageInformationButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_firstPageInformationButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_firstPageInformationButton];
    //头像
    _firstPageAvatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_avatar"]];
    _firstPageAvatarImageView.backgroundColor = CLEAR;
    _firstPageAvatarImageView.layer.masksToBounds = YES;
    _firstPageAvatarImageView.layer.cornerRadius = 172/4;
    [self addSubview:_firstPageAvatarImageView];
    //营销人员信息列表
    //背景
    _infoBackView = [[UIView alloc] init];
    [self addSubview:_infoBackView];
    //列表
    UIView *lastView;
    for (int i = 0;  i < 3; i ++) {
        UILabel *firstPageLabel = [[UILabel alloc] init];
        firstPageLabel.text = @"";
        firstPageLabel.tag = i + kLabelTag;
        firstPageLabel.textColor = WHITE;
        firstPageLabel.font = FONTSIZESBOLD(28/2);
        [_infoBackView addSubview:firstPageLabel];
        if (i == 0) {
            [firstPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
            }];
        }else{
            [firstPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_left);
                make.top.mas_equalTo(lastView.mas_bottom).with.offset(10);
            }];
        }
        lastView = firstPageLabel;
        if (i > 0) {
            UIImageView *allImage = [[UIImageView alloc] initWithImage:_imageArray[i-1]];
            allImage.hidden = YES;
            [_infoBackView addSubview:allImage];
            [allImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_top).with.offset(3);
                make.right.mas_equalTo(lastView.mas_left).with.offset(-2);
            }];
        }
    }
    [_infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstPageAvatarImageView.mas_top).with.offset(3);
        make.left.mas_greaterThanOrEqualTo(_firstPageAvatarImageView.mas_right).with.offset(20);
        make.right.mas_equalTo(lastView.mas_right);
    }];
    //扫一扫和预约列表
    for (int i = 0;  i < 2; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setImage:_firstPageButtonImageArray[i] forState:UIControlStateNormal];
        allButton.hidden = YES;
        [self addSubview:allButton];
        if (i == 0) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(1042/2);
                make.centerY.mas_equalTo(_firstPageAvatarImageView.mas_centerY);
            }];
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right).with.offset(116/2);
                make.top.mas_equalTo(lastView.mas_top);
            }];
        }
        lastView = allButton;
    }
    //新消息提示小红点
    _redPointView = [[UIView alloc] init];
    _redPointView.hidden = YES;
    _redPointView.backgroundColor = RED;
    _redPointView.layer.masksToBounds = YES;
    _redPointView.layer.cornerRadius = 2.5;
    [self addSubview:_redPointView];
}
- (void)setSubViewLayout{
    //首页模式
    //背景
    [_firstPageBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //客户离开
    [_leaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_firstPageHeaderLabel.mas_centerY).with.offset(-0.5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(100);
    }];
    //顶部标题
    [_firstPageHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //信息按钮
    [_firstPageInformationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_firstPageHeaderLabel.mas_centerY);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(90);
    }];
    //头像
    [_firstPageAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(155/2);
        make.width.height.mas_equalTo(172/2);
        make.top.mas_equalTo(153/2);
    }];
    //新消息提示小红点
    [_redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_firstPageHeaderLabel.mas_centerY).with.offset(-5);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(5);
    }];
}
#pragma mark - Event response
//点击按钮(全局按钮)
- (void)buttonPressed:(UIButton *)button{
    if (button == _firstPageInformationButton) {
        //点击信息按钮
        self.stringBlock(@"信息");
    }else if (button == _leaveButton){
        //客户离开
        self.stringBlock(@"客户离开");
    }
}
//点击按钮(带Tag按钮)
- (void)tagButtonPressed:(UIButton *)button{
    int tag = (int)button.tag;
    int selectedIndex = tag - kFirstPageTag;
    if (selectedIndex == 0) {
        //点击扫一扫按钮
        self.stringBlock(@"扫一扫");
    }else{
        //点击信息按钮
        self.stringBlock(@"预约列表");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//填入我信息(姓名,ID,部门,营业厅,片区)
- (void)loadMeInformation:(NSArray *)dataArray{
    //信息列表
    for (int i = 0; i < dataArray.count; i ++) {
        UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
        allLabel.text = dataArray[i];
    }
}
//设置我标题
- (void)loadMeHeaderLabel:(NSString *)title{
    _firstPageHeaderLabel.text = title;
}
//新消息提示
- (void)newsHint:(BOOL)hasNew{
    _redPointView.hidden = !hasNew;
}

@end
