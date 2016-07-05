//
//  TTCProductLibTTopView.m
//  TTC_Broadband
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCProductLibTTopView.h"
#import "TTCCustonButton.h"
//Macro
#define kButtonWidth (768/5)
#define kButtonHeight 264/2
#define kButtonTag 23000
@interface TTCProductLibTTopView()
@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) int selectedIndex;
@end

@implementation TTCProductLibTTopView
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
    self.backgroundColor = WHITE;
    self.selectedIndex = 0;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    //背景
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = RED;
    [self addSubview:_backView];
}
- (void)setSubViewLayout{
    //背景
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(TTCCustonButton *)button{
    self.selectedIndex = (int)(button.tag - kButtonTag);
    for (UIButton *button in _backView.subviews){
        button.selected = NO;
        button.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    }
    button.selected = YES;
    button.backgroundColor = WHITE;
}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//刷新产品分类
- (void)loadProductTypeWithArray:(NSArray *)dataArray titleImage:(NSArray*)imageArray{
    //去除前面的APP字段
    NSMutableArray *NameArray = [NSMutableArray array];
    for (int i = 0; i<dataArray.count; i++) {
        NSString *string = [dataArray[i] substringFromIndex:3];
        [NameArray addObject:string];
    }
    //添加热销
    [NameArray addObject:@"热销产品"];
    UIView *lastView;
    for (int i = 0; i < NameArray.count; i ++) {
        TTCCustonButton *allButton = [TTCCustonButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        [allButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        allButton.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        allButton.layer.borderColor = [LINEGRAY CGColor];
        allButton.layer.borderWidth = 0.5;
        [allButton setTitle:NameArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor colorWithRed:70/255.0 green:168/255.0 blue:238/255.0 alpha:1] forState:UIControlStateSelected];
        [allButton setTitleColor:[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        if (i<4) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:IMGURL,imageArray[i]]]]];
            [allButton setImage:image forState:UIControlStateNormal];
        }else{
             [allButton setImage:[UIImage imageNamed:@"colums_hot"] forState:UIControlStateNormal];
        }
        //---------add------
        allButton.selected = NO;
        allButton.titleLabel.font = FONTSIZESBOLD(33/2);
        [_backView addSubview:allButton];
        if (i == 0) {
            //--add--默认选中
            allButton.selected =YES;
            allButton.backgroundColor = WHITE;
//            [allButton setBackgroundImage:[UIImage imageNamed:@"first_btn_sel"] forState:UIControlStateSelected];
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(kButtonWidth);
                make.left.mas_equalTo(0);
            }];
        }else{
            [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(kButtonWidth);
                make.left.mas_equalTo(lastView.mas_right).with.offset(-0.5);
            }];
        }
        lastView = allButton;
    }
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lastView.mas_right);
    }];
}

@end
