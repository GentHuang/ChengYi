//
//  TTCScanViewController.m
//  TTC_Broadband
//
//  Created by 曾梓麟 on 16/1/3.
//  Copyright © 2016年 TTC. All rights reserved.
//

#import "TTCScanViewController.h"
#import "TTCNavigationController.h"
#import "TTCUserDetailViewController.h"
//ViewModel
#import "TTCUserLocateViewControllerViewModel.h"
//View
#import "TTCScanViewControllerView.h"
@import AVFoundation;
@interface TTCScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) TTCUserLocateViewControllerViewModel *vcViewModel;
@property (strong, nonatomic) NSUserDefaults *userDefault;
// 扫码区域动画视图
@property (strong, nonatomic) TTCScanViewControllerView *scanerView;
//AVFoundation
// AV协调器
@property (strong,nonatomic) AVCaptureSession           *session;
// 取景视图
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@end
@implementation TTCScanViewController
#pragma mark - Init methods
- (void)initData{
    //vcViewModel
    _vcViewModel = [[TTCUserLocateViewControllerViewModel alloc] init];
    //userDefault
    _userDefault = [NSUserDefaults standardUserDefaults];
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
    [self setNavigationBar];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Getters and setters
- (void)createUI{
    self.scanerView.alpha = 0;
    //设置扫描区域边长
    self.scanerView = [[TTCScanViewControllerView alloc] init];
    self.scanerView.frame = self.view.frame;
    self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 220;//2 * 200;
    [self.view addSubview:self.scanerView];
    
    if (!self.session){
        //添加镜头盖开启动画
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.type = @"cameraIrisHollowOpen";
        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        animation.delegate = self;
        [self.view.layer addAnimation:animation forKey:@"animation"];
        
        //初始化扫码
        [self setupAVFoundation];
        
        //调整摄像头取景区域
        self.previewLayer.frame = self.view.bounds;
        
        //调整扫描区域
        AVCaptureMetadataOutput *output = self.session.outputs.firstObject;
        //根据实际偏差调整y轴
        CGRect rect = CGRectMake((self.scanerView.scanAreaRect.origin.y + 20) / HEIGHT(self.scanerView),
                                 self.scanerView.scanAreaRect.origin.x / WIDTH(self.scanerView),
                                 self.scanerView.scanAreaRect.size.height / HEIGHT(self.scanerView),
                                 self.scanerView.scanAreaRect.size.width / WIDTH(self.scanerView));
        output.rectOfInterest = rect;
    }
}
- (void)setSubViewLayout{
    
}
- (void)setNavigationBar{
    TTCNavigationController *nvc = (TTCNavigationController *)self.navigationController;
    [nvc selectNavigationType:kProductDetailType];
    [nvc loadHeaderTitle:@"扫一扫"];
}
#pragma mark - Event response
//客户定位
- (void)userLocateAction:(NSString *)icno{
    //请求客户数据
    __weak TTCScanViewController *selfVC = self;
    //使用客户证号方式登陆
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_vcViewModel getCustomerInfoWithIcno:icno type:[NSString stringWithFormat:@"%d",2] success:^(NSMutableArray *resultArray) {
        //请求成功
        __block BOOL balanceOK = NO;
        __block BOOL arrearOK = NO;
        __block BOOL productOK = NO;
        __block BOOL printOK = NO;
        //请求余额信息
        _vcViewModel.balanceSuccessBlock = ^(NSMutableArray *resultArray){
            balanceOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        [_vcViewModel getBalanceInfo];
        //请求欠费信息
        _vcViewModel.arrearSuccessBlock = ^(NSMutableArray *resultArray){
            arrearOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        [_vcViewModel getArrearsListWithServsArray:_vcViewModel.dataServsArray];
        //请求所有业务信息
        _vcViewModel.userProductSuccessBlock = ^(NSMutableArray *resultArray){
            productOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        [_vcViewModel getUseProductWithServsArray:_vcViewModel.dataServsArray];
        //请求所有未打印单信息
        _vcViewModel.noPrintInfoSuccessBlock = ^(NSMutableArray *resultArray){
            printOK = YES;
            if (balanceOK && arrearOK && productOK && printOK) {
                //跳转到客户详情
                [selfVC pushToUserDetailActionWithIcno:icno];
            }
        };
        _vcViewModel.noPrintInfoFailBlock = ^(NSError *erroe){
            //请求失败
            [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"客户定位失败，请重新定位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [al show];
            [selfVC.navigationController popViewControllerAnimated:YES];
        };
        [_vcViewModel getNoInvoiceInfo];
    } fail:^(NSError *error) {
        //请求失败
        [MBProgressHUD hideHUDForView:selfVC.view animated:YES];
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:_vcViewModel.failMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
        [selfVC.navigationController popViewControllerAnimated:YES];
    }];
}
//跳到客户详情
- (void)pushToUserDetailActionWithIcno:(NSString *)icno{
    //缓存客户ID
    NSArray *memoryArray = [_userDefault objectForKey:@"客户ID"];
    if (memoryArray.count > 0) {
        //添加新的客户ID
        NSMutableArray *dataArray = [NSMutableArray array];
        BOOL isExit = NO;
        for (int i = 0; i < memoryArray.count; i ++) {
            [dataArray addObject:memoryArray[i]];
            if ([icno isEqualToString:memoryArray[i]]) {
                isExit = YES;
            }
            if (i == memoryArray.count -1 && !isExit) {
                [dataArray addObject:icno];
            }
        }
        [_userDefault setObject:dataArray forKey:@"客户ID"];
    }else{
        //若本为空，创建客户ID数组
        memoryArray = [NSArray arrayWithObjects:icno, nil];
        [_userDefault setObject:memoryArray forKey:@"客户ID"];
    }
    [_userDefault synchronize];
    //记录客户登录状态
    [_userDefault setValue:@"YES" forKey:@"客户登录状态"];
    [_userDefault synchronize];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    TTCUserDetailViewController *detailVC = [[TTCUserDetailViewController alloc] init];
    //定位成功，去掉定位页面
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    if(navigationArray.count > 0){
        [navigationArray removeObject:self];
        [navigationArray addObject:detailVC];
        [self.navigationController setViewControllers:navigationArray animated:YES];
    }
}
#pragma mark - Data request
#pragma mark - Protocol methods
//AVCaptureMetadataOutputObjectsDelegate Method
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataMachineReadableCodeObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            //二维码
            [self.session stopRunning];
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"这不是条形码哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alView show];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }else{
            //条形码
            [self.session stopRunning];
            if ([_postName isEqualToString:@"客户定位"]) {
                //客户定位扫码
                [self userLocateAction:metadata.stringValue];
                //
                //其他扫码
                NSArray *vcArray = self.navigationController.viewControllers;
                UIViewController *lastVC = vcArray[vcArray.count - 2];
                [lastVC setValue:[NSString stringWithFormat:@"%@ %@",_postName,metadata.stringValue] forKey:@"scanString"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                //其他扫码
                NSArray *vcArray = self.navigationController.viewControllers;
                UIViewController *lastVC = vcArray[vcArray.count - 2];
                [lastVC setValue:[NSString stringWithFormat:@"%@ %@",_postName,metadata.stringValue] forKey:@"scanString"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        }
    }
}
#pragma mark - Other methods
//! 动画结束回调
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.scanerView.alpha = 1;
                     }];
}
//! 初始化扫码
- (void)setupAVFoundation{
    //创建会话
    self.session = [[AVCaptureSession alloc] init];
    
    //获取摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(input) {
        [self.session addInput:input];
    } else {
        //出错处理
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"请在手机【设置】-【隐私】-【相机】选项中，允许【%@】访问您的相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [av show];
        return;
    }
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:output];
    
    //设置扫码类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   //条形码
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    //设置代理，在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //创建摄像头取景区域
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    if ([self.previewLayer connection].isVideoOrientationSupported)
        [self.previewLayer connection].videoOrientation = AVCaptureVideoOrientationPortrait;
    
    //开始扫码
    [self.session startRunning];
}
@end
