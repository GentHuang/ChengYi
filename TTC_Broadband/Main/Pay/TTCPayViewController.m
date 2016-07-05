//
//  TTCPayViewController.m
//  TTC_Broadband
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 TTC. All rights reserved.
//
//Controller
#import "TTCPayViewController.h"
#import "TTCNavigationController.h"
#import "TTCPayFinishViewController.h"
//View
#import "TTCPayViewCell.h"
//ViewModel
#import "TTCPayViewControllerViewModel.h"
#import "TTCShoppingCarViewControllerModel.h"
//add
#import "TTCPayQRCodeView.h"
#import "TTCPaySweepQRcodeWebView.h"
@interface TTCPayViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (assign, nonatomic) float totalPrice;
@property (strong, nonatomic) NSString *payString;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *payWayString;
@property (strong, nonatomic) UIAlertView *sureAlView;
@property (strong, nonatomic) TTCPayViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) SellManInfo *sellManInfo;
@property (strong, nonatomic) CustomerInfo *customerInfo;
@property (strong, nonatomic) MBProgressHUD *progressHud;
//add
@property (strong, nonatomic) TTCPayQRCodeView *QrCodeView;
//微信支付webview
@property (strong, nonatomic) TTCPaySweepQRcodeWebView *QRWebView;
//定时器
@property (strong, nonatomic) NSTimer *timer;
//微信支付订单
@property (strong, nonatomic) NSString *weiXinPayOrderID;

//测试次数
@property (assign, nonatomic) int timeNum;
//支付结果弹窗
@property (strong, nonatomic) UIAlertView *payResultAlert;

@end


