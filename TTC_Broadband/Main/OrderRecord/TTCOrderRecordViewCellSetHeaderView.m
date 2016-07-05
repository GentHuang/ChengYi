//
//  TTCOrderRecordViewCellSetHeaderView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 15/10/7.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
#import "TTCOrderRecordViewCellSetHeaderView.h"
@interface TTCOrderRecordViewCellSetHeaderView()
@property (strong, nonatomic) UIImageView *cellImageView;
@property (strong, nonatomic) UILabel *IDLabel;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *dateLabel;
@end
@implementation TTCOrderRecordViewCellSetHeaderView
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
    //图片
    _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_img2"]];
    [self addSubview:_cellImageView];
    //业务流水号
    _IDLabel = [[UILabel alloc] init];
    _IDLabel.text = @"业务流水号 201509192019019";
    _IDLabel.textColor = DARKBLUE;
    _IDLabel.font = FONTSIZESBOLD(26/2);
    [self addSubview:_IDLabel];
    //受理人
    _userLabel = [[UILabel alloc] init];
    _userLabel.hidden = YES;
    _userLabel.textAlignment = NSTextAlignmentRight;
    _userLabel.text = @"受理人 陈六";
    _userLabel.textColor = [UIColor lightGrayColor];
    _userLabel.font = FONTSIZESBOLD(26/2);
    [self addSubview:_userLabel];
    //下划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    //业务受理时间
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.text = @"业务受理时间 2015-07";
    _dateLabel.textColor = DARKBLUE;
    _dateLabel.font = FONTSIZESBOLD(26/2);
    [self addSubview:_dateLabel];
}
- (void)setSubViewLayout{
    //图片
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(57/2);
    }];
    //账单ID
    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_cellImageView.mas_right).with.offset(5);
    }];
    //受理人
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-57/2);
    }];
    //业务受理时间
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-57/2);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    //下划线
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-1);
        make.left.mas_equalTo(54/2);
        make.right.mas_equalTo(-50/2);
        make.height.mas_equalTo(0.5);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载业务流水号
- (void)loadOrderID:(NSString *)orderid{
    _IDLabel.text = [NSString stringWithFormat:@"业务流水号 %@",orderid?orderid:@" "];
}
//加载业务受理时间
- (void)loadDateWithDateString:(NSString *)dateString{
    NSString *string = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
    _dateLabel.text = [NSString stringWithFormat:@"业务受理时间 %@",string?string:@" "];
}
@end
