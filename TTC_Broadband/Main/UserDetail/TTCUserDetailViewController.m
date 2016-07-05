//
//  TTCUserDetailViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCUserDetailViewController.h"
#import "TTCProductDetailViewController.h"
#import "TTCNavigationController.h"
#import "TTCAccountInfoViewController.h"
#import "TTCDebtViewController.h"
#import "TTCPrintViewController.h"
#import "TTCModifiedDataViewController.h"
#import "TTCOrderRecordViewController.h"
#import "TTCProductLibViewController.h"
#import "TTCNewUserViewController.h"
#import "TTCUpgradeViewController.h"
//add
#import "TTCUserNewAccountSearchResultController.h"
//View
#import "TTCUserDetailViewCell.h"
#import "TTCUserDetailHeaderView.h"
//CellStatus
#import "TTCUserDetailViewCellStatus.h"
//ViewModel
#import "TTCUserDetailViewControllerViewModel.h"
#import "TTCUserLocateViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksModel.h"
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"
//Macro
#define kBigHeight (267/2)
#define kSmallHeight (110/2)
@interface TTCUserDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) TTCUserLocateViewControllerViewModel *locateViewModel;
@property (strong, nonatomic) TTCUserDetailViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *cellStatusArray;

@end
@implementation TTCUserDetailViewController
#pragma mark - Init methods
- (void)initData{
    //    //客户信息
    //    CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    //    //客户数据
    //    _allProductArray = customerInfo.allProductArray;
    //    _allAccountInfoArray = customerInfo.allBalanceArray;
    //    _allServsArray = customerInfo.allServsArray;
    //    _allPrintArray = customerInfo.allPrintInfoArray;
    //    _addressListArray = customerInfo.allAddrsArray;
    //vcViewModel
    _vcViewModel = [[TTCUserDetailViewControllerViewModel alloc] init];
    //下拉ViewModel
    _locateViewModel = [[TTCUserLocateViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self SetNavigationBar];
    [_tableView.mj_header beginRefreshing];
//    //隐藏tab
//    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
//    TTCTabbarController *tab =(TTCTabbarController*) nvc.tabBarController;
//    [tab hideBar];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_tableView.mj_header endRefreshing];

}
- (void)dealloc {
    //销毁通知
    NSLog(@"对象呗销毁了~~~~");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    __block TTCUserDetailViewController *selfVC = self;
    self.view.backgroundColor = LIGHTGRAY;
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LIGHTGRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [_tableView registerClass:[TTCUserDetailViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfVC getHeaderData];
    }];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationRespons:) name:@"续订" object:nil];
}
- (void)setSubViewLayout{
    __weak typeof(self)weakSelf = self;
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_USERDEL-20);
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
}
- (void)SetNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kUserDetailType];
    [nvc loadHeaderTitle:@"客户详情"];
    //加载数据
    CustomerInfo *customer = [CustomerInfo shareInstance];
    [nvc loadClientInformationWithCustid:customer.custid markno:customer.markno phone:customer.mobile addr:customer.addr name:customer.custname];
}
#pragma mark - Event response
//点击按钮
- (void)buttonPressed:(NSString *)string{
    int selectedIndes = [string intValue];
    switch (selectedIndes) {
        case 0:{
            //余额
            TTCAccountInfoViewController *accountVC = [[TTCAccountInfoViewController alloc] init];
            accountVC.allAccountInfoArray = self.allAccountInfoArray;
            [self.navigationController pushViewController:accountVC animated:YES];
        }
            break;
        case 1:{
            //欠费
            TTCDebtViewController *debtVC = [[TTCDebtViewController alloc] init];
            debtVC.allServsArray = self.allServsArray;
            [self.navigationController pushViewController:debtVC animated:YES];
        }
            break;
        case 2:{
            //未开票
            if(_allPrintArray.count > 0){
                TTCPrintViewController *printVC = [[TTCPrintViewController alloc] init];
                [self.navigationController pushViewController:printVC animated:YES];
            }else{
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前客户没有需要打印的发票哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alView show];
            }
        }
            break;
        case 3:{
            NSLog(@"功能为空");
        }
            break;
        default:
            break;
    }
}
//第一种模式点击
- (void)firstButtonPressed:(NSString *)string{
    int selectedIndes = [string intValue];
    switch (selectedIndes) {
        case 0:{
            //产品订购
            TTCProductLibViewController *productLibVC = [[TTCProductLibViewController alloc] init];
            productLibVC.canGoBack = YES;
            [self.navigationController pushViewController:productLibVC animated:YES];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TTCProductLibViewController" object:self userInfo:@{@"type":@"1"}];
        }
            break;
        case 1:{
            //修改资料
            TTCModifiedDataViewController *modifiedDataVC = [[TTCModifiedDataViewController alloc] init];
            [self.navigationController pushViewController:modifiedDataVC animated:YES];
        }
            break;
        case 2:{
            //订单记录
            TTCOrderRecordViewController *orderRecordVC = [[TTCOrderRecordViewController alloc] init];
            orderRecordVC.isDetail = NO;
            orderRecordVC.canLeave = YES;
            [self.navigationController pushViewController:orderRecordVC animated:YES];
        }
            break;
        case 3:{
            //开户
            TTCNewUserViewController *newUserVC = [[TTCNewUserViewController alloc] init];
            CustomerInfo *customer = [CustomerInfo shareInstance];
            newUserVC.broadAccountString = customer.markno;
            [self.navigationController pushViewController:newUserVC animated:YES];
        }
            break;
        case 4:{
            //开户结果查询
//            _AccountView.hidden = NO;
            TTCUserNewAccountSearchResultController *AccountResultVC = [[TTCUserNewAccountSearchResultController alloc]init];
            [self.navigationController pushViewController:AccountResultVC animated:YES];
        }
            break;
    
        default:
            break;
    }
}
//续订按钮
- (void)buyButtonPressedWithPcode:(NSString *)pcode permark:(NSString *)permark keyno:(NSString *)keyno{
    TTCProductDetailViewController *proDetailVC = [[TTCProductDetailViewController alloc] init];
    proDetailVC.id_conflict = pcode;
    proDetailVC.transPermark = permark;
    proDetailVC.transKeyno = keyno;
    [self.navigationController pushViewController:proDetailVC animated:YES];
}
//升级按钮
- (void)upgradeButtonPressedWith:(NSIndexPath *)indexPath{
    TTCUpgradeViewController *upgradeVC = [[TTCUpgradeViewController alloc] init];
    [self.navigationController pushViewController:upgradeVC animated:YES];
}
//通知事件处理
- (void)notificationRespons:(NSNotification*)notifica {
    
    TTCUserLocateViewControllerUserProductOutputProsModel *prosModel = notifica.object;
    TTCProductDetailViewController *proDetailVC = [[TTCProductDetailViewController alloc] init];
    proDetailVC.id_conflict = prosModel.pcode;
    proDetailVC.transPermark = prosModel.permark;
    proDetailVC.transKeyno = prosModel.keyno;
    [self.navigationController pushViewController:proDetailVC animated:YES];
    
}

