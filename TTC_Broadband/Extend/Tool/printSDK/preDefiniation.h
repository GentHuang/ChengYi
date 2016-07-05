//
//  preDefiniation.h
//  printSDK
//
//  Created by wang lipeng on 14-9-23.
//  Copyright (c) 2014年 wang lipeng. All rights reserved.
//

#ifndef printSDK_preDefiniation_h
#define printSDK_preDefiniation_h

/*
 * 打印文本对齐方式  printing text align method
 */
typedef enum {
    AT_LEFT,
    AT_CENTER,
    AT_RIGHT
}AlignType;

/*
 * 垂直对齐方式  vertical align
 */
typedef enum {
    VT_TOP,
    VT_MIDDLE,
    VT_BOTTOM
}VAlignType;


/*
 * 条码打印类型  barcode printing type
 */
typedef enum  {
    BT_UPCA    = 65,
    BT_UPCE    = 66,
    BT_EAN13   = 67,
    BT_EAN8    = 68,
    BT_CODE39  = 69,
    BT_CODEITF     = 70,
    BT_CODEBAR = 71,
    BT_CODE93  = 72,
    BT_CODE128 = 73,
    BT_QRcode          = 97,
    BT_DATAMATIC  = 98,
    BT_PDF417      = 99
}BarcodeType;
/*
 * 条码字符打印位置 barcode text printing position
 */
typedef enum {
    BH_NO,
    BH_UNDER,
    BH_BLEW
}Barcode1DHRI;

typedef enum {
    BW_1,
    BW_2,
    BW_3,
    BW_4
}Barcode1DWidth;
/*
 *图像选区旋转角度   rotation angle of picture selected area
 */
typedef enum {
    RA_0,
    RA_90,
    RA_180,
    RA_270
} RotatAngle;


/*!
 * 打印速度（打印速度，_PS_SPEED_DEFAULT 由系统决定打印速度快慢） Printing speed (printing speed,_PS_SPEED_DEFAULT determin the printing speed by system)
 * _PS_SPEED_1 最低 _PS_SPEED_5 最高   Fastest _PS_SPEED_5 slowest
 */
typedef enum {
    _PS_SPEED_DEFAULT=0,
    _PS_SPEED_1,
    _PS_SPEED_2,
    _PS_SPEED_3,
    _PS_SPEED_4,
    _PS_SPEED_5,
    _PS_SPEED_6,
    _PS_SPEED_7,
    _PS_SPEED_8,
    _PS_SPEED_9,
    _PS_SPEED_10
}PrintSpeed;

/*
 * 打印接口类型  Printing interface type
 */
typedef enum {
    _PT_BLUETOOTH,
    _PT_WIFI
}PrintType;

/*
 * 打印机型号，目前就这一种  Printer model, only this model currently
 */
typedef enum {
    _PM_TP58B,
    _PM_WP200
} PrintModule;
/*
 * 页模式下的打印方式  Printing method under page mode
 */

typedef enum {
    PM_GRAPHIC,
    PM_TEXT
}PageMode;

/*!
 * 打印机状态  Printer status
 */
typedef enum {
    PS_ERROR,
    PS_OK,
    PS_PAPAEROUT,
    PS_UNKNOW
}PrinterStatus;

typedef enum {
    TM_NONE,
    TM_DT_V1,
    TM_DT_V2
    
}TransferMode;
#endif
