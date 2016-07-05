//
//  TTCSellCountViewCellNewPieView.m
//  TTC_Broadband
//
//  Created by apple on 16/4/18.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCSellCountViewCellNewPieView.h"
#import "XYPieChart.h"
@interface TTCSellCountViewCellNewPieView()<XYPieChartDataSource,XYPieChartDelegate>

@property (strong, nonatomic) NSArray *titleNameArray;
@property (strong, nonatomic) XYPieChart *PieChart;
//颜色数组
@property (strong, nonatomic) NSArray *sliceColors;
@property (strong, nonatomic) NSMutableArray *slices;
//临时数据
@property (strong, nonatomic) NSMutableArray *tempArray;
@end

@implementation TTCSellCountViewCellNewPieView
- (NSArray*)tempArray {
    if (!_tempArray) {
        _tempArray  =[NSMutableArray array];
    }
    return _tempArray;
}

- (void)initData{
    //titleNameArray
    _titleNameArray = @[@"产品数字",@"互动产品",@"宽带业务"];
}
- (instancetype)init{
    if (self = [super init]) {
        [self initData];
        [self createUI];
    }
    return self;
}
#pragma mark - Life circle
#pragma mark - Getters and setters
- (void)createUI{
    self.backgroundColor = WHITE;
    //饼状图设置
    _PieChart = [[XYPieChart alloc]initWithFrame:CGRectMake(SCREEN_MAX_WIDTH/2-150,25, 300, 300) Center:CGPointMake(SCREEN_MAX_WIDTH/2, 300/2) Radius:150];
    [self addSubview:_PieChart];
    [self.PieChart setDelegate:self];
    [self.PieChart setDataSource:self];
    [self.PieChart setPieCenter:CGPointMake(150, 150)];
    [self.PieChart setShowPercentage:NO];
    [self.PieChart setLabelColor:[UIColor blackColor]];
    [self.PieChart setLabelRadius:110];
    [self.PieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:0.1]];
//    self.PieChart.backgroundColor = [UIColor orangeColor];
    //转盘内模块的颜色
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:145/256.0 green:253/256.0 blue:254/256.0 alpha:1],
                       [UIColor colorWithRed:254/256.0 green:210/256.0 blue:146/256.0 alpha:1],
                       [UIColor colorWithRed:199/256.0 green:250/256.0 blue:147/256.0 alpha:1],
                        nil];
    //中心的透明图层
    //内层图案
    UIImageView * InnerimageView = [[UIImageView alloc] init];
//    InnerimageView.center  = CGPointMake(SCREEN_MAX_WIDTH/2, 300/2);
    InnerimageView.center  = CGPointMake(150, 150);
    InnerimageView.bounds =CGRectMake(0, 0, 140,140);
    InnerimageView.layer.masksToBounds = YES;
    InnerimageView.layer.cornerRadius = 70;
    InnerimageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:InnerimageView];
    [_PieChart addSubview:InnerimageView];
    InnerimageView.userInteractionEnabled = NO;
    
    //外层图案
    UIImageView * OuterimageView = [[UIImageView alloc] init];
    OuterimageView.center  = CGPointMake(150, 150);

    OuterimageView.bounds = CGRectMake(0, 0, 180, 180);
    OuterimageView.userInteractionEnabled = NO;
    OuterimageView.layer.masksToBounds = YES;
    OuterimageView.layer.cornerRadius = 90;
    OuterimageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    [_PieChart addSubview:OuterimageView];

}
#pragma mark - data 
//加载信息
- (void)loadPiePercentWithArray:(NSArray *)dataArray{
    self.slices = [NSMutableArray array];
    float sum = 0;
    for (int i = 0; i<dataArray.count; i++) {
       sum += [dataArray[i] intValue];
    }
    for (int i = 0; i<dataArray.count; i++) {
        NSString *contentString =[NSString stringWithFormat:@"%.02f",[dataArray[i] intValue]/sum*100];
        [self.slices addObject:contentString];
    }
//
//    [self.slices addObject:@"22"];
//    [self.slices addObject:@"22"];
//    [self.slices addObject:@"22"];

    self.tempArray = [NSMutableArray arrayWithArray:dataArray];
    [self.PieChart reloadData];
}
#pragma mark - Event response
////点击
//- (void)handleTap:(UITapGestureRecognizer*)tap{
//    [self.slices removeAllObjects];
//    [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(reloadDataAgain) userInfo:nil repeats:NO];
//}
////点击再次刷新数据
//- (void)reloadDataAgain{
//    if(self.slices.count==0){
//        self.slices = self.tempArray;
//        [self.PieChart reloadData];
//    }
//}
#pragma mark - Network request
#pragma mark - Protocol methods
#pragma mark - Other methods

#pragma mark  Pie delegate Meothd
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    self.PieChart.titleArray = _titleNameArray;
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] floatValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}


@end
