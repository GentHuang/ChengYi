//
//  TTCOrderRecordViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/22.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCOrderRecordViewControllerViewModel.h"
//Model
#import "TTCUserLocateViewControllerModel.h"
#import "TTCUserLocateViewControllerOutputModel.h"
#import "TTCUserLocateViewControllerOutputAddrsModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksModel.h"
#import "TTCUserLocateViewControllerOutputAddrsPermarksServsModel.h"
#import "TTCOrderRecordViewControllerModel.h"
#import "TTCOrderRecordViewControllerOutputModel.h"
#import "TTCOrderRecordViewControllerOutputOrderModel.h"
#import "TTCSellDetailMonthViewControllerModel.h"
#import "TTCSellDetailMonthViewControllerOdsModel.h"
#import "TTCOrderRecordViewControllerPrintModel.h"
#import "TTCOrderRecordViewControllerPrintOutputModel.h"
#import "TTCOrderRecordViewControllerPrintOutputInfosModel.h"
//Tool
//#import "regoPrinter.h"
//Macro
#define kTopScale 0.233
#define kLeftScale 0.45
@interface TTCOrderRecordViewControllerViewModel()
@property (assign, nonatomic) BOOL isConnect;
//@property (strong, nonatomic) regoPrinter *printer;
@property (strong, nonatomic) NSUserDefaults *userDefault;
@property (strong, nonatomic) SellManInfo *sellManInfo;
@end

