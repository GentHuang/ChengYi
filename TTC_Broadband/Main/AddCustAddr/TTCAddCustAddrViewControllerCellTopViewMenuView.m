//
//  TTCAddCustAddrViewControllerCellTopViewMenuView.m
//  TTC_Broadband
//
//  Created by apple on 16/3/10.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCAddCustAddrViewControllerCellTopViewMenuView.h"

#define KLabel_W 120
//mac
#define kButtonWidth 120
#define kButtonHeight 25
#define kButtonTag 1800
@interface TTCAddCustAddrViewControllerCellTopViewMenuView()

@property (assign, nonatomic) BOOL isShowMenu;
@property (assign, nonatomic) int selectedIndex;
@property (strong, nonatomic)  UIView *backView;
@property (assign, nonatomic) int buttonCount;
@property (strong, nonatomic) UILabel *UplinLbale;

@end


@implementation TTCAddCustAddrViewControllerCellTopViewMenuView
-(instancetype)init {
    if (self = [super init]) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
//    self.backgroundColor =[UIColor whiteColor];
    self.hidden = YES;
    self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.6];
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
    }];
    _UplinLbale = [[UILabel alloc]init];
    _UplinLbale.backgroundColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:0.9];
    [self addSubview:_UplinLbale];
    [_UplinLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
    }];
}
#pragma mark 换成button
//刷新
- (void)loadWithDataArray:(NSArray *)dataArray{
    //标题个数
    //先清空数据
    [self deleteAllButton];
//    UIButton *defaultButton;
    _buttonCount = (int)dataArray.count;
    UIView *lastView;
    for (int i = 0,j = 0; i < dataArray.count; i ++,j++) {
        if (j==5) {
            j = 0;
        }
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [allButton setTag:(i+kButtonTag)];
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [allButton setTitle:dataArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        allButton.layer.borderColor = [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] CGColor];
        allButton.layer.borderWidth = 0.6;
        allButton.layer.masksToBounds = YES;
        allButton.layer.cornerRadius = 5;
        allButton.titleLabel.font = FONTSIZES(12);
        [_backView addSubview:allButton];
        if (i < 5) {
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).with.offset(50/2);
                make.left.mas_equalTo(self.mas_left).with.offset(j*(kButtonWidth+49/2)+30);
                make.width.mas_equalTo(kButtonWidth);
            }];
            lastView = allButton;
            if (i==0) {
//                defaultButton = allButton;
            }
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).with.offset(40/2);
                make.left.mas_equalTo(self.mas_left).with.offset(j*(kButtonWidth+49/2)+30);
                make.width.mas_equalTo(kButtonWidth);
            }];
        }
        if (j == 4 || i == (dataArray.count-1)) {
            lastView = allButton;
        }
    }
    //默认选择
    
//    [self buttonPressed:defaultButton];
    //
//    self.hidden = YES;
    [self packUpList];
}
//删除所有按钮
- (void)deleteAllButton{
    if (_buttonCount > 0) {
        for (int i = 0; i < _buttonCount; i ++) {
            UIButton *allButton = (UIButton *)[self viewWithTag:(i+kButtonTag)];
            [allButton removeFromSuperview];
        }
    }
}
#pragma Event Respose
- (void)buttonPressed:(UIButton*)button {
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:i+kButtonTag];
        button.selected = NO;
        button.backgroundColor = WHITE;
        button.layer.borderColor = [[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] CGColor];
    }
    button.selected = YES;
    button.backgroundColor =[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1];
    button.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1]CGColor];
    self.selectedIndex = (int)(button.tag-kButtonTag);
    
    self.stringBlock(button.titleLabel.text);
    [self packUpList];
    //发出通知视图已经隐藏
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Menu隐藏" object:self];
}
#pragma mark - Event response
- (void)tapgesture {
    self.hidden = YES;
    [self packUpList];
}
//弹出菜单
- (void)dragDownList {
    if (_isShowMenu==NO) {
        _isShowMenu = YES;
        self.hidden = NO;
        [self.superview bringSubviewToFront:self];
        [UIView animateWithDuration:0.4 animations:^{
            [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(300);
            }];
            [_UplinLbale mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
            }];
            if (_buttonCount > 0) {
                for (int i = 0; i < _buttonCount; i ++) {
                    UIButton *allButton = (UIButton *)[_backView viewWithTag:(i+kButtonTag)];
                    allButton.hidden= NO;
                    [allButton mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(kButtonHeight);
                    }];
                }
            }
            [self layoutIfNeeded];
        }];
    }
}
//隐藏菜单
- (void)packUpList {
    _isShowMenu = NO;
    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [_UplinLbale mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    if (_buttonCount > 0) {
        for (int i = 0; i < _buttonCount; i ++) {
            UIButton *allButton = (UIButton *)[_backView viewWithTag:(i+kButtonTag)];
            [allButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }
    }
    //选中隐藏
    self.hidden = YES;
}
@end
