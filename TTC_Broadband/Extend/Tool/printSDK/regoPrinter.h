//
//  regoPrinter.h
//  PrintSDK1107
//
//  Created by wang lipeng on 14-11-7.
//  Copyright (c) 2014年 wang lipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "preDefiniation.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface regoPrinter : NSObject
@property (strong,nonatomic) NSString *stringName;
+(id)shareManager;

-(void)regoPrinter;

/*
 *  初试化打印库  initialize the printing class libraries
 *
 *  参数:
 *      printType PrintType枚举型实例变量，确定打印机接口类型
 *  printTypePrintType is an enum, which is used to determine the printer interface type
 *
 *  返回:
 *      0 操作成功；1 操作失败
 */
-(int) CON_InitLib:(PrintType)printType;

/*
 * 获取SDK支持的页模式下的数据发送类型
 * get the data format supported by SDK under page mode
 *
 *  返回:
 *      0 操作成功；1 操作失败
 */
-(int) CON_GetSupportPageMode;
/*
 * 获取SDK支持的打印机类型 get the printer type supported by SDK
 *
 *  返回:
 *      0 操作成功；1 操作失败
 */
-(int) CON_GetSupportPrinters;

/*
 * 获取无线设备，只针对蓝牙, WIFI有效
 * Get wireless devices with Bluetooth or WIFI
 *  返回:
 *      0 操作成功；1 操作失败
 */
-(int) CON_GetWirelessDevices;
/*
 * 卸载打印库
 *
 *  返回:
 *      0 操作成功；1 操作失败
 */
-(int) CON_FreeLib;
/*
 *
 */
-(int) CON_PrinterInterface:(int)type;
/*
 * 获取无线设备，只针对蓝牙, WIFI有效
 *
 *  返回:
 *      0 操作成功；1 操作失败
 */
-(NSString *) CON_GetWirelessDevices:(int)type;

/*
 * 向打印机发起连接请求
 * Request connection with printer
 * 参数:
 *      strNames    连接蓝牙打印机的名称，在客户端代理函数”PrinterFound“获取已经搜索到的蓝牙打印机
 *  Connected bluetooth printer name, get searched Bluetooth printer through client delegate function “PrinterFound”
 *
 * 返回:
 *      0 发起连接请求失败 Request fail
 *      1 发起连接请求成功 Request OK
 */
-(void)CON_GetRemoteBTPrinters:(NSObject *)parentObject;

/*
 * 连接打印机  Connect Print
 *
 * 参数:
 *      strNames    连接蓝牙打印机的名称，在代理函数”PrinterFound“获取已经搜索到的蓝牙打印机
   strNames connected bluetooth printers' name, Get searched bluetooth printer by delegate function "PrinterFound"
 *
 * 返回:
 *      0 发起连接请求失败
 *      1 发起连接请求成功
 */
-(int) CON_ConnectDevices:(NSString *)port mTimeout:(int)timeout;
/*
 * 关闭端口连接  Close por
 *
 * 参数:
 *      strNames    连接蓝牙打印机的名称，在代理函数”PrinterFound“获取已经搜索到的蓝牙打印机
 *
 * 返回:
 *      0 发起连接请求失败
 *      1 发起连接请求成功
 */
-(int)CON_CloseDevice: (int)objCode;

/*
 * 进入打印模式，连接成功后调用本函数去开启打印功能，调用以"ASCII"为前缀的文本打印函数和以"DRAW_"为前缀的绘图打印函数， 最后调用CON_PageEnd() 结束页面打印文本或图形数据 
 * Enter into printing mode. After connect ok, call this function to open printing function. Call text printing function "ASCII_"" and call picture printing function "DRAW_", and call CON_PageEnd() function to end the printing.
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int)CON_PageStart:(int)objCode graphicMode:(BOOL)graphicMode mWidth:(int)width mHeight:(int)height;

-(int)CON_PageEnd:(int)objCode TM:(TransferMode)tm;
/*
 * 设置打印速度  set printing speed
 *
 * 参数:
 *      ps    PrintSpeed枚举型变量，数值越大，表示打印的速度越快
 * psPrintSpeed is an enum. The bigger the value is, the faster the printer's speed is.
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 * 对特定打印机有效，详细请参考具体打印机说明书
 * printer mode, pls refer to the printer manual.
 */
