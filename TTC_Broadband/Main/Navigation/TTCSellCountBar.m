//
//  TTCSellCountBar.m
//  TTC_Broadband
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellCountBar.h"
//Macro
#define kLabelTag 30000
#define kImageViewTag 31000
@interface TTCSellCountBar()
//销售统计
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *hideNumButton;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIView *infoBackView;
@end
@implementation TTCSellCountBar
#pragma mark - Init methods
- (void)initData{
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
    //客户定位
    self.barTintColor = CLEAR;
    //背景
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_backgroundImageView];
    //顶部标题
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.textColor = WHITE;
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.text = @"销售统计";
    _headerLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_headerLabel];
    //后退按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-140, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    //隐藏数字
    _hideNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _hideNumButton.backgroundColor = CLEAR;
    [_hideNumButton setImage:[UIImage imageNamed:@"nav_img_hideNum_sellCount"] forState:UIControlStateNormal];
    [_hideNumButton setImageEdgeInsets:UIEdgeInsetsMake(-140, -30, 0, 0)];
    [_hideNumButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hideNumButton];
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_avatar"]];
    [self addSubview:_avatarImageView];
    //信息列表
    //背景
    _infoBackView = [[UIView alloc] init];
    _infoBackView.backgroundColor = CLEAR;
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
        make.top.mas_equalTo(_avatarImageView.mas_top).with.offset(3);
        make.left.mas_greaterThanOrEqualTo(_avatarImageView.mas_right).with.offset(20);
        make.right.mas_equalTo(lastView.mas_right);
    }];
}
- (void)setSubViewLayout{
    //背景
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STA_HEIGHT);
        make.bottom.left.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    //隐藏数字
    [_hideNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STA_HEIGHT);
        make.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(110);
    }];
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(155/2);
        make.width.height.mas_equalTo(172/2);
        make.top.mas_equalTo(153/2);
    }];
}
#pragma mark - Event response
//点击按钮(全局按钮)
- (void)buttonPressed:(UIButton *)button{
    if(button == _backButton){
        //点击后退按钮
        self.stringBlock(@"后退");
    }else if(button == _hideNumButton){
        //点击隐藏数字按钮
        self.stringBlock(@"隐藏数字");
    }
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置销售统计标题
- (void)loadSellCountHeaderLabel:(NSString *)title{
    _headerLabel.text = title;
}
//加载信息
- (void)loadWithMname:(NSString *)mname mcode:(NSString *)mcode deptname:(NSString *)deptname commission:(NSString *)commission{
    _nameLabel.text = mname;
    for (int i = 0; i < 4; i ++) {
        UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
        UIImageView *allImageView = (UIImageView *)[self viewWithTag:i+kImageViewTag];
        switch (i) {
            case 0:
                allLabel.text = mname;
                break;
            case 1:
                allLabel.text = mcode;
                break;
            case 2:
                allLabel.text = deptname;
                break;
            case 3:
                allImageView.hidden = YES;
                allLabel.hidden = YES;
                break;
            default:
                break;
        }
    }
}
@end

