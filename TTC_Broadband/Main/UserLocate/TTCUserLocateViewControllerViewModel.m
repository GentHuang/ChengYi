//
//  TTCUserLocateScrollViewViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCUserLocateViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerModel.h"
#import "TTCUserLocateViewControllerOutputModel.h"
#import "TTCUserLocateViewControllerOutputAddrsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCUserLocateViewControllerBalanceModel.h"
#import "TTCUserLocateViewControllerBalanceOutputModel.h"
#import "TTCUserLocateViewControllerBalanceOutputFeebooksModel.h"
#import "TTCUserLocateViewControllerArrearModel.h"
#import "TTCUserLocateViewControllerArrearOutputModel.h"
#import "TTCUserLocateViewControllerArrearOutputArreardetsModel.h"
#import "TTCUserLocateViewControllerUserProductModel.h"
#import "TTCUserLocateViewControllerUserProductOutputModel.h"
#import "TTCUserLocateViewControllerUserProductOutputProsModel.h"
#import "TTCPrintViewControllerModel.h"
#import "TTCPrintViewControllerViewOutputModel.h"
#import "TTCPrintViewControllerViewOutputUnprintinvinfosModel.h"
@interface TTCUserLocateViewControllerViewModel()
@property (assign, nonatomic) int arrearTaskCount;
@property (assign, nonatomic) int curArrearTaskCount;
@property (assign, nonatomic) int productTaskCount;
@property (assign, nonatomic) int curProductTaskCount;
@end
@implementation TTCUserLocateViewControllerViewModel
//初始化
- (instancetype)init{
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"curArrearTaskCount" context:nil];
    [self removeObserver:self forKeyPath:@"curProductTaskCount" context:nil];
}
//获取客户信息
- (void)getCustomerInfoWithIcno:(NSString *)icno type:(NSString *)type success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    
    //请求字段拼接
    NSString *urlString = [NSString stringWithFormat:@"%@&deptid=%@&clientcode=%@&clientpwd=%@&icno=%@&type=%@",kGetCustomerByIconAPI,sellManInfo.depID,sellManInfo.loginname,sellManInfo.password,icno,type];
    
    //姓名地址类型 如果有中文 中文转码
    if ([self iSContentChineseCharacter:icno]) {
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    //除去空格
    if ([urlString rangeOfString:@" "].location != NSNotFound ) {
        urlString = [urlString  stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    //获取数据
    [[NetworkManager sharedManager] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化存储数据
        _dataServsArray = [NSMutableArray array];
        _dataAddrsArray = [NSMutableArray array];
        CustomerInfo *customerInfo = [CustomerInfo shareInstance];
        customerInfo.allServsArray = [NSMutableArray array];
        customerInfo.allAddrsArray = [NSMutableArray array];
        //获取数据
        TTCUserLocateViewControllerModel *vcModel = [[TTCUserLocateViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        //若返回结果大于1个时候
        if (vcModel.output.count > 1) {
            _failMsg = @"查到相关地址过多，请精确输入地址信息";
            failBlock(nil);
            return;
        }
        //判断是否存在流水号冲突
        NSRange range = [vcModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self getCustomerInfoWithIcno:icno type:type success:^(NSMutableArray *resultArray) {
            } fail:^(NSError *error) {
            }];
            return;
        }
        //获取信息
        for (TTCUserLocateViewControllerOutputModel *outputModel in vcModel.output) {
            if ([outputModel.message isEqualToString:@"根据查询条件查询不到客户信息!"]) {
                //暂时找不到
                _failMsg = outputModel.message;
                failBlock(nil);
                return;
            }
            //暂存客户信息
            [customerInfo loadCustomerInfoAddr:outputModel.addr areaid:outputModel.areaid cardno:outputModel.cardno cardtype:outputModel.cardtype city:outputModel.city custid:outputModel.custid custname:outputModel.custname maintaindev:outputModel.maintaindev markno:outputModel.markno message:outputModel.message mobile:outputModel.mobile pgroupid:outputModel.pgroupid pgroupname:outputModel.pgroupname phone:outputModel.phone returnCode:outputModel.returnCode];
            customerInfo.icno = icno;
            customerInfo.type = type;
            customerInfo.areaname = outputModel.areaname;
            customerInfo.custtype = outputModel.custtype;
            customerInfo.servtype = outputModel.servtype;
            for (TTCUserLocateViewControllerOutputAddrsModel *addrsModel in outputModel.addrs) {
                //地址列表信息
                [_dataAddrsArray addObject:addrsModel];
                [customerInfo.allAddrsArray addObject:addrsModel];
                for (TTCUserLocateViewControllerOutputAddrsPermarksModel *permarksModel in addrsModel.permarks) {
                    for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in permarksModel.servs) {
                        //每个用户的信息
                        if (servsModel.keyno.length > 0) {
                            [_dataServsArray addObject:servsModel];
                            [customerInfo.allServsArray addObject:servsModel];
                        }
                    }
                }
            }
        }
        if ([vcModel.status isEqualToString:@"0"]) {
            successBlock(nil);
        }else{
            _failMsg = @"客户定位失败";
            failBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        //如果输入的是地址，格式不对则提示格式错误
        if ([type isEqualToString:@"1"]&&![self iSContentChineseCharacter:icno]) {
            _failMsg = @"输入格式有误";
        }else if ([icno rangeOfString:@"/"].location == NSNotFound&&[self iSContentChineseCharacter:icno]&&[type isEqualToString:@"1"]) {
            _failMsg = @"输入格式有误";
        }else{
            _failMsg = @"网络开小差哦";
        }
        failBlock(nil);
    }];
}
//获取余额信息
- (void)getBalanceInfo{
    __block CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    //获取数据
    if (!customerInfo.custid) {
        customerInfo.custid = @"";
    }
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    [[NetworkManager sharedManager] GET:kGetBalanceByCustidAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"custid":customerInfo.custid} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化存储数据
        _dataBalanceArray = [NSMutableArray array];
        customerInfo.allBalanceArray = [NSMutableArray array];
        customerInfo.feesums = 0;
        customerInfo.cashsums = 0;
        customerInfo.incrementsums = 0;
        //获取数据
        TTCUserLocateViewControllerBalanceModel *balanceModel = [[TTCUserLocateViewControllerBalanceModel alloc] init];
        [balanceModel setValuesForKeysWithDictionary:responseObject];
        //判断是否存在流水号冲突
        NSRange range = [balanceModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self getBalanceInfo];
            return;
        }
        TTCUserLocateViewControllerBalanceOutputModel *outputModel = balanceModel.output;
        //判断账本是否为空
        if (outputModel.feebooks.count > 0) {
            //账本非空
            for (TTCUserLocateViewControllerBalanceOutputFeebooksModel *feedModel in outputModel.feebooks) {
                //每个账本信息
                [_dataBalanceArray addObject:feedModel];
                [customerInfo.allBalanceArray addObject:feedModel];
                if ([feedModel.fbname isEqualToString:@"客户现金账本"]) {
                    customerInfo.cashsums = [feedModel.fbfees floatValue];
                }else if ([feedModel.fbname isEqualToString:@"增值业务账本"]) {
                    customerInfo.incrementsums = [feedModel.fbfees floatValue];
                }
            }
            //计算总余额
            NSInteger feesums = [outputModel.feesums integerValue];
            customerInfo.feesums += feesums;
        }else{
            //账本为空
            NSLog(@"账本为空");
        }
        //余额请求完成
        self.balanceSuccessBlock(nil);
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
//获取欠费信息
- (void)getArrearsListWithServsArray:(NSArray *)servsArray{
    //初始化存储数据
    CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    customerInfo.arrearsun = 0;
    _curArrearTaskCount = 0;
    if (servsArray.count > 0) {
        self.arrearTaskCount = (int)servsArray.count;
        //获取数据
        SellManInfo *sellManInfo = [SellManInfo sharedInstace];
        //重复数组
        NSMutableArray *existArray;
        //获取数据
        for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in servsArray) {
            BOOL isExist = NO;
            //观察是否有重复
            if (existArray.count > 0) {
                if ([existArray indexOfObject:servsModel.keyno] < 99999) {
                    isExist = YES;
                }else{
                    [existArray addObject:servsModel.keyno];
                }
            }else{
                existArray = [NSMutableArray arrayWithObject:servsModel.keyno];
            }
            if (isExist) {
                self.curArrearTaskCount ++;
                continue;
            }
            if (servsModel.keyno.length > 0) {
                [[NetworkManager sharedManager] GET:kGetArrearsListAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"keyno":servsModel.keyno,@"pagesize":PAGESIZE,@"currentPage":@"1"} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
                    TTCUserLocateViewControllerArrearModel *arrearModel = [[TTCUserLocateViewControllerArrearModel alloc] init];
                    [arrearModel setValuesForKeysWithDictionary:responseObject];
                    //判断是否存在流水号冲突
                    NSRange range = [arrearModel.message rangeOfString:@"流水号重复"];
                    if (range.length == 5) {
                        NSLog(@"%@",responseObject);
                        [self getArrearsListWithServsArray:servsArray];
                        return;
                    }
                    TTCUserLocateViewControllerArrearOutputModel *outputModel = arrearModel.output;
                    //计算欠费总额
                    customerInfo.arrearsun += [outputModel.arrearsun floatValue];
                    //判断下载任务是否完成
                    self.curArrearTaskCount ++;
                } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
                    NSLog(@"%@",error);
                }];
            }else{
                self.curArrearTaskCount ++;
            }
        }
    }else{
        //欠费请求完成
        self.arrearSuccessBlock(nil);
    }
}
//获取所有业务信息
- (void)getUseProductWithServsArray:(NSArray *)servsArray{
    //初始化存储数据
    _dataProductArray = [NSMutableArray array];
    __block CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    customerInfo.allProductArray = [NSMutableArray array];
    customerInfo.stoptype = @"";
    if (servsArray.count > 0) {
    _curProductTaskCount = 0;
    self.productTaskCount = (int)servsArray.count;
    //获取数据
    //重复数组
    NSMutableArray *existArray;
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    for (TTCUserLocateViewControllerOutputAddrsPermarksServsModel *servsModel in servsArray) {
        BOOL isExist = NO;
        //观察是否有重复
        if (existArray.count > 0) {
            if ([existArray indexOfObject:servsModel.keyno] < 99999) {
                isExist = YES;
            }else{
                [existArray addObject:servsModel.keyno];
            }
        }else{
            existArray = [NSMutableArray arrayWithObject:servsModel.keyno];
        }
        if (isExist) {
            self.curProductTaskCount ++;
            continue;
        }
        if (servsModel.keyno.length > 0) {
            [[NetworkManager sharedManager] GET:kGetUseProductAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"keyno":servsModel.keyno,@"pagesize":PAGESIZE,@"currentPage":@"1",@"custid":customerInfo.custid} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
                TTCUserLocateViewControllerUserProductModel *productModel = [[TTCUserLocateViewControllerUserProductModel alloc] init];
                [productModel setValuesForKeysWithDictionary:responseObject];
                //判断是否存在流水号冲突
                NSRange range = [productModel.message rangeOfString:@"流水号重复"];
                if (range.length == 5) {
                    NSLog(@"%@",responseObject);
                    [self getUseProductWithServsArray:servsArray];
                    return;
                }
                TTCUserLocateViewControllerUserProductOutputModel *outputModel = productModel.output;
                for (TTCUserLocateViewControllerUserProductOutputProsModel *prosModel in outputModel.prods) {
                    prosModel.keyno = servsModel.keyno;
                    //所有的产品信息
                    [_dataProductArray addObject:prosModel];
                    [customerInfo.allProductArray addObject:prosModel];
                    //管理停
                    if ([prosModel.stoptype isEqualToString:@"管理停"] || [prosModel.stoptype isEqualToString:@"管理联停"]) {
                        customerInfo.stoptype = prosModel.stoptype;
                    }
                }
                //判断下载任务是否完成
                self.curProductTaskCount ++;
            } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }else{
            self.curProductTaskCount ++;
        }
    }
    }else{
        //产品请求完成
        self.userProductSuccessBlock(nil);
    }
}
//获取未打印发票信息
- (void)getNoInvoiceInfo{
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
    __block CustomerInfo *customerInfo = [CustomerInfo shareInstance];
    if (!customerInfo.custid) {
        customerInfo.custid = @"";
    }
    //获取数据
    [[NetworkManager sharedManager] GET:kGETNoInvoiceInfoAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"custid":customerInfo.custid} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化存储数据
        _dataPrintInfoArray = [NSMutableArray array];
        customerInfo.allPrintInfoArray = [NSMutableArray array];
        customerInfo.printCount = 0;
        //获取数据
        TTCPrintViewControllerModel *vcModel = [[TTCPrintViewControllerModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        //判断是否存在流水号冲突
        NSRange range = [vcModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            NSLog(@"%@",responseObject);
            [self getNoInvoiceInfo];
            return;
        }
        TTCPrintViewControllerViewOutputModel *outputModel = vcModel.output;
        for (TTCPrintViewControllerViewOutputUnprintinvinfosModel *infoModel in outputModel.unprintinvinfos) {
            //获取所有未开票的打印单
            [_dataPrintInfoArray addObject:infoModel];
            [customerInfo.allPrintInfoArray addObject:infoModel];
            customerInfo.printCount += [infoModel.fees intValue];
        }
        if ([vcModel.status isEqualToString:@"0"]) {
            //成功
            self.noPrintInfoSuccessBlock(nil);
        }else{
            //失败
            //            self.noPrintInfoFailBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        //        self.noPrintInfoFailBlock(nil);
    }];
}
#pragma mark - Event response
//添加观察者
- (void)addObserver{
    //观察欠费请求是否完成
    [self addObserver:self forKeyPath:@"curArrearTaskCount" options:NSKeyValueObservingOptionNew context:nil];
    //观察产品请求是否完成
    [self addObserver:self forKeyPath:@"curProductTaskCount" options:NSKeyValueObservingOptionNew context:nil];
}
//观察反馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"curArrearTaskCount"]) {
        if (_curArrearTaskCount == _arrearTaskCount) {
            //欠费请求完成
            self.arrearSuccessBlock(nil);
        }
    }else  if ([keyPath isEqualToString:@"curProductTaskCount"]) {
        if (_curProductTaskCount == _productTaskCount) {
            //产品请求完成
            self.userProductSuccessBlock(nil);
        }
    }
}

//判断是否含有中文
- (BOOL)iSContentChineseCharacter:(NSString*)string {
    //判断是否含有中文
    for (int i = 0; i<[string length]; i++) {
        int a = [string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff)
        {
            return YES;
        }
    }
    return NO;
}
@end
