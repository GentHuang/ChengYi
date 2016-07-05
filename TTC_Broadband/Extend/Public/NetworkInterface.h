//
//
//  Created by 曾梓麟 on 15/10/16.
//  Copyright © 2015年 TTC. All rights reserved.
//

#ifndef ZhiDa_Home_NetworkInterface_h
#define ZhiDa_Home_NetworkInterface_h
//内网测试地址
//测试
//#define MAINURL @"http://10.1.131.100/service/UserInfo.ashx?"
//#define IMGURL @"http://10.1.131.100/uploadfiles/images/%@"
//#define BANNERIMGURL @"http://10.1.131.100%@"
//#define ACCOUNTMAINURL @"http://10.1.131.100/service/Account.ashx?"
//#define HTML5URL @"http://10.1.131.100"

//正式
//#define MAINURL @"http://10.1.131.100:8080/service/UserInfo.ashx?"
//#define IMGURL @"http://10.1.131.100:8080/uploadfiles/images/%@"
//#define BANNERIMGURL @"http://10.1.131.100:8080%@"
//#define ACCOUNTMAINURL @"http://10.1.131.100:8080/service/Account.ashx?"
//#define HTML5URL @"http://10.1.131.100:8080"

//外网测试地址
//测试
#define MAINURL @"http://58.244.255.161:20023/service/UserInfo.ashx?"
#define IMGURL @"http://58.244.255.161:20023/uploadfiles/images/%@"
#define BANNERIMGURL @"http://58.244.255.161:20023%@"
#define ACCOUNTMAINURL @"http://58.244.255.161:20023/service/Account.ashx?"
#define HTML5URL @"http://58.244.255.161:20023"

//正式
//#define MAINURL @"http://58.244.255.161:20025/service/UserInfo.ashx?"
//#define IMGURL @"http://58.244.255.161:20025/uploadfiles/images/%@"
//#define BANNERIMGURL @"http://58.244.255.161:20025%@"
//#define ACCOUNTMAINURL @"http://58.244.255.161:20025/service/Account.ashx?"
//#define HTML5URL @"http://58.244.255.161:20025"

//每页显示大小
#define PAGESIZE @"1000"
//销售人员登录(账号，密码)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getSalesmanInfo&name=&pwd=
#define kGetSalesmanInfoAPI MAINURL@"action=getSalesmanInfo"
//客户人员信息(部门ID，员工号，员工密码，智能卡号)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getCustomerByIcon&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&deptid=6804&icno=8411003769679788
#define kGetCustomerByIconAPI MAINURL@"action=getCustomerByIcon"
//余额信息(部门ID，员工号，员工密码，用户ID)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getBalanceByCustid&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&custid=7297337&deptid=6804
#define kGetBalanceByCustidAPI MAINURL@"action=getBalanceByCustid"
//欠费信息(部门,员工号，员工密码,计费对象，每页大小，当前页数)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getArrearsList&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&currentPage=0&deptid=6804&keyno=8411002882425459&pagesize=6
#define kGetArrearsListAPI MAINURL@"action=getArrearsList"
//用户下的产品信息(部门,员工号，员工密码,智能卡号，分页大小，当前页数)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getUseProduct&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&currentPage=1&deptid=6804&keyno=8411003769679788&pagesize=20
#define kGetUseProductAPI MAINURL@"action=getUseProduct"
//客户订单记录(部门,员工号，员工密码,智能卡号，每页大小，当前页数)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getOrdersList&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&currentPage=0&deptid=6804&keyno=8411002196388732&pagesize=6
#define kGetOrdersListAPI MAINURL@"action=getOrdersList"
//获取产品详情(产品ID)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=getProductById&id=100000103575813
#define kGetProductByIdAPI MAINURL@"action=getProductById"
//获取销售统计(部门,员工号,员工名称,部门名称)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=salesStatistics&clientcode=GZCYKFA001&deptid=6804&deptname=%E4%B8%AD%E5%B1%B1%E8%90%A5%E4%B8%9A%E5%8E%85&mname=%E8%90%A5%E4%B8%9A%E5%91%98A
#define kGetSalesStatisticsAPI MAINURL@"action=salesStatistics"
//获取销售类型统计(互动，宽带，数字)
//例子 http://222.62.210.6:20023/service/userinfo.ashx?action=geterpsales&deptid=6804&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&operId=19329&stime=2016-2-25&etime=2016-3-28
#define kGetSalesBusinessStatisticsAPI MAINURL@"action=geterpsales"

