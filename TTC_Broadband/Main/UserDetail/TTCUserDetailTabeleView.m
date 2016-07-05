//
//  TTCUserDetailTabeleView.m
//  TTC_Broadband
//
//  Created by apple on 16/5/25.
//  Copyright (c) 2016年 TTC. All rights reserved.
//

#import "TTCUserDetailTabeleView.h"
#import "TTCUserDetailTableViewCell.h"
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"

@interface TTCUserDetailTabeleView()<UITableViewDataSource,UITableViewDelegate>
//列表
@property (strong, nonatomic) UITableView *tableView;
//数据源
@property (strong, nonatomic) NSArray *dataArray;
//self高度
@property (assign, nonatomic) CGFloat height;
@end

@implementation TTCUserDetailTabeleView

- (instancetype)init {
    if (self = [super init]) {
        
        [self CreateUI];
    }
    return self;
}
- (void)CreateUI {
    _tableView =[[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TTCUserDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _tableView.scrollEnabled = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_dataArray.count>0 )return _dataArray.count;
    else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110/2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCUserDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell ==nil) {
        cell = [[TTCUserDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    TTCUserLocateViewControllerUserProductOutputProsModel *prosModel =(TTCUserLocateViewControllerUserProductOutputProsModel*)_dataArray[indexPath.row];
    [cell loadDetailSetWithModeString:prosModel];
    return cell;
}

//刷新数据
- (void)loadDataWithArray:(NSArray*)dataArray {
    _dataArray = dataArray;
    [_tableView reloadData];
}

@end
