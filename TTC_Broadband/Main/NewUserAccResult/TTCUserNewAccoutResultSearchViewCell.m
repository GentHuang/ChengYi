//
//  TTCUserNewAccoutResultSearchView.m
//  TTC_Broadband
//
//  Created by apple on 16/4/12.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserNewAccoutResultSearchViewCell.h"

@interface TTCUserNewAccoutResultSearchViewCell()
//日期背景
@property (strong, nonatomic) UIView * dateBackView;
//订单编号
@property (strong , nonatomic) UILabel *orderIDLabel;
//操作时间
@property (strong , nonatomic) UILabel *optimeLabel;
//订单状态
@property (strong, nonatomic) UILabel *orderstatusLabele;
//boss受理号
@property (strong, nonatomic) UILabel *bossserialnoLabel;
//失败原因
@property (strong, nonatomic) UILabel *failMenLabel;
//线条
@property (strong, nonatomic) UIView *lineView;

//头部空白
//@property (strong, nonatomic) UIView *heardView;

@end

@implementation TTCUserNewAccoutResultSearchViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self setSubViewLayout];
    }
    return self;
}
- (void)createUI{
    //    //日期背景
    _dateBackView = [[UIView alloc]init];
//    _dateBackView.backgroundColor = [UIColor colorWithRed:249/256.0 green:249/256.0 blue:249/256.0 alpha:1];
    _dateBackView.backgroundColor = LIGHTGRAY;
    [self.contentView addSubview:_dateBackView];
    //    //分隔线
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView  addSubview:_lineView];

    //1.流水号
    _orderIDLabel = [[UILabel alloc] init];
      [self.contentView addSubview:_orderIDLabel];
    _orderIDLabel.text = @"ID号:";
    _orderIDLabel.font = FONTSIZESBOLD(24/2);
    _orderIDLabel.textColor = [UIColor colorWithRed:67/256.0 green:173/256.0 blue:230/256.0 alpha:1];
    
    //2.日期时间
    _optimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_optimeLabel];
    _optimeLabel.text = @"2016年4月12周二";
    _optimeLabel.textAlignment = NSTextAlignmentRight;
    _optimeLabel.font = FONTSIZESBOLD(24/2);
    _optimeLabel.textColor = [UIColor colorWithRed:67/256.0 green:173/256.0 blue:230/256.0 alpha:1];

    
    
    //3.开户结果状态
    _orderstatusLabele = [[UILabel alloc] init];
    _orderstatusLabele.text = @"开户结果状态";
//    _orderstatusLabele.textColor = [UIColor lightGrayColor];
    _orderstatusLabele.textColor = [UIColor blackColor];

    _orderstatusLabele.font = FONTSIZESBOLD(30/2);
    [self.contentView addSubview:_orderstatusLabele];
    
    //4.boss受理号
    _bossserialnoLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_bossserialnoLabel];
    _bossserialnoLabel.text = @"boss受理";
//    _bossserialnoLabel.textColor = [UIColor lightGrayColor];
    _bossserialnoLabel.textColor = [UIColor blackColor];
    _bossserialnoLabel.font = FONTSIZESBOLD(30/2);
    
    
}
- (void)setSubViewLayout{
    //    日期背景
    [_dateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30/2);
    }];
    //OrderID 号
    [_orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(20/2);
//        make.left.mas_equalTo(70/2);
        make.top.equalTo(self.mas_top).offset(30);
        make.left.equalTo(self.mas_left).offset(50/2);
    }];
    //操作时间
    [_optimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(20/2);
//        make.right.mas_equalTo(-53/2);
        make.top.equalTo(self.mas_top).offset(30);
        make.right.equalTo(self.mas_right).offset(-53/2);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
        make.top.equalTo(_orderIDLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(40/2);
        make.right.mas_equalTo(-44/2);
        make.height.mas_equalTo(0.5);
    }];
    
    //结果状态
    [_orderstatusLabele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderIDLabel.mas_bottom).with.offset(30);
        make.left.mas_equalTo(_orderIDLabel.mas_left);
    }];
    //Boss受理号
    [_bossserialnoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_optimeLabel.mas_bottom).with.offset(30);
//        make.right.mas_equalTo(_optimeLabel.mas_right);
        make.left.mas_equalTo(_orderstatusLabele.mas_right);

    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods

//获取明细信息
- (void)loadWithOrderID:(NSString *)ordertId Opentime:(NSString *)opentime Orderstatus:(NSString *)orderstatus Bossserialno:(NSString *)bossserialno failmemo:(NSString *)failmemo{
    _orderIDLabel.text = [NSString stringWithFormat:@"订单ID:%@",ordertId];
//    NSArray *optimesArray = [opentime componentsSeparatedByString:@"T"];
     NSString *string = [opentime stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
    _optimeLabel.text  = [NSString stringWithFormat:@"开户时间:%@",string];
    //bosss受理号
    if ([orderstatus isEqualToString:@"FAIL"]) {
          _bossserialnoLabel.text = [NSString stringWithFormat:@" "];
    }else {
         _bossserialnoLabel.text = [NSString stringWithFormat:@"%@",bossserialno];
    }
    if ([orderstatus isEqualToString:@"INIT"]) {
        _orderstatusLabele.text = @"初始状态";
    }else if ([orderstatus isEqualToString:@"SYNC"]){
        _orderstatusLabele.text = @"已同步到BOSS";
    }else if ([orderstatus isEqualToString:@"CANCEL"]){
        _orderstatusLabele.text = @"已取消";
    }else if ([orderstatus isEqualToString:@"LOCK"]){
        _orderstatusLabele.text = @"已锁定";
    }else if ([orderstatus isEqualToString:@"FAIL"]){
        //显示失败原因
        _orderstatusLabele.text = [NSString stringWithFormat:@"%@",failmemo];
    }else if ([orderstatus isEqualToString:@"SUCC"]){
        _orderstatusLabele.text = @"开户成功,BOSS受理号为:";
    }
}

@end