-(int) CON_SetSpeed:(int)objCode speed:(int)iSpeed;
/*
 * 设置打印浓度 set printing density
 *
 * 返回:
 *      浓度
 */
-(int) CON_SetDensity:(int) objCode iDensity:(int) iDensity;

/*
 * 在画布上创建可旋转区域，本区域坐标必须在画布内，必须在CON_PageStart的第二个参数传递为true，表示进入图形打印模式才有效
 *
 * 返回:
 *      SDK版本
 */
-(int) DRAW_CreateRotalBlock:(int) objCode pos_x:(int) pos_x pos_y:(int) pos_y width:(int) width height:(int) height rotate:(RotatAngle) rotate;
/*
 * 设置打印方向  set printing direction
 *
 * 返回:
 *      SDK版本
 */
-(int) CON_SetPrintDirection:(int) objCode direct:(int) direct;
/*
 * 查询SDK版本  check SDK version
 *
 * 返回:
 *      SDK版本
 */
-(NSString *)CON_QueryVersion;
/*
 * 打印回车换行符
 *
 * 参数:
 *      iTimes  发送回车换行符个数  iTimes returns number of CRLF
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlPrintCRLF:(int) objCode mTimes:(int)iTimes;
/*
 * 控制打印机切纸 control printer cutter
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlCutPaper:(int) objCode cutWay:(int)cutWay postion:(int)postion;
-(int) ASCII_CtrlCutHalfPaper:(int) objCode cutWay:(int)cutWay;
/*
 * 控制打印机黑标定位  control printer blackmark
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlBlackMark:(int) objCode;

#pragma mark -----------打印文本，倍宽、倍高、下划线、小字体不同----------
/*
 * 设置打印字符格式 set printing character format
 */
-(int) ASCII_PrintString:(int) objCode width:(Boolean) width height:(Boolean) height bold:(Boolean) bold underline:(Boolean) underline minifont:(Boolean) minifont mStr:(NSString *)str mEncode:(NSStringEncoding)encode;
/*
 * 标签打印机专用字符串打印函数 lable printer special characters printing function
 */
-(int) ASCII_PrintString:(int) objCode posX:(int) posX posY:(int) posY width:(int) width height:(int) height mStr:(NSString *)str mEncode:(NSStringEncoding)encode;

/*
 * 发送打印字符串至打印机，打印机末尾包含回车换行符或调用ASCII_PrintCRLF()把所有的内容打印出来
 * Send printing characters to printer with CRLF at the end  or call ASCII_PrintCRLF() function to print all contents
 *
 * 参数:
 *      strSend    要打印的字符串   strSend characters will be printed soon
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */

-(int) ASCII_PrintString:(int)objCode mStr:(NSString *)str mEncode:(NSStringEncoding)encode;

/*
 * 直接发送数据缓冲区  send data to buffer directly
 *
 * 参数:
 *      data    十六进制控制命令 hexadecimal control command
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_PrintBuffer:(int)objCode mData:(NSData*) data mLen:(int)len;
/*
 * 打印预存储至打印机的图片
 *
 * 参数:
 *      picNum  十六进制控制命令  picNum hexadecimal control command
 *      mode    图片打印模式 0正常 1倍宽 2倍高 3倍宽高
 *      Picture printig mode 0 nomral,1 double width, 2 double height, 3 double width and double height,
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */

-(int) ASCII_PrintFlashPic:(int)objCode mPicNum:(int )picNum mMode:(int)mode;
/*
 * 打印二维条码  Print 2D barcode
 *
 * 参数:
 *      barcodeType 条码类型
 *      prtstr      打印条码字符串
 *      size        条码大小
 *      ecc         条码ecc校验等级
 *      version     条码版本号
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */

- (int)ASCII_Print2DBarcode:(int)objCode Type:(BarcodeType)type str:(NSString *)str size:(int)size ECC:(int)ecc version:(int)version;