@implementation TTCOrderRecordViewControllerViewModel
//初始化
- (instancetype)init{
    if (self = [super init]) {
//        _printer = [regoPrinter shareManager];
        _userDefault = [NSUserDefaults standardUserDefaults];
        _sellManInfo = [SellManInfo sharedInstace];
    }
    return self;
}
//获取客户所有订单信息
- (void)getOrdersListPage:(int)page isAll:(BOOL)isAll success:(SuccessBlock)success fail:(FailBlock)fail{
    //判断是全部订单还是未支付订单
    NSString *pagesize = @"20";
    if (!isAll) {
        pagesize = @"1000";
    }
    SellManInfo *sellManInfo = [SellManInfo sharedInstace];
        [[NetworkManager sharedManager] GET:kGetOrdersListAPI parameters:@{@"deptid":sellManInfo.depID,@"clientcode":sellManInfo.loginname,@"clientpwd":sellManInfo.password,@"pagesize":pagesize,@"currentPage":[NSString stringWithFormat:@"%d",page],@"custid":[CustomerInfo shareInstance].custid} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
            //初始化存储数据
            if (page == 1) {
                _dataOrderArray = [NSMutableArray array];
            }
            //获取数据
            TTCOrderRecordViewControllerModel *vcModel = [[TTCOrderRecordViewControllerModel alloc] init];
            [vcModel setValuesForKeysWithDictionary:responseObject];
            TTCOrderRecordViewControllerOutputModel *outputModel = vcModel.output;
            for (TTCOrderRecordViewControllerOutputOrderModel *orderModel in outputModel.orders) {
                if (isAll) {
                    //所有订单记录信息
                    [_dataOrderArray addObject:orderModel];
                }else{
                    //所有未支付订单记录信息
                    if ([orderModel.commitmsg isEqualToString:@"未支付"]) {
                        [_dataOrderArray addObject:orderModel];
                    }
                }
            }
            if(_dataOrderArray.count > 0){
                //欠费请求完成
                success(nil);
            }else{
                //欠费请求失败
                fail(nil);
            }
        } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
            fail(nil);
            NSLog(@"%@",error);
        }];
}
#pragma mark - Event response
//打印受理单
- (void)printAcceptWithOrderID:(NSString *)OrderID success:(SuccessBlock)success fail:(FailBlock)fail{
    //请求
    [[NetworkManager sharedManager] GET:kPrintAcceptanceAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"orderid":OrderID} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataInfoArray = [NSMutableArray array];
        //获取数据
        TTCOrderRecordViewControllerPrintModel *vcModel = [[TTCOrderRecordViewControllerPrintModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCOrderRecordViewControllerPrintOutputModel *outputModel = vcModel.output;
        for (TTCOrderRecordViewControllerPrintOutputInfosModel *infoModel in outputModel.infos) {
            //获取发票上的信息
            [_dataInfoArray addObject:infoModel];
        }
        //检测发票获取是否成功
        if (_dataInfoArray.count > 0) {
            success(nil);
        }else{
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        NSLog(@"%@",error);
        fail(nil);
    }];
}
//连接打印机
- (void)connectToPrinterSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    /*
    //设置打印类型为WIFI
    [_printer CON_InitLib:_PT_WIFI];
    //设置机型
    _printer.stringName = @"RG_SD2480";
    //设置IP和端口
    NSString *strValue = [NSString stringWithFormat:@"%@:%@",[_userDefault valueForKey:@"IP"],[_userDefault valueForKey:@"端口"]];
    if (![_userDefault valueForKey:@"IP"]) {
        strValue = [NSString stringWithFormat:@"%@:%@",@"192.168.1.188",@"9100"];
    }
    //检测是否连接成功
    int state;
    state = [_printer CON_ConnectDevices:strValue mTimeout:5];
    if (state == 5) {
        _isConnect = YES;
        success(nil);
    }else{
        _isConnect = NO;
        fail(nil);
    }
     */
}
//打印字符串
- (void)printStringWithInfoArray:(NSArray *)dataArray success:(SuccessBlock)success fail:(FailBlock)fail{
    /*
    //先排序
    NSMutableArray *alignArray = [NSMutableArray arrayWithArray:dataArray];
    for (int i = 0; i < alignArray.count; i ++) {
        for (int j = i; j < alignArray.count; j ++) {
            TTCOrderRecordViewControllerPrintOutputInfosModel *allModel = alignArray[j];
            TTCOrderRecordViewControllerPrintOutputInfosModel *infoModel = alignArray[i];
            if ([infoModel.top intValue] > [allModel.top intValue]) {
                //排Y
                [alignArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }else if([infoModel.top intValue] == [allModel.top intValue]) {
                //排X
                if ([infoModel.left intValue] > [allModel.left intValue]) {
                    [alignArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
    }
    
    for (TTCOrderRecordViewControllerPrintOutputInfosModel *infoModel in alignArray) {
        NSLog(@"%@  %@    %@%@",infoModel.top,infoModel.left,infoModel.title,infoModel.content);
    }
    
    //组建打印字符串
    NSMutableString *printString = [[NSMutableString alloc] initWithString:@"\n\n\n\n\n"];
    int lastX = 0;
    int lastY = 0;
    int currX;
    int currY;
    int returnCount;
    for (int i = 0; i < alignArray.count; i ++) {
        TTCOrderRecordViewControllerPrintOutputInfosModel *infoModel = alignArray[i];
        if (!infoModel.title) {
            infoModel.title = @"";
        }
        if (!infoModel.content) {
            infoModel.content = @"";
        }
        NSMutableString *infoString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@%@",infoModel.title,infoModel.content]];
        //回车的数量
        returnCount = (int)[infoModel.content componentsSeparatedByString:@"\n"].count;
        currX = [infoModel.left intValue]*kLeftScale;
        currY = [infoModel.top intValue]*kTopScale;
        //组建单个字符串
        if (i == 0) {
            //首个字符串
            //加入空格
            for (int j = 0; j < currX; j ++) {
                [infoString insertString:@" " atIndex:0];
            }
            //加入回车
            for (int k = 0; k < currY; k ++) {
                [infoString insertString:@"\n" atIndex:0];
            }
        }else{
            //若处于同一行
            if (currY == lastY) {
                //加入空格(在前一个字符处加入)
                for (int j = 0; j < (currX-lastX); j ++) {
                    [infoString insertString:@" " atIndex:0];
                }
            }else{
                //不处于同一行
                //加入空格
                for (int j = 0; j < currX; j ++) {
                    [infoString insertString:@" " atIndex:0];
                }
                //加入回车(减去之前的行数)
                for (int k = 0; k < (currY-lastY); k ++) {
                    [infoString insertString:@"\n" atIndex:0];
                }
            }
        }
        //添加字符串
        [printString appendString:infoString];
        if (returnCount == 1) {
            returnCount = 0;
        }
        lastY = currY+returnCount;
        lastX = (int)(infoModel.content.length+currX);
    }
    NSLog(@"%@",printString);
    //打印字符
    [_printer CON_PageStart:0 graphicMode:FALSE mWidth:0 mHeight:0];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    int print = [_printer ASCII_PrintString:0 mStr:printString mEncode:enc];
    [_printer ASCII_CtrlBlackMark:1];
    [_printer CON_PageEnd:0 TM:TM_DT_V2];
    if(print == 0){
        success(nil);
    }else{
        fail(nil);
    }
     */
}
//关闭打印机
- (void)closePrinter{
    /*
    //清理缓存
    [_printer ASCII_CtrlReset:0];
    //关闭
    [_printer CON_CloseDevice:0];
     */
}



@end
