//
//  TTCShoppingCarViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCShoppingCarViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayViewController.h"
//View
#import "TTCShoppingCarCell.h"
//ViewModel
#import "TTCShoppingCarViewControllerViewModel.h"
//Model
#import "TTCShoppingCarViewControllerModel.h"
#import "TTCShoppingCarCellFooterView.h"
@interface TTCShoppingCarViewController ()<UITableViewDataSource,UITableViewDelegate,TTCShoppingCarCellDelegate,TTCShoppingCarCellFooterView>
@property (assign, nonatomic) CGFloat allPrice;
@property (assign, nonatomic) int allCount;
@property (strong, nonatomic) NSString *keyno;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTCShoppingCarViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) MBProgressHUD *progressHud;
// 底部全选、结算
@property (strong, nonatomic) TTCShoppingCarCellFooterView *viewFooter;
@property (strong, nonatomic) NSMutableArray *arrayFlag;

@end
@implementation TTCShoppingCarViewController
#pragma mark - Init methods
- (void)initData{
    
    //vcViewModel
    _vcViewModel = [[TTCShoppingCarViewControllerViewModel alloc] init];
    // 标记数组，标记已选的数组
    _arrayFlag   = [NSMutableArray array];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    [self notificationRecieve];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setNavigationBar];
    //取消出现下拉
//    [_tableView.mj_header beginRefreshing];
    [self getData];
    //显示tab
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
    [tab showBar];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    
    _viewFooter = [[TTCShoppingCarCellFooterView alloc]init];
    _viewFooter.layer.borderColor = [UIColor grayColor].CGColor;
    _viewFooter.layer.borderWidth = 0.5;
    _viewFooter.footerViewdelegate = self;
    [self.view addSubview:_viewFooter];
    __block TTCShoppingCarViewController *selfVC = self;
    self.view.backgroundColor = LIGHTGRAY;
    //tableVIew
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LIGHTGRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCShoppingCarCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [selfVC getData];
    }];
    //等待加载
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHud.hidden = YES;
    [_progressHud show:NO];
    [self.view addSubview:_progressHud];
    
}

- (void)setSubViewLayout{
    __weak __typeof (&*self)weaks = self;
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(_viewFooter.mas_top).with.offset(0);
    }];
    
    [_viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(64);
        make.left.right.mas_equalTo(weaks.view);
        make.bottom.mas_equalTo(-TAB_HEIGHT);
    }];
}
- (void)setNavigationBar{
    
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kAccountInfoType];
    [nvc canGoBack:NO];
    [nvc loadHeaderTitle:@"购物车"];
}
#pragma mark - Event response
//接收通知
- (void)notificationRecieve{
    // 接收用户修改后的商品数量
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodsCountNotifiResponse:) name:@"TTCShoppingCarCellOtherView" object:nil];
    //立即付款
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationResponse:) name:@"TTCShoppingCarCellFooterView" object:nil];
}
// 修改后的商品数量通知
- (void) goodsCountNotifiResponse:(NSNotification *)notific{
    
    NSDictionary *dic = notific.userInfo;
    NSString *goodsName = dic[@"name"];
    NSString *goodsCount = dic[@"count"];
    if ([notific.name isEqualToString:@"TTCShoppingCarCellOtherView"]) {
        // 保存添加的数目到本地数据库
        for (NSInteger i = 0;i <_vcViewModel.dataCarArray.count; i ++) {
            
            TTCShoppingCarViewControllerModel *carModel = _vcViewModel.dataCarArray[i];
            if ([carModel.title isEqualToString:goodsName]) {
                
                carModel.count = goodsCount;
                [[FMDBManager sharedInstace] creatTable:carModel];
                [[FMDBManager sharedInstace] insertAndUpdateModelToDatabase:carModel withCheckNum:3];
            }
        }
    }
    [self getData];
}

