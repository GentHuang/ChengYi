//
//  TTCSellDetailMonthBar.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailMonthBar.h"
//Macro
#define kButtonTag 14000
#define kSelectedColor  [UIColor colorWithRed:255/256.0 green:180/256.0 blue:0 alpha:1]
@interface TTCSellDetailMonthBar()
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *dragButton;
@property (strong, nonatomic) UILabel *yearLabel;
@property (strong, nonatomic) UILabel *monthLabel;
@property (strong, nonatomic) UIImageView *walletImageView;
@property (strong, nonatomic) UILabel *sellCountNameLabel;
@property (strong, nonatomic) UIImageView *rmbImageView;
@property (strong, nonatomic) UILabel *sellCountLabel;
@property (strong, nonatomic) UIView *sellBackView;
@end

@implementation TTCSellDetailMonthBar
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
    //获取当前年、月
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    //年
    _yearLabel = [[UILabel alloc] init];
    _yearLabel.hidden = YES;
    _yearLabel.text = [NSString stringWithFormat:@"%d",year];
    _yearLabel.textColor = WHITE;
    _yearLabel.font = FONTSIZESBOLD(42/2);
    [self addSubview:_yearLabel];
    //月
    _monthLabel = [[UILabel alloc] init];
    _monthLabel.text = [NSString stringWithFormat:@"%02d月",month];
    _monthLabel.hidden = YES;
    _monthLabel.textColor = WHITE;
    _monthLabel.font = FONTSIZESBOLD(30/2);
    [self addSubview:_monthLabel];
    //下拉按钮
    _dragButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dragButton.backgroundColor = CLEAR;
    _dragButton.hidden = YES;
    [_dragButton setImage:[UIImage imageNamed:@"nav_btn_dragDown_sellDetail"] forState:UIControlStateNormal];
    [_dragButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -30, -47)];
    [_dragButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dragButton];
    //销售额背景
    _sellBackView = [[UIView alloc] init];
    _sellBackView.backgroundColor = CLEAR;
    [self addSubview:_sellBackView];
    //销售额图片
    _walletImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nvc_img_sellCount_sellDetail"]];
    [_sellBackView addSubview:_walletImageView];
    //销售额
    _sellCountNameLabel = [[UILabel alloc] init];
    _sellCountNameLabel.text = @"销售额";
    _sellCountNameLabel.textColor = WHITE;
    _sellCountNameLabel.font = FONTSIZESBOLD(34/2);
    [_sellBackView addSubview:_sellCountNameLabel];
    //RMB
    _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_img_rmb_selDetail"]];
    [_sellBackView addSubview:_rmbImageView];
    //销售额（数字）
    _sellCountLabel = [[UILabel alloc] init];
    _sellCountLabel.text = @"0.00";
    _sellCountLabel.textColor = WHITE;
    _sellCountLabel.font = FONTSIZESBOLD(40/2);
    [_sellBackView addSubview:_sellCountLabel];
    //本月销售 今日销售
    NSArray *buttonNameArray = @[@"本月销售",@"今日销售"];
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
//        allButton.layer.masksToBounds = YES;
//        allButton.layer.cornerRadius = 4;
        [allButton setTitle:buttonNameArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:DARKBLUE forState:UIControlStateNormal];
        [allButton setTitleColor:WHITE forState:UIControlStateSelected];
        allButton.titleLabel.font = FONTSIZESBOLD(33/2);
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_monthLabel.mas_bottom);
            make.width.mas_equalTo(172/2);
            make.height.mas_equalTo(63/2);
            make.right.mas_equalTo(-272/2+(i*(172/2)));
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
    //下拉按钮
    [_dragButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_yearLabel.mas_top);
        make.left.mas_equalTo(_yearLabel.mas_left);
        make.bottom.mas_equalTo(_monthLabel.mas_bottom);
        make.width.mas_equalTo(132/2);
    }];
    //销售图片
    [_walletImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0).with.offset(-5);
        make.left.mas_equalTo(0);
    }];
    //销售额
    [_sellCountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(0);
        make.left.mas_equalTo(_walletImageView.mas_right).with.offset(14/2);
    }];
    //RMB
    [_rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_walletImageView.mas_bottom);
        make.left.mas_equalTo(_sellCountNameLabel.mas_right).with.offset(26/2);
    }];
    //销售额(数字)
    [_sellCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(0);
        make.left.mas_equalTo(_rmbImageView.mas_right).with.offset(14/2);
    }];
    //销售额背景
    [_sellBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(_monthLabel.mas_bottom);
        make.left.mas_equalTo(_walletImageView.mas_left);
        make.right.mas_equalTo(_sellCountLabel.mas_right);
    }];

}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(UIButton *)button{
    if(button == _backButton){
        self.stringBlock(@"后退");
    }else if (button == _dragButton){
        self.stringBlock(@"选择月份");
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
        postNameString = @"TTCSellDetailMonthBarDetail";
    }else{
        postNameString = @"TTCSellDetailMonthBarChart";
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:postNameString object:self userInfo:nil];
}

#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//设置标题
- (void)loadSellDetailMonthHeaderLabel:(NSString *)title{
    _titleLabel.text = title;
}
//设置年、月
- (void)loadYearTitle:(NSString *)year monthTitle:(NSString *)month{
    _yearLabel.text = year;
    _monthLabel.text = [NSString stringWithFormat:@"%@月",month];
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
//更新销售额(月)
- (void)loadMonthSellCount:(NSString *)count{
    _sellCountLabel.text = count;
}
//是否隐藏本月销售和今日销售
- (void)hideMonthAndDaySell:(BOOL)isHide{
    for (int i = 0; i < 2; i ++) {
        UIButton *allButton = (UIButton *)[self viewWithTag:i+kButtonTag];
        allButton.hidden = isHide;
    }
}
@end
