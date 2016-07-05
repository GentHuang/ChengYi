//
//  RemotePrinter.h
//  RemotePrinter
//
//  Created by JohnBill on 12-10-29.
//  Copyright (c) 2012年 com. All rights reserved.
//


/*!
 @header RemotePrinter.h
 @abstract <p>
  To use the class to print something, please refer to following steps:
  </p>
  <ol>
  <li>instantize the class</li>
  <li>invoke open() to create the connection</li>
  <li>invoke sendData/recvData</li>
  <li>invoke close() when you finish your process</li>
  </ol>
 @author Jolimark Work Group
 @version 1.00 2012/11/20 Creation
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import "VAR.h"


/*!
 @class RemotePrinter
 @superclass NSObject
 @abstract The class for printer
 @discussion To use the class to print something
 */
@interface RemotePrinter : NSObject
{
    enum TransType FTransType;
    NSString* FTransAddr;
	id MyJmCMD;
	enum PrinterType JmPrinterType;    
}

/*!
@method
@abstract Initialize the object
@discussion We use the class RemotePrinter before , must first initialize it , the communication parameters set
@param transType connection type, Wi-Fi or Bluetooth
@param transAddr target address.  If the Bluetooth mode, the address is the MAC address of the printer's Bluetooth.
       If WIFI mode, this address is printer's IP address and port. For example : 192.168.0.1:9100
 @result id
*/
 -(id)initWithParm:(enum TransType)transType TransAddress: (NSString*)transAddr;


/*!
 @method
 @abstract set the connection type and target address
 @discussion The use of this function, modify the communication mode and communication address
 @param transType connection type, Wi-Fi or Bluetooth
 @param transAddr target address.  If the Bluetooth mode, the address is the MAC address of the printer's Bluetooth.
 If WIFI mode, this address is printer's IP address and port. For example : 192.168.0.1:9100
 @result id
 */
-(void)setTransParm:(enum TransType)transType TransAddress: (NSString*)transAddr;

-(BOOL)createCMD:(enum PrinterType)printerType;

-(void)dealloc;

/*!
 @method
 @abstract Closes the connection.
 @discussion Communication operation is completed, the connection must be closed.Method Open and Method Close are in pairs.
 @result return operation is successful or not
 */
-(BOOL)close;

/*!
 @method
 @abstract Creates the connection from local to remote peinter.
 @discussion Before communication operation, open the connection. Method Open and Method Close are in pairs.
 @result return operation is successful or not
 */
-(BOOL)open;

/*!
 @method
 @abstract Checks if the connection is opened or not.
 @discussion 
 @result return the connection is opened or not.
 */
-(BOOL)isConnected;


/*!
 @method
 @abstract Sends data to the printer.
 @discussion 
 @param data the data which you want to send
 @param len The length of the sending data  
 @result return the number of data have been sent
 */
-(NSInteger)sendData: (uint8_t *)data DataLen: (NSInteger) len;


/*!
 @method
 @abstract Sends data to the printer.
 @discussion
 @param data the data which you want to send
 @result return the number of data have been sent
 */
-(NSInteger)sendNSData: (NSData *)data;



/*!
 @method
 @abstract Receives data from printer.
 @discussion Receives data from printer. the receive buffer must be large enough. 
 @param data the receive buffer
 @result return the number of data have been received
 */
-(NSInteger)recvData: (uint8_t *)data;


/*!
 @method
 @abstract Receives data from printer.
 @discussion Receives data from printer. the size of the buffer  must be large enough than len.
 @param data the receive buffer
 @param len The length of the data which you want to read
 @result return the number of data have been received
 */
-(NSInteger)recvData: (uint8_t *)data Length: (NSInteger) len;





/*!
 @method
 @abstract Receives data from printer.
 @discussion Receives data from printer. 
 @result return the data have been received
 */
-(NSData *)recvNSData;


/*!
 @method
 @abstract Receives data from printer.
 @discussion Receives data from printer. 
 @param len The length of the data which you want to read
 @result return the data have been received
 */
-(NSData *)recvNSData: (NSInteger) len;


/*!
 @method
 @abstract Converts an image to data that printer can accept.
 @discussion Converts an image to data that printer can accept.Support a variety of image formats. For example:png,bmp,jpg.
 @param aFileName srcFileName the file name of image
 @result return data for printing
 */
-(NSData*)ConvertImageWithFile: (NSString *)aFileName;


/*!
 @method
 @abstract Converts an image to data that printer can accept.
 @discussion Converts an image to data that printer can accept.Support a variety of image formats. For example:png,bmp,jpg.
 @param aImageData The data of image
 @result return data for printing
 */
-(NSData*)ConvertImageWithData: (NSData *)aImageData;


/*!
 @method
 @abstract Converts an image to data that printer can accept.
 @discussion Converts an image to data that printer can accept.Support a variety of image formats. For example:png,bmp,jpg.
 @param aUIImage The UIImage
 @result return data for printing
 */
-(NSData*)ConvertImageWithImage: (UIImage *)aUIImage;


/*!
 @method
 @abstract Gets the last error code.
 @discussion 
 @result return error code
 */
-(NSInteger)getLastErrorCode;


@end
