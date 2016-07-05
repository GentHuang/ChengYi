//
//  TTCPrintDetailViewControllerViewModel.m
//  TTC_Broadband
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#import "TTCPrintDetailViewControllerViewModel.h"
//Model
#import "TTCPrintViewControllerViewOutputUnprintinvinfosModel.h"
#import "TTCPrintDetailViewControllerBooknoModel.h"
#import "TTCPrintDetailViewControllerBooknoOutputModel.h"
#import "TTCPrintDetailViewControllerInvoiceModel.h"
#import "TTCPrintDetailViewControllerInvoiceOutputModel.h"
#import "TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel.h"
#import "TTCPrintDetailViewControllerNextInvoModel.h"
#import "TTCPrintDetailViewControllerNextInvoOutputModel.h"
//Tool
//#import "regoPrinter.h"
//Macro
#define kTopScale 0.27
#define kLeftScale 0.55
@interface TTCPrintDetailViewControllerViewModel()
@property (strong, nonatomic) SellManInfo *sellManInfo;
//@property (strong, nonatomic) regoPrinter *printer;
//add SDK
@property (strong, nonatomic) RemotePrinter *printer;

@property (strong, nonatomic) NSUserDefaults *userDefault;
//判断是否链接打印机
@property (assign, nonatomic) BOOL isConnected;
@end

