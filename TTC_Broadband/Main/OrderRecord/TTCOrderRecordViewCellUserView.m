//
//  TTCOrderRecordViewCellUserView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewCellUserView.h"

@interface TTCOrderRecordViewCellUserView()
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userNameLabel;
@end

@implementation TTCOrderRecordViewCellUserView
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
    //头像
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp_img_customer"]];
    [self addSubview:_avatarImageView];
    //用户
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.text = @"用户 李四";
    _userNameLabel.textColor = [UIColor lightGrayColor];
    _userNameLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_userNameLabel];
}
- (void)setSubViewLayout{
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(57/2);
        make.width.height.mas_equalTo(80/2);
    }];
    //用户
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_avatarImageView.mas_right).with.offset(35/2);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载用户名字
- (void)loadUserName:(NSString *)name{
    _userNameLabel.text = [NSString stringWithFormat:@"用户 %@",name];
}
@end
