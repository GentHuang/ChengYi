//
//  TTCSellCountViewCellBusinessView.m
//  TTC_Broadband
//
//  Created by apple on 16/4/7.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCSellCountViewCellBusinessView.h"
#define kButtonTag 20000
#define kButtonWidth (513/2)
#define kLabelTag 33000
@interface TTCSellCountViewCellBusinessView()
@property (strong, nonatomic) UILabel *broadLabel;
@property (strong, nonatomic) UILabel *figureLabel;
@property (strong, nonatomic) UILabel *interactLabel;
@property (strong, nonatomic) NSArray *BusinessArray;
@end
@implementation TTCSellCountViewCellBusinessView
- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    //创建按钮
    //    NSArray *imageArray = @[[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage new]];
    NSArray *titleArray = @[@"产品数字",@"互动产品",@"宽带业务"];
    for (int i = 0; i < titleArray.count; i ++) {
        //按钮
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        allButton.tag = i+kButtonTag;
        allButton.backgroundColor = WHITE;
        allButton.layer.borderColor = [LINEGRAY CGColor];
        allButton.layer.borderWidth = 0.5;
        [allButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        allButton.titleLabel.font = FONTSIZESBOLD(40/2);
        [allButton setTitleEdgeInsets:UIEdgeInsetsMake(-40, 0, 0, 0)];//40  top
        [self addSubview:allButton];
        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kButtonWidth);
            make.left.mas_equalTo(i*kButtonWidth-0.5);
        }];
       
        //金额标题
        UILabel *allLabel = [[UILabel alloc] init];
        allLabel.tag = i + kLabelTag;
        allLabel.userInteractionEnabled = NO;
        allLabel.textColor = ORANGE;
        allLabel.textAlignment = NSTextAlignmentCenter;
        allLabel.font = FONTSIZESBOLD(50/2);
        [allButton addSubview:allLabel];
        [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-45/2);//
            make.centerX.mas_equalTo(allButton.mas_centerX);
        }];
         //rmb
        UIImageView *rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pro_img_rmb"]];
        rmbImageView.userInteractionEnabled = NO;
        [allButton addSubview:rmbImageView];
        [rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(allLabel.mas_bottom).with.offset(-8);
            make.right.mas_equalTo(allLabel.mas_left).with.offset(-20/2);
        }];
    }
}

#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//载入顶部数据
//刷新数据
- (void)loadDataWithArray:(NSArray*)array{
    for (int i = 0; i<array.count; i++) {
        UILabel *label = (UILabel*)[self viewWithTag:kLabelTag+i];
        label.text = array[i];
        NSLog(@"%@",array[i]);
    }
}
@end