@implementation TTCPayViewController
#pragma mark - Init methods
- (void)initData{
    _sellManInfo = [SellManInfo sharedInstace];
    _customerInfo = [CustomerInfo shareInstance];
    //vcViewModel
    _vcViewModel = [[TTCPayViewControllerViewModel alloc] init];
}
#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    [self setSubViewLayout];
    //创建二维码显示图层
    [self creatQrCodeImageView];
    //创建二维码扫码视图
    [self creatQRcodeWebView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBar];
}
- (void)dealloc {
    NSLog(@"销毁===");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    _payString = @"现金支付";
    _payWayString = @"C";
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView registerClass:[TTCPayViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //加载等待
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHud.hidden = YES;
    [_progressHud show:NO];
    [self.view addSubview:_progressHud];
}
- (void)setSubViewLayout{
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAV_HEIGHT_ACCOUNTINFO-20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-TAB_HEIGHT);//-TAB_HEIGHT
    }];
    //加载等待
    [_progressHud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc canGoBack:YES];
    [nvc loadHeaderTitle:@"支付"];
}
#pragma mark - Event response
//点击按钮,确定支付
- (void)buttonPressed{
    UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否支付订单" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alView show];
}
//改变支付方式
- (void)changePayWay:(NSString *)payWay{
    //    00：钱袋支付；11：广电银行支付；22：银行卡无卡支付；33：第三方支付C：现金支付99：微信支付2:POS支付
    _payWayString = payWay;
    if ([_payWayString isEqualToString:@"C"]) {
        _payString = @"现金支付";
    }else if([_payWayString isEqualToString:@"2"]){
        _payString = @"刷卡支付";
    }else if([_payWayString isEqualToString:@"99"]){
        _payString = @"微信支付";
    }
    [_tableView reloadData];
}
#pragma mark - Network request
#pragma mark - Protocol methods
//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isOrderPay) {
        return 2;
    }else if(_isDebtPay){
        return 3;
    }else if(_isCarPay){
        //购物车
        if (_carDataArray.count > 0) {
            return (_carDataArray.count+1);
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCPayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.stringBlock = ^(NSString *payWayString){
        [self changePayWay:payWayString];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isDebtPay) {
        //缴欠费
        if (indexPath.section == 0) {
            //欠费总额
            [cell selectCellType:kCountType];
            [cell loadCount:[NSString stringWithFormat:@"%.02f",_selectedCount]];
        }else if (indexPath.section == 1) {
            //客户信息
            [cell selectCellType:kInformationType];
            [cell loadUserName:_customerInfo.custname sellManName:_sellManInfo.name sellManDepName:_sellManInfo.depName];
        }else{
            //计算总价
            _totalPrice = _selectedCount;
            [cell loadTotalPrice:[NSString stringWithFormat:@"%.02f",_totalPrice]];
            //支付方式
            [cell selectCellType:kChoseType];
        }
    }else if (_isOrderPay){
        //马上订购
        if (indexPath.section == 0) {
            //订单信息
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
            int year = (int)[dateComponent year];
            int month = (int)[dateComponent month];
            int day = (int)[dateComponent day];
            int hour = (int)[dateComponent hour];
            int minute = (int)[dateComponent minute];
            int second = (int)[dateComponent second];
            NSString *date = [NSString stringWithFormat:@"%d/%d/%d %.02d:%.02d:%.02d",year,month,day,hour,minute,second];
            [cell loadPayInfo:date];
            //订单方案
            [cell loadCellImageWithImageString:_vcModel.smallimg];
            [cell selectCellType:kPayOrderType];
            [cell loadTitle:_vcModel.title price:_vcModel.price count:_priceCount];
            [cell loadUserName:_customerInfo.custname sellManName:_sellManInfo.name sellManDepName:_sellManInfo.depName];
        }else{
            //计算总价
            _totalPrice = [_vcModel.price floatValue] * [_priceCount floatValue];
            [cell loadTotalPrice:[NSString stringWithFormat:@"%.02f",_totalPrice]];
            //支付方式
            [cell selectCellType:kChoseType];
        }
    }else if(_isCarPay){
        //购物车
        if(indexPath.section == _carDataArray.count){
            //计算总价
            _totalPrice = [_vcModel.price floatValue] * [_priceCount floatValue];
            for (TTCShoppingCarViewControllerModel *carModel in _carDataArray) {
                _totalPrice += ([carModel.price floatValue]*[carModel.count floatValue]);
            }
            [cell loadTotalPrice:[NSString stringWithFormat:@"%.02f",_totalPrice]];
            //支付方式
            [cell selectCellType:kChoseType];
        }else{
            //订单详情
            TTCShoppingCarViewControllerModel *carModel = (TTCShoppingCarViewControllerModel *)_carDataArray[indexPath.section];
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
            int year = (int)[dateComponent year];
            int month = (int)[dateComponent month];
            int day = (int)[dateComponent day];
            int hour = (int)[dateComponent hour];
            int minute = (int)[dateComponent minute];
            int second = (int)[dateComponent second];
            NSString *date = [NSString stringWithFormat:@"%d/%d/%d %.02d:%.02d:%.02d",year,month,day,hour,minute,second];
            [cell loadPayInfo:date];
            //订单详情
            [cell loadCellImageWithImageString:carModel.smallimg];
            [cell selectCellType:kPayOrderType];
            [cell loadTitle:carModel.title price:carModel.price count:carModel.count];
            [cell loadUserName:_customerInfo.custname sellManName:_sellManInfo.name sellManDepName:_sellManInfo.depName];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isDebtPay) {
        //缴欠费
        switch (indexPath.section) {
            case 0:
                return 90/2;
                break;
            case 1:
                return 90/2;
                break;
            case 2:
                return 496/2;
                break;
            default:
                return 0;
                break;
        }
    }else if(_isOrderPay){
        //马上订购
        switch (indexPath.section) {
            case 0:
                return 280/2;
                break;
            case 1:
                return 496/2;
                break;
            default:
                return 0;
                break;
        }
    }else if(_isCarPay){
        //购物车
        if(indexPath.section == _carDataArray.count){
            //支付部分
            return 496/2;
        }else{
            //详情部分
            return 280/2;
        }
    }else{
        return 0;
    }
}
//UITableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(_isCarPay){
        if (section == _carDataArray.count) {
            UIView *footBackView = [[UIView alloc] init];
            //确定支付
            UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
            payButton.layer.masksToBounds = YES;
            payButton.layer.cornerRadius = 3;
            payButton.backgroundColor = DARKBLUE;
            [payButton setTitle:_payString forState:UIControlStateNormal];
            [payButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
            payButton.titleLabel.font = FONTSIZESBOLD(51/2);
            [footBackView addSubview:payButton];
            [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(136/2);
                make.centerX.mas_equalTo(footBackView.mas_centerX);
                make.width.mas_equalTo(628/2);
                make.height.mas_equalTo(110/2);
            }];
            return footBackView;
        }else{
            return [UIView new];
        }
    }else if(_isDebtPay){
        if (section == 2) {
            UIView *footBackView = [[UIView alloc] init];
            //确定支付
            UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
            payButton.layer.masksToBounds = YES;
            payButton.layer.cornerRadius = 3;
            payButton.backgroundColor = DARKBLUE;
            [payButton setTitle:_payString forState:UIControlStateNormal];
            [payButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
            payButton.titleLabel.font = FONTSIZESBOLD(51/2);
            [footBackView addSubview:payButton];
            [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(136/2);
                make.centerX.mas_equalTo(footBackView.mas_centerX);
                make.width.mas_equalTo(628/2);
                make.height.mas_equalTo(110/2);
            }];
            return footBackView;
        }else{
            return [UIView new];
        }
    }else if(_isOrderPay){
        if (section == 1) {
            UIView *footBackView = [[UIView alloc] init];
            //确定支付
            UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
            payButton.layer.masksToBounds = YES;
            payButton.layer.cornerRadius = 3;
            payButton.backgroundColor = DARKBLUE;
            [payButton setTitle:_payString forState:UIControlStateNormal];
            [payButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
            payButton.titleLabel.font = FONTSIZESBOLD(51/2);
            [footBackView addSubview:payButton];
            [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(136/2);
                make.centerX.mas_equalTo(footBackView.mas_centerX);
                make.width.mas_equalTo(628/2);
                make.height.mas_equalTo(110/2);
            }];
            return footBackView;
        }else{
            return [UIView new];
        }
    }else{
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_isCarPay) {
        if (section == _carDataArray.count) {
            return 500/2;
        }else{
            return 30/2;
        }
    }else if(_isOrderPay){
        if (section == 1) {
            return 500/2;
        }else{
            return 30/2;
        }
    }else if (_isDebtPay){
        if (section == 2) {
            return 500/2;
        }else{
            return 30/2;
        }
    }else{
        return 0;
    }
}
// UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0&&alertView!=_payResultAlert) {
        [self startLoading];
        __block TTCPayViewController *selfVC = self;
        __block TTCPayViewControllerViewModel *selfViewModel = _vcViewModel;
        if (_isDebtPay) {
            //缴欠费
            _vcViewModel.sureSuccessBlock = ^(NSMutableArray *resultArray){
                //订单确认成功
                [selfVC stopLoading];
                TTCPayFinishViewController *payFinishVC = [[TTCPayFinishViewController alloc] init];
                payFinishVC.price = [NSString stringWithFormat:@"%.02f",selfVC.totalPrice];
                [selfVC.navigationController pushViewController:payFinishVC animated:YES];
            };
            _vcViewModel.sureFailBlock = ^(NSError *error){
                //确认失败
                [selfVC stopLoading];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
            };
            _vcViewModel.paySuccessBlock = ^(NSMutableArray *dataArray){
                //支付成功,确定订单
                if ([selfVC.payString isEqualToString:@"现金支付"] || [selfVC.payString isEqualToString:@"刷卡支付"]) {
                    [selfViewModel sureOrderWithOrderArray:selfViewModel.dataOrderArray carArray:nil payway:selfVC.payWayString];
                }else if([selfVC.payString isEqualToString:@"微信支付"]){
                    
                    //价格处理
//                    NSString *totallPrice = [NSString stringWithFormat:@"%.02f",[_vcModel.price floatValue]*[_priceCount floatValue]];
//                    if (selfViewModel.dataOrderArray.count>0) {
//                        [selfVC sendPayWebViewWithOrderID:[selfViewModel.dataOrderArray firstObject] OrderName:selfVC.vcModel.title orderPrice:totallPrice];
//                    }
                    
                    
                }
            };
            _vcViewModel.payFailBlock = ^(NSError *error){
                //支付失败
                [selfVC stopLoading];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
            };
            [_vcViewModel payArrearsWithArray:_allServsArray];
        }else if (_isOrderPay){
            //马上订购
            _vcViewModel.sureSuccessBlock = ^(NSMutableArray *resultArray){
                //订单确认成功
                [selfVC stopLoading];
                TTCPayFinishViewController *payFinishVC = [[TTCPayFinishViewController alloc] init];
                payFinishVC.price = [NSString stringWithFormat:@"%.02f",selfVC.totalPrice];
                [selfVC.navigationController pushViewController:payFinishVC animated:YES];
            };
            _vcViewModel.sureFailBlock = ^(NSError *error){
                //确认失败
                [selfVC stopLoading];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
            };
            if ([_payString isEqualToString:@"现金支付"] || [_payString isEqualToString:@"刷卡支付"]) {
                [selfViewModel sureOrderWithOrderArray:_orderDataArray carArray:nil payway:selfVC.payWayString];
            }else if([_payString isEqualToString:@"微信支付"]){
                //价格处理
                NSString *totallPrice = [NSString stringWithFormat:@"%.02f",[_vcModel.price floatValue]*[_priceCount floatValue]];
                if (_orderDataArray.count>0) {
                    [selfVC sendPayWebViewWithOrderID:[_orderDataArray firstObject] OrderName:_vcModel.title orderPrice:totallPrice];
                }

            }
        }else if (_isCarPay){
            //购物车
            _vcViewModel.sureSuccessBlock = ^(NSMutableArray *resultArray){
                //订单确认成功
                [selfVC stopLoading];
                TTCPayFinishViewController *payFinishVC = [[TTCPayFinishViewController alloc] init];
                payFinishVC.price = [NSString stringWithFormat:@"%.02f",selfVC.totalPrice];
                [selfVC.navigationController pushViewController:payFinishVC animated:YES];
            };
            _vcViewModel.sureFailBlock = ^(NSError *error){
                //确认失败
                [selfVC stopLoading];
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:selfViewModel.failMSG delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alView show];
            };
            if ([_payString isEqualToString:@"现金支付"] || [_payString isEqualToString:@"刷卡支付"]) {
                [selfViewModel sureOrderWithOrderArray:_orderDataArray carArray:_carDataArray payway:selfVC.payWayString];
            }else if([_payString isEqualToString:@"微信支付"]){
                //微信二维码支付
                
                 // 计算总价 拼接字符串
                float allPrice = 0;
                NSMutableString *titleName = [NSMutableString string];
                NSMutableString *ProductID = [NSMutableString string];
                 for (TTCShoppingCarViewControllerModel *carModel in _carDataArray) {
                 allPrice += ([carModel.price floatValue]*[carModel.count intValue]);
                     [titleName appendString:carModel.title];
                     [ProductID appendString:carModel.id_conflict];
                 }
                //转换成字符串
                NSString *priceString = [NSString stringWithFormat:@"%.02f",allPrice];
                if (_orderDataArray.count>0) {
                    [selfVC sendPayWebViewWithOrderID:[_orderDataArray firstObject] OrderName:titleName orderPrice:priceString];
                }
            }
        }
    }
    
    if (alertView==_payResultAlert&&buttonIndex==0) {
        [self paySuccess];
    }
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
#pragma mark  QrCode
//创建二维码图层
- (void)creatQrCodeImageView{
    _QrCodeView = [[TTCPayQRCodeView alloc]init];
    _QrCodeView.backgroundColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:0.3];
    [self.view addSubview:_QrCodeView];
    _QrCodeView.frame = [UIScreen mainScreen].bounds;
    _QrCodeView.hidden = YES;
}
- (void)ShowImageWithPayString:(NSString*)string{
    _QrCodeView.hidden = NO;
    [self.view bringSubviewToFront:_QrCodeView];
    [_QrCodeView ShowQRCodeImageViewWitURLString:string];
    NSLog(@"支付链接%@",string);
}
#pragma mark  网页支付
- (void)creatQRcodeWebView {
    _QRWebView  =[[TTCPaySweepQRcodeWebView alloc]init];
    _QRWebView.backgroundColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:0.3];
    _QRWebView.frame = [UIScreen mainScreen].bounds;
    _QRWebView.hidden = YES;
    __weak TTCPayViewController *weakSelf = self;
    _QRWebView.buttonPress = ^(UIButton*button){
        [weakSelf cacelTimer];
    };
    [self.view addSubview:_QRWebView];
}
- (void)sendPayWebViewWithOrderID:(NSString*)orderID OrderName:(NSString *)orderName orderPrice:(NSString *)orderPrice {
    //拼接字符串
    
    NSString *urlString =[NSString stringWithFormat:KGetWeiXinPayAPI@"money=%@&orderno=%@&proname=%@",[NSString stringWithFormat:@"%f",[orderPrice floatValue]],orderID,orderName];
    _QRWebView.hidden = NO;
    _weiXinPayOrderID = orderID;
    [self.view bringSubviewToFront:_QRWebView];
    //加载数据
    [_QRWebView loadWebView:urlString];
    _timeNum = 0;
    //
    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(queryWeiXinPayResult) userInfo:self repeats:NO];
}
//查询数据
- (void)queryWeiXinPayResult {
    //间隔5.0向服务器请求数据
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(sentNetRequst) userInfo:self repeats:YES];
}
- (void)sentNetRequst {
//    if (_timeNum==5) {
//      //测试
//        _weiXinPayOrderID =@"8042";
//    }
//     _timeNum++;
    [_vcViewModel queryPayResultWithOderID:_weiXinPayOrderID sucess:^(NSMutableArray *resultArray) {
        //请求成功取消
        [_timer invalidate];
        _payResultAlert = [[UIAlertView alloc]initWithTitle:@"支付成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_payResultAlert show];
    } fail:^(NSError *error) {
        NSLog(@"~~~~loading~~~");
    }];
}
- (void)cacelTimer {
    [_timer invalidate];
//    _timer = nil;
    _QRWebView.hidden = YES;
    [self stopLoading];
}
//支付完成
- (void)paySuccess {
    [_timer invalidate];
//    _timer = nil;
    _QRWebView.hidden = YES;
    [self stopLoading];
    TTCPayFinishViewController *payFinishVC = [[TTCPayFinishViewController alloc] init];
    payFinishVC.price = [NSString stringWithFormat:@"%.02f",self.totalPrice];
    [self.navigationController pushViewController:payFinishVC animated:YES];
}
@end
