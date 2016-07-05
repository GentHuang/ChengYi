//
//  TTCSellDetailDayChartView.m
//  TTC_Broadband
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCSellDetailDayChartView.h"
//Tool
#import "MagicPieLayer.h"
#import "MyPieElement.h"

@interface TTCSellDetailDayChartView()
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) NSArray *titleNameArray;
@end

@implementation TTCSellDetailDayChartView
#pragma mark - Init methods
+ (Class)layerClass{
    return [PieLayer class];
}
- (void)initData{
    //titleNameArray
    _titleNameArray = @[@"数字业务",@"模拟业务",@"宽带业务",@"互动业务",@"智能业务"];
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
    self.backgroundColor = WHITE;
    //业务类型
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.text = @"业务类型";
    _typeLabel.textColor = LIGHTDARK;
    _typeLabel.font = FONTSIZESBOLD(33/2);
    [self addSubview:_typeLabel];
    //下划线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    
    //饼状图设置
    //外圆直径
    self.layer.maxRadius = 400/4;
    //内圆直径
    self.layer.minRadius = 0;
    //点击动画时间
    self.layer.animationDuration = 1;
    //总是显示标题
    self.layer.showTitles = ShowTitlesAlways;
    //设置标题字体
    self.layer.font = FONTSIZESBOLD(30/2);
    //开始的角度
    self.layer.startAngle = 0;
    //高清显示
    if ([self.layer.self respondsToSelector:@selector(setContentsScale:)]){
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
    }
    //手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}
- (void)setSubViewLayout{
    //业务类型
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40/2);
        make.left.mas_equalTo(60/2);
    }];
    //下划线
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_typeLabel.mas_bottom).with.offset(25/2);
        make.height.mas_equalTo(0.7);
    }];
}
#pragma mark - Event response
//点击
- (void)handleTap:(UITapGestureRecognizer*)tap{
    if(tap.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint pos = [tap locationInView:tap.view];
    PieElement* tappedElem = [self.layer pieElemInPoint:pos];
    if(!tappedElem)
        return;
    
    if(tappedElem.centrOffset > 0)
        tappedElem = nil;
    [PieElement animateChanges:^{
        for(PieElement* elem in self.layer.values){
            elem.centrOffset = tappedElem==elem? 20 : 0;
        }
    }];
}

#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods
//加载标题名
- (void)loadPiePercentWithArray:(NSArray *)dataArray{
    //清空旧数据
    if (self.layer.values.count > 0) {
        for(PieElement* elem in self.layer.values){
            [self.layer deleteValues:@[elem] animated:NO];
        }
    }
    //设置标题Title和饼状图初始化
    int numberOfUnZero = (int)dataArray.count;
    int UnZeroData = 0;
    for(int i = 0; i < dataArray.count; i++){
        if ([dataArray[i] integerValue] != 0) {
            MyPieElement* elem = [MyPieElement pieElementWithValue:0 color:[self colorWithIndex:i]];
            elem.title = _titleNameArray[i];
            [self.layer addValues:@[elem] animated:NO];
            //可以记录不为0的值
            UnZeroData = i;
        }else{
            numberOfUnZero --;
        }
    }
    //若只有一个值
    if (numberOfUnZero == 1) {
        //清除旧数据
        for(PieElement* elem in self.layer.values){
            [self.layer deleteValues:@[elem] animated:NO];
        }
        //创建新饼图
        MyPieElement* elem = [MyPieElement pieElementWithValue:0 color:[self colorWithIndex:UnZeroData]];
        elem.title = _titleNameArray[UnZeroData];
        [self.layer addValues:@[elem] animated:NO];
        //设置颜色分布
        [PieElement animateChanges:^{
            for(PieElement *elem in self.layer.values){
                elem.val = [dataArray[UnZeroData] intValue];
            }
        }];
    }else{
        //设置颜色分布
        [PieElement animateChanges:^{
            __block int j = 0;
            for(PieElement *elem in self.layer.values){
                if ([dataArray[j] integerValue] != 0) {
                    elem.val = [dataArray[j] floatValue];
                }
                j ++;
            }
        }];
    }
    //设置标题
    self.layer.transformTitleBlock = ^(PieElement* elem){
        return [(MyPieElement*)elem title];
    };
}
//颜色
- (UIColor*)colorWithIndex:(int)index{
    UIColor *selectedColor;
    switch (index) {
        case 0:
            selectedColor = [UIColor colorWithRed:216/256.0 green:122/256.0 blue:128/256.0 alpha:1];
            break;
        case 1:
            selectedColor = [UIColor colorWithRed:46/256.0 green:199/256.0 blue:201/256.0 alpha:1];
            break;
        case 2:
            selectedColor = [UIColor colorWithRed:182/256.0 green:162/256.0 blue:222/256.0 alpha:1];
            break;
        case 3:
            selectedColor = [UIColor colorWithRed:90/256.0 green:177/256.0 blue:239/256.0 alpha:1];
            break;
        case 4:
            selectedColor = [UIColor colorWithRed:255/256.0 green:185/256.0 blue:128/256.0 alpha:1];
            break;
        default:
            return RED;
            break;
    }
    return selectedColor;
}
@end