/*
 * 制表位打印  Tab printing
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int)ASCII_PrintTabString:(int)objCode ;
/*
 * 清空打印缓冲区指令和数据  Clear buffer's command and data
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlReset:(int) objCode;
/*
 * 打印机进纸点行
 *
 * 参数:
 *      lienNum 进纸点行数(1mm=8dot)
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlFeedLines:(int)objCode mNum:(int)iNum;
/*
 * 设置打印左边距或宽度  set left margin or width
 *
 * 参数:
 *      leftMargin  左边距
 *      printWidth  打印宽度
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int)ASCII_CtrlPrintPosition:(int)objCode mLeftMargin:(int)iLeftMargin mWidth:(int)iWidth;
/*
 * 设置反色打印 set opposite color printing
 *
 * 参数:
 *      oppositeColor 是否反色打印  opposite color printing or not
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int)ASCII_CtrlOppositeColor:(int)objCode mOpposite:(Boolean) bOpposite;

/*
 * 设置打印行高 set line height
 *
 * 参数:
 *      lineSpace   行与行之间的距离  Space between lines
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlSetLineSpace:(int)objCode mLines:(int)iLines;
/*
 * 设置打印对齐方式  Set Alignment method
 *
 * 参数:
 *      alignType   AlignType变量，表示字符打印的左、中、右字符对齐方式
 *      alignTypeAlignType variable, show printing characters' alignment method
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int)ASCII_CtrlAlignType:(int)objCode mAlignType:(AlignType)alignType;
/*
 * 格式化打印字符串  format printing characters
 *
 * 参数:
 *      doubleWidth     倍宽打印
 *      doubleHeight    倍高打印
 *      bold            打印加粗
 *      underline       下划线
 *      minifont        小字体
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int)ASCII_CtrlFormatString:(int)objCode mWidth:(Boolean)width mHeight:(Boolean)height mBold :(Boolean)bold mUnderLine:(Boolean)underLine mMinifont:(Boolean)minifont;
/*
 * 设置双重打印模式  set double printing mode
 *
 * 参数:
 *      dubPrint    是否为双重打印模式  double printing mode or not
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */
-(int) ASCII_CtrlDuplePrint:(int)objCode mBdup:(Boolean)bdup;

-(int) ASCII_Print1DBarcode:(int) objCode iType:(int) iType posX:(int) posX posY:(int) posY iWidth:(int) iWidth iHeight:(int) iHeight mStrData:(NSString *)strData;
/*
 * 打印条形码  print barcode
 *
 * 参数:
 *      barcodeType     BarcodeType变量，表示打印一维tiaoma类型
 *      barcodeWidth    条码宽度
 *      barcodeHeight   条码高度
 *      textPosition    条码HRI字符打印位置
 *      barcodeString
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 */

-(int) ASCII_Print1DBarcode:(int)objCode mBcType:(BarcodeType)bcType mIwidth:(int)iWidth mIHeight:(int)iHeight mHRI:(Barcode1DHRI)hri mStrData:(NSString *)strData;
/*
 * 查询打印机状态  require printer's status
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 * 注意:
 *      客户端应用程序需要实现代理函数 -(void)PrinterStatus:(int)iCode
 *      Client software needs realize delegate functioin
 *      当iCode值为0表示打印机状态错误，值为1表示打印机状态正常
 *      iCode=0, printer status error; iCode=1, printer status normal
 */
-(int) CON_QueryStatus:(int)objCode;
/*
 * 设置检测标签纸 set label paper detection
 *
 * 发送条码标签页指令，通常在打印处理函数后调用本函数进纸到下一个标签位置 Send barcode label page command. Call this function to feed to next label after printing function.
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 * 注意:
 *      只针对特殊机型 Valid to special printer model
 */
-(int)ASCII_CtrlLabelPage:(int)objCode;
/*
 * 发送钱箱检测命令  Send cash draw detection command
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 * 注意:
 *      只针对特殊机型
 */
-(int)ASCII_CtrlCashDraw:(int) objCode openTime:(int)openTime closeTime:(int) closeTime;////

/*
 * 发送钱箱检测命令
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 * 注意:
 *      只针对特殊机型
 */
-(int)ASCII_CtrlCashDraw:(int)objCode socketpins:(int)socket time1:(int)time1 time2:(int)time2;

/*
 * 页模式下打印机的横向、纵向绝对打印位置  Absolute horizontal and vertical printing position under page printing mode
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 */
-(int)ASCII_CtrlFloatPosition:(int) objCode pos_x:(int) pos_x pos_y:(int)pos_y;

/*
 * 打印图片，必须在CON_PageStart的第二个参数传递为true，表示进入图形打印模式才有效   Picture printing. CON_PageStart's second parameter must be true, which shows it is valid only under picture printing mode
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 */

