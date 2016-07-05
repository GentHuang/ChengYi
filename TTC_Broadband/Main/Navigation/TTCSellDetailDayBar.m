//
//  TTCSellDetailDayBar.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailDayBar.h"
//Macro
#define kButtonTag 14000
#define kSelectedColor  [UIColor colorWithRed:255/256.0 green:180/256.0 blue:0 alpha:1]
@interface TTCSellDetailDayBar()
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *yearLabel;
@property (strong, nonatomic) UILabel *monthLabel;
@property (strong, nonatomic) UIImageView *walletImageView;
@property (strong, nonatomic) UILabel *sellCountNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *sellCountLabel;
@end

@implementation TTCSellDetailDayBar
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
    //背景
    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_bg"]];
    [self addSubview:_backImageView];
    //顶部标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = WHITE;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"销售明细";
    _titleLabel.font = FONTSIZESBOLD(38/2);
    [self addSubview:_titleLabel];
    //后退按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.backgroundColor = CLEAR;
    [_backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [_backButton setImageEdgeInsets:UIEdgeInsetsMake(-38, -40, 0, 0)];
    [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    //获取当前年、月、周
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    int weekday = (int)[dateComponent weekday];
    NSArray *weekArray = @[@"周天",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString *weekString;
    for (int i = 1; i <= weekArray.count; i ++) {
        if (i == weekday) {
            weekString = weekArray[i-1];
        }
    }
    //年
    _yearLabel = [[UILabel alloc] init];
    _yearLabel.text = [NSString stringWithFormat:@"%d",year];
    _yearLabel.textColor = WHITE;
    _yearLabel.font = FONTSIZESBOLD(42/2);
    [self addSubview:_yearLabel];
    //月 周
    _monthLabel = [[UILabel alloc] init];
    _monthLabel.text = [NSString stringWithFormat:@"%02d月  %@",month,weekString];
    _monthLabel.textColor = WHITE;
    _monthLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_monthLabel];
    //销售额图片
    _walletImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nvc_img_sellCount_sellDetail"]];
    [self addSubview:_walletImageView];
    //销售额
    _sellCountNameLabel = [[UILabel alloc] init];
    _sellCountNameLabel.text = @"销售额";
    _sellCountNameLabel.textColor = WHITE;
    _sellCountNameLabel.font = FONTSIZESBOLD(34/2);
    [self addSubview:_sellCountNameLabel];
    //RMB
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_rmb_selDetail"]];
    [self addSubview:_rmbImageView];
    //销售额（数字）
    _sellCountLabel = [[UILabel alloc] init];
    _sellCountLabel.text = @"9888000.00";
    _sellCountLabel.textColor = WHITE;
    _sellCountLabel.font = FONTSIZESBOLD(40/2);
    [self addSubview:_sellCountLabel];
    //明细 销售比例
    NSArray *buttonNameArray = @[@"明细",@"销售比例"];
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.hidden = YES;
        if (i == 0) {
            allButton.backgroundColor = kSelectedColor;
            allButton.selected = YES;
        }else{
            allButton.backgroundColor = WHITE;
            allButton.selected = NO;
        }
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.layer.masksToBounds = YES;
        allButton.layer.cornerRadius = 4;
        [allButton setTitle:buttonNameArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:DARKBLUE forState:UIControlStateNormal];
        [allButton setTitleColor:WHITE forState:UIControlStateSelected];
        allButton.titleLabel.font = FONTSIZESBOLD(33/2);
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_monthLabel.mas_bottom).with.offset(5);
            make.width.mas_equalTo(172/2);
            make.height.mas_equalTo(63/2);
            make.right.mas_equalTo(-272/2+(i*(160/2)));
        }];
    }
}
- (void)setSubViewLayout{
    //背景
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //顶部标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(STA_HEIGHT+23/2);
        make.height.mas_equalTo(38/2);
    }];
    //后退按钮
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(_yearLabel.mas_top);
        make.top.mas_equalTo(STA_HEIGHT);
        make.width.mas_equalTo(100);
    }];
    //年
    [_yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(196/2);
        make.left.mas_equalTo(60/2);
    }];
    //月
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_yearLabel.mas_bottom);
        make.left.mas_equalTo(_yearLabel.mas_left);
    }];
    //销售图片
    [_walletImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_monthLabel.mas_bottom).with.offset(-1);
        make.left.mas_equalTo(_monthLabel.mas_right).with.offset(100/2);
    }];
    //销售额
    [_sellCountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_walletImageView.mas_bottom).with.offset(4);
        make.left.mas_equalTo(_walletImageView.mas_right).with.offset(14/2);
    }];
    //RMB
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_sellCountNameLabel.mas_bottom).with.offset(-3);
        make.left.mas_equalTo(_sellCountNameLabel.mas_right).with.offset(26/2);
    }];
    //销售额(数字)
    [_sellCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_rmbImageView.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_rmbImageView.mas_right).with.offset(14/2);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if(button == _backButton){
        self.stringBlock(@"后退");
    }
}
//点击带Tag按钮
- (void)tagButtonPressed:(UIButton *)button{
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        allButton.backgroundColor = WHITE;
        allButton.selected = NO;
    }
    button.backgroundColor = kSelectedColor;
    button.selected = YES;
    NSString *postNameString;
    if (button.tag == kButtonTag) {
        postNameString = @"TTCSellDetailDayBarDetail";
    }else{
        postNameString = @"TTCSellDetailDayBarChart";
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:postNameString object:self userInfo:nil];
}

#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置标题
- (void)loadSellDetailDayHeaderLabel:(NSString *)title{
    _titleLabel.text = title;
}
//更新点选按钮
- (void)reloadSelectedButton{
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        if (i != 0) {
            allButton.backgroundColor = WHITE;
            allButton.selected = NO;
        }else{
            allButton.backgroundColor = kSelectedColor;
            allButton.selected = YES;
        }
    }
}
//更新销售额(日)
- (void)loadDaySellCount:(NSString *)count{
    _sellCountLabel.text = count;
}

@end
