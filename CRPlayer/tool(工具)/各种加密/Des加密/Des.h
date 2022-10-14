//
//  Des.h
//  MD5Demo
//
//  Created by bean on 16/2/28.
//  Copyright © 2016年 com.xile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Des : NSObject

/**
 封装好的加密
 */
+(NSString *)DesEncryptWithSting:(NSString *)string;
/**
 封装好的解密
 */
+(NSString *)DesDecryptWithSting:(NSString *)string;


///**DES加密*/
//+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;
///**DES解密*/
//+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
//
//+(NSString *)dataToHexString:(NSData *)data;
//
//+(NSData *)hexStringToData:(NSString *)str;



@end