@implementation TTCPrintDetailViewControllerViewModel
- (instancetype)init{
    if (self = [super init]) {
        _userDefault = [NSUserDefaults standardUserDefaults];
        _sellManInfo = [SellManInfo sharedInstace];
//        _printer = [regoPrinter shareManager];
        
        _printer = [[RemotePrinter alloc] init];
    }
    return self;
}
//打印发票
- (void)printInvoiceWithArray:(NSArray *)dataArray invno:(NSString *)invno bookno:(NSString *)bookno payway:(NSString *)payway success:(SuccessBlock)success fail:(FailBlock)fail{
    //创建票号字符串
    NSMutableString *invcontids = [[NSMutableString alloc] init];
    for (int i = 0; i < dataArray.count; i ++) {
        TTCPrintViewControllerViewOutputUnprintinvinfosModel *infosModel = dataArray[i];
        if (i == 0) {
            [invcontids appendString:infosModel.invcontid];
        }else{
            [invcontids appendString:[NSString stringWithFormat:@",%@",infosModel.invcontid]];
        }
    }
    [[NetworkManager sharedManager] GET:kPrintInvoiceAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"invno":invno,@"bookno":bookno,@"mac":@"EPSONLQ630K",@"invcontids":invcontids,@"payway":payway} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        //初始化
        _dataInfoArray = [NSMutableArray array];
        //获取数据
        TTCPrintDetailViewControllerInvoiceModel *vcModel = [[TTCPrintDetailViewControllerInvoiceModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCPrintDetailViewControllerInvoiceOutputModel *outputModel = vcModel.output;
        _failMSG = outputModel.message;
        //打印状态
        _status = vcModel.status;
        for (TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel *infoModel in outputModel.invprintinfo) {
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
        _failMSG = @"打印失败";
        fail(nil);
    }];
}
//获取发票编号
- (void)getopernextinvoWithDepID:(NSString *)deptid clientcode:(NSString *)clientcode clientpwd:(NSString *)clientpwd operid:(NSString *)operid loginname:(NSString *)loginname name:(NSString *)name areaid:(NSString *)areaid city:(NSString *)city success:(SuccessBlock)success fail:(FailBlock)fail{
    //获取本号
    [[NetworkManager sharedManager] GET:kGetopernextinvoAPI parameters:@{@"deptid":deptid,@"clientcode":clientcode,@"clientpwd":clientpwd,@"operid":operid,@"loginname":loginname,@"name":name,@"areaid":areaid,@"city":city} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        
        TTCPrintDetailViewControllerNextInvoModel *vcModel = [[TTCPrintDetailViewControllerNextInvoModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        TTCPrintDetailViewControllerNextInvoOutputModel *outputModel = vcModel.output;
        //获取数据
        //判断是否存在流水号冲突
        NSRange range = [vcModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            [self getopernextinvoWithDepID:deptid clientcode:clientcode clientpwd:clientpwd operid:operid loginname:loginname name:name areaid:areaid city:city success:^(NSMutableArray *resultArray) {
            } fail:^(NSError *error) {
            }];
            return;
        }
        if ([vcModel.status isEqualToString:@"0"]) {
            _invoString = outputModel.invno;
            success(nil);
        }else{
            _failMSG = vcModel.message;
            fail(nil);
        }
     } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        //获取失败
        _failMSG = @"获取本号失败";
        fail(nil);
    }];
}
//获取本号
- (void)getbooknoByInvno:(NSString *)invno success:(SuccessBlock)success fail:(FailBlock)fail{
    //获取本号
    [[NetworkManager sharedManager] GET:kGetbooknoByInvnoAPI parameters:@{@"deptid":_sellManInfo.depID,@"clientcode":_sellManInfo.loginname,@"clientpwd":_sellManInfo.password,@"invno":invno} success:^(AFHTTPRequestOperation *operation, id   responseObject) {
        TTCPrintDetailViewControllerBooknoModel *vcModel = [[TTCPrintDetailViewControllerBooknoModel alloc] init];
        [vcModel setValuesForKeysWithDictionary:responseObject];
        //初始化
        _dataBooknoArray = [NSMutableArray array];
        //获取数据
        //判断是否存在流水号冲突
        NSRange range = [vcModel.message rangeOfString:@"流水号重复"];
        if (range.length == 5) {
            [self getbooknoByInvno:invno success:^(NSMutableArray *resultArray) {
            } fail:^(NSError *error) {
            }];
            return;
        }
        TTCPrintDetailViewControllerBooknoOutputModel *outputModel = vcModel.output;
        _failMSG = outputModel.message;
        for (int i = 0; i < outputModel.booknos.count; i ++) {
            //发票本号
            [_dataBooknoArray addObject:outputModel.booknos[i]];
        }
        if(_dataBooknoArray.count > 0){
            //获取成功
            success(nil);
        }else{
            //获取失败
            fail(nil);
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *error) {
        //获取失败
        _failMSG = @"获取本号失败";
        fail(nil);
    }];
}
//连接打印机
- (void)connectToPrinterSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    _isConnect = NO;
    //链接测试打印机
    _connectTestprintStaus = NO;
    //设置打印类型为WIFI  原来的
//    [_printer CON_InitLib:_PT_WIFI];
    //设置机型           原来的
//    _printer.stringName = @"RG_SD2480";
    //设置IP和端口
//    NSString *ipString = [_userDefault valueForKey:@"IP"];
//    NSString *portString = [_userDefault valueForKey:@"端口"];
//    NSString *strValue = [NSString stringWithFormat:@"%@:%@",ipString,portString];
//    int state;
//    state = [_printer CON_ConnectDevices:strValue mTimeout:5];
//    NSLog(@"ipString =%@,portString=%@ strValue=%@ ",ipString,portString,strValue);
//    
//    if (state == 5) {
//        _isConnect = YES;
//        _connectTestprintStaus = NO;
//        success(nil);
//    }else if ([ipString isEqualToString:@"0.0.0.0"]){//当IP是默认值0.0.0.0显示连接成功,
//        _isConnect = YES;
//        _connectTestprintStaus =YES;
//       success(nil);
//    } else{
//        _isConnect = NO;
//        _connectTestprintStaus = NO;
//        fail(nil);
//    }
    
    //设置IP和端口
    NSString *ipString = [_userDefault valueForKey:@"IP"];
    NSString *portString = [_userDefault valueForKey:@"端口"];
    
    NSString *strValue = [NSString stringWithFormat:@"%@:%@",ipString,portString];
    /*********add************New*/
    [_printer setTransParm:TRANS_WIFI TransAddress:strValue];
    
    //检测是否连接成功
    /*********add************New*/
    _isConnected = [_printer open];
    if (_isConnected) {
        _isConnect = YES;
        _connectTestprintStaus = NO;
        success(nil);
    }else if ([ipString isEqualToString:@"0.0.0.0"]){//当IP是默认值0.0.0.0显示连接成功,
        _isConnect = YES;
        _connectTestprintStaus =YES;
        success(nil);
    } else{
        _isConnect = NO;
        _connectTestprintStaus = NO;
        fail(nil);
    }
    //链接成功则关闭链接
//    [_printer close];
    /*********add************New*/
    
}
//打印字符串
- (void)printStringWithInfoArray:(NSArray *)dataArray success:(SuccessBlock)success fail:(FailBlock)fail{
    //先排序
    NSMutableArray *alignArray = [NSMutableArray arrayWithArray:dataArray];
    for (int i = 0; i < alignArray.count; i ++) {
        for (int j = i; j < alignArray.count; j ++) {
            TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel *allModel = alignArray[j];
            TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel *infoModel = alignArray[i];
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
    
    for (TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel *infoModel in alignArray) {
        NSLog(@"%@  %@    %@",infoModel.top,infoModel.left,infoModel.content);
    }
    
    //组建打印字符串
    NSMutableString *printString = [[NSMutableString alloc] initWithString:@"\n\n\n"];
    int lastX = 0;
    int lastY = 0;
    int currX;
    int currY;
    int returnCount = 0;
    for (int i = 0; i < alignArray.count; i ++) {
        TTCPrintDetailViewControllerInvoiceOutputInvprintinfoModel *infoModel = alignArray[i];
        NSMutableString *infoString = [[NSMutableString alloc] initWithString:infoModel.content];
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
        NSLog(@"%d",returnCount);
        if (returnCount == 1) {
            returnCount = 0;
        }
        lastY = currY+returnCount;
        lastX = (int)(infoModel.content.length+currX);
    }
    NSLog(@"%@",printString);
    
      /*********原来的SDK方法************/
    //打印字符
//    [_printer CON_PageStart:0 graphicMode:FALSE mWidth:0 mHeight:0];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    int print = [_printer ASCII_PrintString:0 mStr:printString mEncode:enc];
//    [_printer ASCII_CtrlBlackMark:1];
//    [_printer CON_PageEnd:0 TM:TM_DT_V2];
//    if(print==0){
//        success(nil);
//    }else if (_connectTestprintStaus==YES){//当IP是默认值0.0.0.0显示连接成功,
//        success(nil);
//    }else{
//        fail(nil);
//    }
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *printData = [printString dataUsingEncoding:enc];
    NSLog(@"图派打印%@\r\n",printString);
    //
    NSInteger successData ;
    //打印内容
    successData = [_printer sendData:(uint8_t *)[printData bytes] DataLen:[printData length]];    //JOHNBILL MODIFY
    
     NSLog(@"诚意的打印内容=== %zd  本身%zd",successData ,[printData length]);
    
    if(successData&&_isConnected){
        success(nil);
    }else if (_connectTestprintStaus==YES){//当IP是默认值0.0.0.0显示连接成功,
        success(nil);
    }else{
        fail(nil);
    }
//    [_printer close];
    _isConnected = NO;

}
//关闭打印机
- (void)closePrinter{
     /*********原来的SDK方法************/
    //清理缓存
//    [_printer ASCII_CtrlReset:0];
//    //关闭
//    [_printer CON_CloseDevice:0];
    
    [_printer close];
    
}
@end
