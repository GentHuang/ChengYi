//
//  AppDelegate.m
//  TTC_Broadband
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 TTC. All rights reserved.
//

#ifndef ZhiDa_Home_Macros_h
#define ZhiDa_Home_Macros_h
//导航栏高度
#define NAV_HEIGHT_FIRST (400/2)
#define NAV_HEIGHT_ME (400/2)
#define NAV_HEIGHT_USERLOCATE (128/2)
#define NAV_HEIGHT_ORDERRECORD (400/2)
#define NAV_HEIGHT_PROLIB (128/2)
#define NAV_HEIGHT_PRODEL (128/2)
#define NAV_HEIGHT_ACCOUNTINFO (128/2)
#define NAV_HEIGHT_USERDEL (400/2)
#define NAV_HEIGHT_SHOPPINGCAR (128/2)
#define NAV_HEIGHT_SELLCOUNT (400/2)
#define NAV_HEIGHT_SELLDETAIL (346/2)

//状态栏高度
#define STA_HEIGHT (20)
//标签栏高度
#define TAB_HEIGHT (60)
//屏幕宽高
#define SCREEN_MAX_Height [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_WIDTH [UIScreen mainScreen].bounds.size.width
//字体大小
#define FONTSIZES(x) [UIFont systemFontOfSize:(x*1.1)]
#define FONTSIZESBOLD(x)  [UIFont boldSystemFontOfSize:(x*1.1)]
//弹窗
#define ALERT(msg)  [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil \
cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show]
//颜色
#define CLEAR [UIColor clearColor]
#define BLACK [UIColor blackColor]
#define WHITE [UIColor whiteColor]
#define RED   [UIColor redColor]
#define ORANGE [UIColor colorWithRed:255/256.0 green:102/256.0 blue:0/256.1 alpha:1]
#define BLUE  [UIColor colorWithRed:19/256.0 green:125/256.0 blue:204/256.0 alpha:1]
#define LIGHTGRAY     [UIColor colorWithRed:242/256.0 green:242/256.0 blue:248/256.0 alpha:1]
#define LINEGRAY     [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1]
#define LIGHTDARK     [UIColor colorWithRed:71/256.0 green:69/256.0 blue:70/256.0 alpha:1]
#define DARKBLUE [UIColor colorWithRed:71/256.0 green:168/256.0 blue:239/256.0 alpha:1]
#define DRAKGREY [UIColor colorWithRed:217/256.0 green:217/256.0 blue:217/256.0 alpha:1]
#define GREENLIGHT [UIColor colorWithRed:85/256.0 green:175/256.0 blue:73/256.0 alpha:1]
//判断IOS版本
//#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//缓存地址
#define DocumentsDirectory [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Caches"]
//Block
typedef void(^ImageDownloadBlock)(UIImage *image);
typedef void(^StartImageDownloadBlock)(CGFloat process);
typedef void(^DownloadBlock)(CGFloat process,NSString *urlString);

typedef void(^CellIndexTransBlock)(NSInteger sectionIndex,NSInteger rowIndex);
typedef void(^IndexTransBlock)(NSInteger index);
typedef void(^StringTransBlock)(NSString *string);
typedef void(^ButtonPressedBlock)(UIButton *button);
typedef void(^TapPressedBlock)(UITapGestureRecognizer *tap);
typedef void(^SuccessBlock)(NSMutableArray *resultArray);
typedef void(^FailBlock)(NSError *error);
typedef void(^SingleArrayBlock)(NSMutableArray *resultArray);
typedef void(^TextFieldBlock)(UITextField *textField);
#endif