#pragma mark - Network request
//下拉刷新
- (void)getHeaderData{
    //请求客户数据
//    __weak TTCUserDetailViewController *selfVC = self;
    __weak typeof(self) selfVC = self;
    __block TTCUserLocateViewControllerViewModel *selfViewModel = _locateViewModel;
    //请求成功
    __block BOOL balanceOK = NO;
    __block BOOL arrearOK = NO;
    __block BOOL productOK = NO;
    __block BOOL printOK = NO;

    [_locateViewModel getCustomerInfoWithIcno:[CustomerInfo shareInstance].icno type:[CustomerInfo shareInstance].type success:^(NSMutableArray *resultArray) {
        selfVC.allProductArray = selfViewModel.dataProductArray;
        selfVC.allAccountInfoArray = selfViewModel.dataBalanceArray;
        selfVC.allServsArray = selfViewModel.dataServsArray;
        selfVC.allPrintArray = selfViewModel.dataPrintInfoArray;
        selfVC.addressListArray = selfViewModel.dataAddrsArray;
        //Cell状态
        selfVC.cellStatusArray = [NSMutableArray array];
        for (int i = 0; i < selfVC.addressListArray.count; i ++) {
            TTCUserDetailViewCellStatus *cellStatus = [[TTCUserDetailViewCellStatus alloc] init];
            for (TTCUserLocateViewControllerOutputAddrsModel *addrsModel in selfVC.addressListArray) {
                for (TTCUserLocateViewControllerOutputAddrsPermarksModel *permarksModel in addrsModel.permarks) {
                    for (int i = 0;  i < permarksModel.servs.count; i ++) {
                        //每个地址下面用户的Cell状态
                        [cellStatus.selectedArray addObject:[NSNumber numberWithBool:NO]];
                    }
                }
            }
            //全部Cell状态
            [selfVC.cellStatusArray addObject:cellStatus];
        }
//        //请求成功
//        __block BOOL balanceOK = NO;
//        __block BOOL arrearOK = NO;
//        __block BOOL productOK = NO;
//        __block BOOL printOK = NO;
        //请求余额信息
        selfVC.locateViewModel.balanceSuccessBlock = ^(NSMutableArray *resultArray){
            balanceOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                selfVC.allProductArray = selfViewModel.dataProductArray;
                selfVC.allAccountInfoArray = selfViewModel.dataBalanceArray;
                selfVC.allServsArray = selfViewModel.dataServsArray;
                selfVC.allPrintArray = selfViewModel.dataPrintInfoArray;
                selfVC.addressListArray = selfViewModel.dataAddrsArray;
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC.tableView reloadData];
            }
        };
        [selfVC.locateViewModel getBalanceInfo];
        //请求欠费信息
        selfVC.locateViewModel.arrearSuccessBlock = ^(NSMutableArray *resultArray){
            arrearOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                selfVC.allProductArray = selfViewModel.dataProductArray;
                selfVC.allAccountInfoArray = selfViewModel.dataBalanceArray;
                selfVC.allServsArray = selfViewModel.dataServsArray;
                selfVC.allPrintArray = selfViewModel.dataPrintInfoArray;
                selfVC.addressListArray = selfViewModel.dataAddrsArray;
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC.tableView reloadData];
            }
        };
        [selfVC.locateViewModel getArrearsListWithServsArray:selfVC.locateViewModel.dataServsArray];
        //请求所有业务信息
        selfVC.locateViewModel.userProductSuccessBlock = ^(NSMutableArray *resultArray){
            productOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                selfVC.allProductArray = selfViewModel.dataProductArray;
                selfVC.allAccountInfoArray = selfViewModel.dataBalanceArray;
                selfVC.allServsArray = selfViewModel.dataServsArray;
                selfVC.allPrintArray = selfViewModel.dataPrintInfoArray;
                selfVC.addressListArray = selfViewModel.dataAddrsArray;
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC.tableView reloadData];
            }
        };
        [selfVC.locateViewModel getUseProductWithServsArray:selfVC.locateViewModel.dataServsArray];
        //请求所有未打印单信息
        selfVC.locateViewModel.noPrintInfoSuccessBlock = ^(NSMutableArray *resultArray){
            printOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                selfVC.allProductArray = selfViewModel.dataProductArray;
                selfVC.allAccountInfoArray = selfViewModel.dataBalanceArray;
                selfVC.allServsArray = selfViewModel.dataServsArray;
                selfVC.allPrintArray = selfViewModel.dataPrintInfoArray;
                selfVC.addressListArray = selfViewModel.dataAddrsArray;
                [selfVC.tableView.mj_header endRefreshing];
                [selfVC.tableView reloadData];
            }
        };
        selfVC.locateViewModel.noPrintInfoFailBlock = ^(NSError *erroe){
            //请求失败
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"客户定位失败，请重新定位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [al show];
        };
        [selfVC.locateViewModel getNoInvoiceInfo];
    } fail:^(NSError *error) {
        //请求失败
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:selfVC.locateViewModel.failMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
        [selfVC.tableView.mj_header endRefreshing];
        [selfVC.tableView reloadData];
    }];
}