//获取排行(排行个数)
//例子 http://192.168.0.9:1015/service/UserInfo.ashx?action=salesRanking&nums=5
#define kGetSalesRankingAPI MAINURL@"action=salesRanking"
//缴纳欠费(部门,员工号，员工密码，智能卡号，业务类型，缴费金额,是否续订，续订周期,部门名称，员工名称，客户名称)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=payArrears&Deptname=%E4%B8%AD%E5%B1%B1%E8%90%A5%E4%B8%9A%E5%8E%85&Uname=%E5%90%B4%E5%AE%AA%E5%8D%8E&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&count=0&deptid=6804&fees=293&isorder=Y&keyno=8411002662204850&permark=1
#define kPayArrearsAPI MAINURL@"action=payArrears"
//确定订单(部门,员工号，员工密码,订单号，支付方式，银行账号，第三方交易流水，支付编码)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=sureOrder&bankaccno=&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&deptid=6804&orderid=1302&paycode=23&payreqid=121&payway=22
#define kSureOrderAPI MAINURL@"action=sureOrder"
//马上订购(部门,员工号，员工密码,客户编号，用户智能卡号/多，订购类型/多，商品编码/多，订购周期/多,产品名称/多，业务类型/多,部门名称，员工名称，客户名称)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=productOrder&Deptname=%E4%B8%AD%E5%B1%B1%E8%90%A5%E4%B8%9A%E5%8E%85&Mname=%E8%90%A5%E4%B8%9A%E5%91%98A&Uname=%E7%8E%8B%E6%B7%91%E9%A6%99&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&count=2&custid=8719273&deptid=6804&keyno=8411003769679788&ordertype=0&permark=1&proname=%E6%95%B0%E5%AD%97%E5%9F%BA%E6%9C%AC%E5%8C%85&salescode=00000000Aj
#define kProductOrderAPI MAINURL@"action=productOrder"
//获取所有销售明细(部门，员工号，当前页数，每页数量)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=getMyOrders&clientcode=GZCYKFA001&deptid=6804&page=1&row=6
#define kGetMyOrdersAPI MAINURL@"action=getMyOrders"
//获取当天销售明细(部门，员工号，当前页数，每页数量)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=getMyOrdersToday&clientcode=GZCYKFA001&deptid=6804&page=1&row=6
#define kGetMyOrdersTodayAPI MAINURL@"action=getMyOrdersToday"
//查询未打印项(部门,员工号，员工密码，客户编号)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=NoInvoiceInfo&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&custid=8630767&deptid=6804
#define kGETNoInvoiceInfoAPI MAINURL@"action=NoInvoiceInfo"
//打印发票(部门,员工号，员工密码,发票编号,发票本号,打印费用项目编号/多,打印类型)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=printInvoice&bookno=test0812&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&deptid=6804&invcontids=24439985&invno=00000053&mac=EPSON%20LQ-630K_HH
#define kPrintInvoiceAPI MAINURL@"action=printInvoice"
//获取发票本号(部门,员工号，员工密码,发票编号)
//例子 http://192.168.0.86:1015/service/UserInfo.ashx?action=getbooknoByInvno&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&deptid=6804&invno=00000037
#define kGetbooknoByInvnoAPI MAINURL@"action=getbooknoByInvno"
//获取所有消息(员工号,当前页数，每页数量)
//例子
#define kGetMessageAPI MAINURL@"action=getMessage"
//消息已读(消息ID,员工号,员工名)
//例子 http://192.168.0.86:1015/service/UserInfo.asmx/addMessageRead
#define kIsReadAPI MAINURL@"action=addMessageRead"
//发送反馈（员工名,员工号,内容）
//例子 http://180.200.3.72/service/userinfo.ashx?action=faqSave&title=01&code=02&content=asdfasdf
#define kSendResponseAPI MAINURL@"action=faqSave"
//打印受理单
//例子 http://180.200.3.72/service/userinfo.ashx?action=printAcceptance&deptid=231479&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&orderid=1763
#define kPrintAcceptanceAPI MAINURL@"action=printAcceptance"
//获取Banner
//例子 http://180.200.3.72/service/userinfo.ashx?action=getBanner
#define kGetBannerAPI MAINURL@"action=getBanner"
//充值
//例子
#define kRechargeAPI MAINURL@"action=chongzhi"
//新建客户
//例子 http://222.62.210.6:20023/service/Account.ashx?action=addcustomer&deptid=6804&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&areaid=1433&markno=0&custType=0&subtype=00&cardType=3&cardNo=4444445&linkaddr=&linkman=&mobile=13123224342&phone=2321233&memo=备注&topmemo=重点备注&name=胡三
#define kNewCustomAPI ACCOUNTMAINURL@"action=addcustomer"
//开户
//例子 http://localhost:5314/service/Account.ashx?action=opena&deptid=6804&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&areaid=1433&houseid=111&custid=12387&addr=%E8%BE%BD%E5%AE%81%E7%9C%81%E5%A4%A7%E8%BF%9E%E5%B8%82%E9%87%91%E5%B7%9E%E5%8C%BA%E7%9B%9B%E6%BB%A8%E8%8A%B1%E5%9B%AD46%E5%8F%B7&endaddr=46%E5%8F%B7&openmode=1&feekind=00&type=&stbno=&logicno=888811114444&cmno=&oldstbno=&oldlogicno=&tradein=N&smnouseprop=4&stbuseprop=4&payway=0&servtype=0&servrele=
#define kNewUserAPI ACCOUNTMAINURL@"action=opena"

