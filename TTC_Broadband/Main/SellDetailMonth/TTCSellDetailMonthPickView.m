//
//  TTCSellDetailMonthPickView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailMonthPickView.h"

@interface TTCSellDetailMonthPickView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSMutableArray *yearArray;
@property (strong, nonatomic) NSMutableArray *monthArray;
@property (assign, nonatomic) int curYearIndex;
@property (assign, nonatomic) int curMonthIndex;
@property (strong, nonatomic) NSString *selectedYearString;
@property (strong, nonatomic) NSString *selectedMonthString;
@end
@implementation TTCSellDetailMonthPickView
#pragma mark - Init methods
- (void)initData{
    //获取当前年、月
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    _selectedYearString = [NSString stringWithFormat:@"%d",year];
    _selectedMonthString = [NSString stringWithFormat:@"%02d",month];
    //年数组
    _yearArray = [NSMutableArray array];
    for (int i = 1990; i <= year; i ++) {
        if (i == year) {
            _curYearIndex = i-1990;
        }
        [_yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    //月数组
    _monthArray = [NSMutableArray array];
    for (int i = 1; i <= 12; i ++) {
        if (i == month) {
            _curMonthIndex = i-1;
        }
        [_monthArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
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
    _isPackUp = YES;
    //背景
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    [self addSubview:_backView];
    //选择器
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.backgroundColor = WHITE;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickerView selectRow:_curYearIndex inComponent:0 animated:NO];
    [_pickerView selectRow:_curMonthIndex inComponent:2 animated:NO];
    [_backView addSubview:_pickerView];
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    //选择器
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
}
#pragma mark - Event response
#pragma mark - Network request
#pragma mark - Protocol methods
//UIPickerViewDataSource Method
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _yearArray.count;
            break;
        case 2:
            return _monthArray.count;
            break;
        default:
            return 1;
            break;
    }
    return 10;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _yearArray[row];
            break;
        case 1:
            return @"年";
            break;

        case 2:
            return _monthArray[row];
            break;
        case 3:
            return @"月";
            break;
        default:
            return @"";
            break;
    }
}
//UIPickerViewDelegate Method
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _selectedYearString =  _yearArray[row];
    }
    if (component == 2) {
        _selectedMonthString = _monthArray[row];
    }
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"选择年月" object:self userInfo:@{@"年":_selectedYearString,@"月":_selectedMonthString}];
}
#pragma mark - Other methods
//弹出PickerView
- (void)showPickerView{
    [UIView animateWithDuration:0.25 animations:^{
        [_pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_backView.mas_bottom).with.offset(-200);
        }];
        [self layoutIfNeeded];
    }];
}
//收回PickerView
- (void)packUpPickerView{
    [UIView animateWithDuration:0.25 animations:^{
    [_pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_bottom);
    }];
    [self layoutIfNeeded];
    }];
}
@end