#pragma mark - Protocol methods
//UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_addressListArray.count > 0) {
        return _addressListArray.count + 2;
    }else{
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section > 1) {
        NSArray *dataArray = [_vcViewModel getServcInfoWithArray:_addressListArray index:(int)(section-2)];
        if (dataArray.count > 0) {
            return dataArray.count;
        }else{
            return 0;
        }
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block TTCUserDetailViewController *selfVC = self;
    TTCUserDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        //第一种模式
        [cell selecteCellType:kFirstType];
        cell.firstStringBlock = ^(NSString *string){
            [selfVC firstButtonPressed:string];
        };
    }else if(indexPath.section == 1){
        //第二种模式
        [cell selecteCellType:kSecondType];
        CustomerInfo *customerInfo = [CustomerInfo shareInstance];
        NSArray *topArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%.2f",customerInfo.feesums],[NSString stringWithFormat:@"%.2f",customerInfo.arrearsun],[NSString stringWithFormat:@"%.2f",customerInfo.printCount], nil];
        [cell loadPriceWithArray:topArray];
        cell.secondStringBlock = ^(NSString *string){
            [selfVC buttonPressed:string];
        };
    }else{
        //其他模式
        [cell selecteCellType:kOtherType];
        //载入数据
        if (_addressListArray.count > 0) {
            NSArray *dataArray = [_vcViewModel getServcInfoWithArray:_addressListArray index:(int)(indexPath.section-2)];
            TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel = dataArray[indexPath.row];
            [cell loadMainSecondWithString:servsModel.servtype];
            [cell loadBusinessNameLabel:servsModel.permark];
            [cell loadBusinessNumLabel:servsModel.servid];
            [cell loadDeviceNumLabel:[NSString stringWithFormat:@"智能卡号：%@",servsModel.keyno]];
            [cell loadDefinitionLabelWithString:servsModel.definition];
            [cell loadTimeLabel:servsModel.servstatus];
            [cell loadTypeWithString:servsModel.feekindname];
            //载入套餐详情
            NSArray *prosArray = [_vcViewModel getUserProductWithAddressArray:_addressListArray productArray:_allProductArray sectionIndex:(int)(indexPath.section-2) rowIndex:(int)indexPath.row];
            //刷新数据
//            [cell loadDetailSetWithArray:prosArray];
            
            //先取得对应的Cell状态
            if (_cellStatusArray.count > 0) {
                TTCUserDetailViewCellStatus *cellStatus = _cellStatusArray[indexPath.section-2];
                BOOL isSelected = [cellStatus.selectedArray[indexPath.row] boolValue];
                //记录选择状态
                [cell selected:isSelected];
                if (isSelected) {
                    
                   [cell loadDetailSetWithArray:prosArray];
                    
                }
                //续订按钮
                cell.cellIndexBlock = ^(NSInteger section,NSInteger row){
                    TTCUserLocateViewControllerUserProductOutputProsModel *prosModel = prosArray[row];
                    [selfVC buyButtonPressedWithPcode:prosModel.pcode permark:prosModel.permark keyno:prosModel.keyno];
                };
            }
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 165/2;
    }else if(indexPath.section == 1){
        return 265/2;
    }else{
        //先取得对应的Cell状态
        if (_cellStatusArray.count > 0) {
            TTCUserDetailViewCellStatus *cellStatus = _cellStatusArray[indexPath.section-2];
            BOOL isSelected = [cellStatus.selectedArray[indexPath.row] boolValue];
            NSArray *prosArray = [_vcViewModel getUserProductWithAddressArray:_addressListArray productArray:_allProductArray sectionIndex:(int)(indexPath.section-2) rowIndex:(int)indexPath.row];
            if (isSelected) {
                return (kBigHeight + prosArray.count*kSmallHeight);
            }else{
                return kBigHeight;
            }
        }else{
            return kBigHeight;
        }
    }
}
//UITableViewDelegate Methods
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section > 1) {
        __weak typeof(self)weakSelf = self;
        TTCUserDetailHeaderView *headerView = [[TTCUserDetailHeaderView alloc] init];
        [headerView loadAddressTitle:[_vcViewModel getAddrsInfoWithModel:_addressListArray[section-2]]];
        headerView.cellIndexBlock = ^(NSInteger section,NSInteger row){
            [weakSelf upgradeButtonPressedWith:[NSIndexPath indexPathForRow:row inSection:section]];
        };
        return headerView;
    }else{
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0000001;
    }else if(section == 1){
        return 0.0000001;
    }else{
        return 60+12;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 1) {
        //先取得对应的Cell状态
        TTCUserDetailViewCellStatus *cellStatus = _cellStatusArray[indexPath.section-2];
        BOOL isSelected = [cellStatus.selectedArray[indexPath.row] boolValue];
        isSelected = !isSelected;
        //更改Cell状态
        TTCUserDetailViewCell *cell = (TTCUserDetailViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell selected:isSelected];
        cellStatus.selectedArray[indexPath.row] = [NSNumber numberWithBool:isSelected];
        //刷新Cell
        NSArray *prosArray = [_vcViewModel getUserProductWithAddressArray:_addressListArray productArray:_allProductArray sectionIndex:(int)(indexPath.section-2) rowIndex:(int)indexPath.row];
        if (prosArray.count > 0) {
//            记录选择状态
            [cell loadDetailSetWithArray:prosArray];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
    }
}

#pragma mark - Other methods
@end
