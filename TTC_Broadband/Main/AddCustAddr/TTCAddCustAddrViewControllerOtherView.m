//
//  TTCAddCustAddrViewControllerOtherView.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/11.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCAddCustAddrViewControllerOtherView.h"
//Macro
#define kLabelTag 90000
@interface TTCAddCustAddrViewControllerOtherView()
@property (strong, nonatomic) NSArray *titleNameArray;
@end

@implementation TTCAddCustAddrViewControllerOtherView
#pragma mark - Init methods
- (void)initData{
    //标题数组
    _titleNameArray = @[@"住宅地址",@"片区",@"可安装业务",@"住宅状态"];
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
    UIView *lastView;
    for (int i = 0; i < _titleNameArray.count; i ++) {
        //住宅地址 片区 可安装业务 住宅状态
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.tag = i + kLabelTag;
        titleLabel.text = _titleNameArray[i];
        titleLabel.textColor = LIGHTDARK;
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        if (i == 0) {
            //住宅地址
            titleLabel.font = FONTSIZESBOLD(32/2);
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(33/2);
                make.left.mas_equalTo(60/2);
            }];
        }else{
            //片区 可安装业务 住宅状态
            titleLabel.font = FONTSIZESBOLD(30/2);
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).with.offset(15);
                make.left.mas_equalTo(60/2);
            }];
        }
        lastView = titleLabel;
    }
}
- (void)setSubViewLayout{
    
}
#pragma mark - Event response
#pragma mark - Data request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载住宅地址 片区 可安装业务 住宅状态
- (void)loadAddress:(NSString *)addressString area:(NSString *)areaString business:(NSString *)businessString status:(NSString *)statusString{
    for (int i = 0; i < _titleNameArray.count; i ++) {
        switch (i) {
            case 0:{
                //住宅地址
                UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
                allLabel.text = [NSString stringWithFormat:@"住宅地址:%@",addressString];
            }
                break;
            case 1:{
                //片区
                UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
                allLabel.text = [NSString stringWithFormat:@"片区:%@",areaString];
            }
                break;
            case 2:{
                //可安装业务
                UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
                allLabel.text = [NSString stringWithFormat:@"可安装业务:%@",businessString];
            }
                break;
            case 3:{
                //住宅状态
                UILabel *allLabel = (UILabel *)[self viewWithTag:i+kLabelTag];
                allLabel.text = [NSString stringWithFormat:@"住宅状态:%@",statusString];
            }
                break;
            default:
                break;
        }
    }
}
@end
