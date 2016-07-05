//
//  TTCUserAccountResultSearchView.m
//  TTC_Broadband
//
//  Created by apple on 16/4/11.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserAccountResultSearchView.h"
#define KLabelTag 
@interface TTCUserAccountResultSearchView()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) NSArray *dataArray;
//取消按钮
@property (strong, nonatomic) UIButton *cancelButton;
@end

@implementation TTCUserAccountResultSearchView

- (instancetype)init {
    if (self = [super init]) {
        [self creatUI];
        _dataArray = @[@"BOSS受理:",@"订单状态:",@"订单编号:",@"操作时间:"];
    }
    return self;
}

- (void)creatUI {
    self.backgroundColor = self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(456);
        make.height.mas_equalTo(636/2);
    }];
    //取消按钮
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cancelButton];
    //    _cancelButton.backgroundColor = ORANGE;
    [_cancelButton setImage:[UIImage imageNamed:@"LayerClose"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelBuyView) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView.mas_top);
        make.centerX.equalTo(_backView.mas_right);
        make.width.height.mas_equalTo(50);
    }];
}
//刷新数据
- (void)reloadDataWithArray:(NSArray*)array {
    
    for (int i = 0; i <array.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.backgroundColor = RED;
        [_backView addSubview:titleLabel];
        titleLabel.text = [NSString stringWithFormat:@"%@%@",_dataArray[i],array[i]];
        titleLabel.font = FONTSIZES(15);
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView.mas_top).offset(10+i*30);
            make.left.equalTo(self.backView.mas_left).offset(20);
        }];
    }
}
//手势代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
      NSLog(@"==== %@",touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;
    }
  
    return YES;
}
- (void)cancelBuyView{
    self.hidden= YES;
}
- (void)tapPress {
    self.hidden= YES;
}



@end