//开户结果查询  --add
//例子http://222.62.210.6:20023/service/Account.ashx?action=getstatus&deptid=231479&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&orderid=&custid=8761130
#define kNewUserResultAPI ACCOUNTMAINURL@"action=getstatus"

//查询字典
//例子 http://222.62.210.6:20023/service/Account.ashx?action=getdictionaries&gcode=PRV_AREA
#define kGetDictionariesAPI ACCOUNTMAINURL@"action=getdictionaries"
//添加地址
//例子 http://222.62.210.6:20023/service/Account.ashx?action=getaddress&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&deptid=6804&areaid=1433&patchid=27003&addr=%E8%BE%BD%E5%AE%81%E7%9C%81%E5%A4%A7%E8%BF%9E%E5%B8%82%E7%94%98%E4%BA%95%E5%AD%90%E5%8C%BA%E7%BA%A2%E5%87%8C%E8%B7%AF605%E5%8F%B73%E5%8D%95%E5%85%83&pagesize=3&currentPage=1
#define kAddAddressAPI ACCOUNTMAINURL@"action=getaddress"
//开户模式
//例子 http://222.62.210.6:20023/service/Account.ashx?action=getattype&deptid=6804&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&city=DL&areaId=681&permark=3
#define kCreateModeAPI ACCOUNTMAINURL@"action=getattype"
//获取操作员发票编号
//例子 http://222.62.210.6:20023/service/Account.ashx?action=getopernextinvo&deptid=6804&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&operid=0&loginname=null&name=null&areaid=3&city=null
#define kGetopernextinvoAPI ACCOUNTMAINURL@"action=getopernextinvo"
//获取开户地址
//例子 http://222.62.210.6:20023/service/Account.ashx?action=getaddress&clientcode=GZCYKFA001&clientpwd=202cb962ac59075b964b07152d234b70&deptid=6804&areaid=1433&patchid=27003&addr=%E8%BE%BD%E5%AE%81%E7%9C%81%E5%A4%A7%E8%BF%9E%E5%B8%82%E7%94%98%E4%BA%95%E5%AD%90%E5%8C%BA%E7%BA%A2%E5%87%8C%E8%B7%AF605%E5%8F%B73%E5%8D%95%E5%85%83&pagesize=3&currentPage=1
#define kGetAddressAPI ACCOUNTMAINURL@"action=getaddress"
//获取产品列表(产品类型，每页数量，当前页面)
//例子 http://222.62.210.6:20023/service/userinfo.ashx?Action=getProList&itemid=33442&row=20&page=1
#define kGetProListAPI MAINURL@"action=getProList"
//获取产品分类
//例子 http://222.62.210.6:20023/service/userinfo.ashx?Action=getprotype
#define kGetProTypeAPI MAINURL@"action=getprotype"
//获取热销产品
//例子：http://222.62.210.6:20023/service/UserInfo.ashx?action=getSales20
#define kGetHotSellAPI MAINURL@"action=getSales20"

//微信支付(扫二维码)
//例子http://weixincs.maywide.com/wxpay/pay.aspx?money=0.01&orderno=8043&proname=CHC动作电影
#define KGetWeiXinPayAPI @"http://weixincs.maywide.com/wxpay/pay.aspx?"
//查询支付结果
//例子：http://weixincs.maywide.com/service/Account.ashx?action=getpayordreno&orderno=8042

#define KGetWeiXinPayResultAPI @"http://weixincs.maywide.com/service/Account.ashx?action=getpayordreno&orderno=%@"

#endif