//支付通知反馈
- (void)notificationResponse:(NSNotification *)notification{
    __block TTCShoppingCarViewController *selfVC = self;
    __block TTCShoppingCarViewControllerViewModel *selfViewModel = _vcViewModel;
    //立即付款
    if ([notification.name isEqualToString:@"TTCShoppingCarCellFooterView"]) {
        if(_allCount == 0){
            
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"你的购物车是空的哦"
                                                            delegate:nil
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"确定", nil];
            [alView show];
            
        }else{
            
            //购物车立即支付
            [self startLoading];
            
            [_vcViewModel carPayWithArray:_vcViewModel.dataCarArray sucess:^(NSMutableArray *resultArray) {
                //发送订单
                [selfVC stopLoading];
                TTCPayViewController *payVC = [[TTCPayViewController alloc] init];
                payVC.isCarPay = YES;
                payVC.orderDataArray = _vcViewModel.dataOrderArray;
                payVC.carDataArray = selfViewModel.dataCarArray;
                [self.navigationController pushViewController:payVC animated:YES];
            } fail:^(NSError *error) {
                //支付失败
                [selfVC stopLoading];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:selfViewModel.failMSG
                                                                delegate:nil
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
                [alView show];
            }];
        }
    }
}
#pragma mark - Network request
//获取数据
- (void)getData{
    
    __block TTCShoppingCarViewControllerViewModel *selfViewModel = _vcViewModel;
    __block TTCShoppingCarViewController *selfVC = self;
    _allPrice = 0;
    _allCount = 0;
    
    //读取成功回调
    _vcViewModel.dbSuccessBlock = ^(NSMutableArray *stringArray){
        //获取成功回调
        // 首次添加商品
        if (_arrayFlag.count == 0) {
            // 计算总价
           for (TTCShoppingCarViewControllerModel *carModel in selfViewModel.dataCarArray) {
            
              selfVC.allPrice += ([carModel.price floatValue]*[carModel.count intValue]);
              selfVC.allCount ++;
           }
            // 添加标识，为cell提供辨识做准备，默认全选
            if (_vcViewModel.dataCarArray.count > _arrayFlag.count) {
                
                for (NSInteger i = selfVC.arrayFlag.count; i < _vcViewModel.dataCarArray.count; i ++) {
                    
                    [selfVC.arrayFlag addObject:@"1"];
                }
            }
            [selfVC.viewFooter changeAllSelectButtonStatus:YES];
            
            // 添加新的商品
        }else{
            // 新添加默认选择
            if (_vcViewModel.dataCarArray.count > _arrayFlag.count) {
                
                for (NSInteger i = selfVC.arrayFlag.count; i < _vcViewModel.dataCarArray.count; i ++) {
                    
                    [selfVC.arrayFlag addObject:@"1"];
                }
            }
            // 将后添加的商品加入的总价
            for (NSInteger i = 0 ; i < selfVC.arrayFlag.count;i ++) {
                if ([selfVC.arrayFlag[i] isEqualToString:@"1"]&& selfViewModel.dataCarArray.count>0) {//修改 bug
               
                     TTCShoppingCarViewControllerModel *carModel = selfViewModel.dataCarArray[i];
                     selfVC.allPrice += ([carModel.price floatValue]*[carModel.count intValue]);
                }
                selfVC.allCount ++;
            }
            // 改变全选按钮的状态
            if ([selfVC.arrayFlag containsObject:@"0"]){
            
                [selfVC.viewFooter changeAllSelectButtonStatus:NO];
            }
            else{
                
                [selfVC.viewFooter changeAllSelectButtonStatus:YES];
            }
        }
        [selfVC.tableView.mj_header endRefreshing];
        
        [selfVC.tableView reloadData];
       [selfVC.viewFooter loadAllPrice:[NSString stringWithFormat:@"%.2f",selfVC.allPrice]];
    };
    
    [_vcViewModel getDataFromDB];
}
#pragma mark - Protocol methods
//UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else{
        if (_vcViewModel.dataCarArray.count > 0) {
            
            return _vcViewModel.dataCarArray.count;
        }else{
            return 0;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TTCShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellDelegate = self;
    
    if (indexPath.section == 0) {
        
        //顶部模式
        [cell selectCellType:kHeaderType];
        //加载数据
        [cell loadUserName:[CustomerInfo shareInstance].custname sellName:[SellManInfo sharedInstace].name];
    }else if (indexPath.section == 1) {
        // 防止_arraryFlag为空
        if (_arrayFlag.count > 0){
            
            if ([_arrayFlag[indexPath.row] isEqualToString:@"1"]) {
                
                [cell btnStatusWithAllChoseButtonWithFlag:YES];
            }
            else{
                
                [cell btnStatusWithAllChoseButtonWithFlag:NO];
            }
        }
        
        //产品详情
        TTCShoppingCarViewControllerModel *carModel = _vcViewModel.dataCarArray[indexPath.row];
        [cell selectCellType:kOtherType];
        //加载数据
        [cell loadWithImage:carModel.smallimg title:carModel.title contents:carModel.contents price:carModel.price count:carModel.count];
    }
    
    // 获取不同组不同cell的标志位
    [cell selectBtnTagWithIndex:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 320/2;
    }else{
        return 143/2;
    }
}
//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 12/2;
}
//返回表格的编辑模式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        return UITableViewCellEditingStyleDelete;
    }else{
        
        return UITableViewCellEditingStyleNone;
    }
}