-(int)DRAW_PrintPicture:(int)objCode bitmap:(UIImage*)bitmap x:(int)x y:(int)y;
/*
 * 绘制表格，必须在CON_PageStart的第二个参数传递为true，表示进入图形打印模式才有效   Draw table. ON_PageStart's second parameter must be true, which shows it is valid only under picture printing mode
 *
 * 返回:
 *      1 操作失败
 *      0 操作成功
 *
 */
-(int)DRAW_Table:(int) objCode x:(int) x y:(int) y width:(int) width height:(int) height row:(int) row column:(int) column :(int)hRow wColumn:(int)wColumn wLine:(int) wLine;
/*
 * 获取目前选择的打印机名称  Get the current printer name
 */
-(NSString *)CON_PrinterName:(NSString *)pName;


//获取所有打印机名称  Get all printers' names
-(NSArray *)CON_AllPrinterName;

#pragma mark =============
-(void)Draw_Circle:(CGContextRef)context rect:(CGRect)rect lineWidth:(int)lineWidth;
-(void)Draw_Picture:(CGContextRef)context rect:(CGRect)rect aImage:(UIImage*)aImage;
-(void)Draw_Line:(CGContextRef)context rect:(CGRect)rect point1:(CGPoint)p1 point2:(CGPoint)p2 lineWidth:(int)lineWidth;
-(void)Draw_Rectangle:(CGContextRef)context rect:(CGRect)rect lineWidth:(int)lineWidth;
-(void)Draw_Triangle:(CGContextRef)context point1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3 lineWidth:(int)lineWidth;
-(void)Draw_String:(CGContextRef)context text:(NSString *)text rect:(CGRect)rect lineWidth:(int)lineWidth font:(int)font;
-(CGContextRef)Create_Canvas:(CGRect)rect size:(CGSize)size;
///
-(UIImage*)Draw_getGrayImage:(UIImage*)sourceImage;

-(int)CON_PrintPicture:(UIImage*)image;

-(void)Draw_Form:(CGContextRef)context width:(int)width lineHeight:(int)lineHeight point_x:(int)pos_x point_y:(int)pos_y array:(NSArray*)array isYes:(NSArray*)isYes align:(AlignType)align vAlign:(VAlignType)vAlign;
- (UIImage*)Draw_rotateImageWithRadian:(float)radius width:(int)width height:(int)height image:(UIImage*)image;

-(int)CON_Pic_start:(int)objCode;
-(int)CON_Pic_end:(int)objCode;

-(void)Draw_Form:(CGContextRef)context width:(int)width lineHeight:(int)lineHeight point_x:(int)pos_x point_y:(int)pos_y array:(NSArray*)array isYes:(NSArray *)isYes;
-(void)Draw_Text:(NSArray *)array align:(AlignType)align vAlign:(VAlignType)vAlign font:(int)font;
#pragma mark-
-(int)ASCII_PrintString:(int)objCode array:(NSArray *)array;
- (int)ASCII_PrintBarcode:(int)objCode type:(BarcodeType)type array:(NSArray *)array;
-(int)ASCII_Init:(int)objCode array:(NSArray *)array;
-(int)ASCII_Enter:(int)objCode array:(NSArray *)array;
-(int)ASCII_End:(int)objCode array:(NSArray *)array;
-(int)ASCII_Area:(int)objCode array:(NSArray *)array;
-(int)ASCII_Position:(int)objCode array:(NSArray *)array;
-(int)Draw_Graphic:(int)objCode array:(NSArray *)array;
-(int)ASCII_Gap:(int)objCode array:(NSArray *)array;

- (int)ASCII_P58A_Print1DBarcode:(int)objCode mBcType:(BarcodeType)bcType mIwidth:(int)iWidth mIHeight:(int)iHeight mHRI:(Barcode1DHRI)hri mStrData:(NSString *)strData;

-(int)ASCII_P58A_CtrlFormatString:(int)objCode mUnderline:(int)underline;
-(int)ASCII_P58A_CtrlFormatString:(int)objCode mHeight:(int)height;
-(int)ASCII_P58A_CtrlFormatString:(int)objCode mWidth:(int)width;

-(int)ASCII_PrintTabPosition:(int)objCode array:(NSArray *)array;

@end