//提交编辑表格的执行的方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断编辑模式
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //当表格执行删除操作的时候，删除对应单元格在数据源中的数据
        TTCShoppingCarViewControllerModel *carModel = _vcViewModel.dataCarArray[indexPath.row];
        [_vcViewModel deleteModelWithID:carModel.id_conflict keyno:carModel.keyno];
        
        if (_allPrice > 0 && [_arrayFlag[indexPath.row] isEqualToString:@"1"]) {
            
            _allPrice -= [carModel.price floatValue]*[carModel.count intValue];
        }
        [_vcViewModel.dataCarArray removeObjectAtIndex:(indexPath.row)];
        [_arrayFlag removeObjectAtIndex:indexPath.row];
        //动作执行完，需要更新表格
        _tableView.editing = NO;
        //
        //
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        //
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView reloadData];
        [_viewFooter loadAllPrice:[NSString stringWithFormat:@"%.2f",_allPrice]];
        
        // 改变安全按钮的状态
        if (_vcViewModel.dataCarArray.count == 0) {
            
            [_viewFooter changeAllSelectButtonStatus:NO];
        }else{
            
            if([_arrayFlag containsObject:@"0"]){
                
                [_viewFooter changeAllSelectButtonStatus:NO];
            }
            else{
                [_viewFooter changeAllSelectButtonStatus:YES];
            }
        }
    }
}

// 设置删除按钮的标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

#pragma mark - cell协议的回调,选择按钮改变后
- (void) changeCellBottonSelectedButton:(UIButton *)button{
    
    NSInteger  index = button.tag - 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
    TTCShoppingCarViewControllerModel *carModel = _vcViewModel.dataCarArray[indexPath.row];
        
    if (button.selected) {
        [_arrayFlag replaceObjectAtIndex:indexPath.row withObject:@"1"];
        // 选中某一goods，加上相应货物的总价
        _allPrice += [carModel.price floatValue]*[carModel.count intValue];
        
        if([_arrayFlag containsObject:@"0"]){
            
             [_viewFooter changeAllSelectButtonStatus:NO];
        }else{
            
             [_viewFooter changeAllSelectButtonStatus:YES];
        }
    }
    else{
        // 取消某一goods之后，将总的价格减去取消的价格
        if (_allPrice > 0) {
         
            _allPrice -= [carModel.price floatValue]*[carModel.count intValue];
            if (_allPrice <= 0) {
                _allPrice = 0;
            }
        }
        // 根据单选状态改变全选的状态
        [_arrayFlag replaceObjectAtIndex:indexPath.row withObject:@"0"];
        [_viewFooter changeAllSelectButtonStatus:button.selected];
    }
    [_viewFooter loadAllPrice:[NSString stringWithFormat:@"%.2f",_allPrice]];
}

#pragma mark - footerView,
- (void) btnAllSelectedWithButton:(UIButton *)button{
    
    if (button.selected) {
        
        for (NSInteger i = 0; i < _arrayFlag.count; i++) {
        
            [_arrayFlag replaceObjectAtIndex:i withObject:@"1"];
        }
        [self getData];
    }
    else{
        
        _allPrice = 0;
        for (NSInteger i = 0; i < _arrayFlag.count; i++) {
            
            [_arrayFlag replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    [_tableView reloadData];
    [_viewFooter loadAllPrice:[NSString stringWithFormat:@"%.2f",_allPrice]];
}

#pragma mark - Other methods
//加载等待
- (void)startLoading{
    _progressHud.hidden = NO;
    [_progressHud show:YES];
}
//停止加载
- (void)stopLoading{
    _progressHud.hidden = YES;
    [_progressHud show:NO];
}
@end
