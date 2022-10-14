//
//  Des.m
//  MD5Demo
//
//  Created by bean on 16/2/28.
//  Copyright © 2016年 com.xile. All rights reserved.
//

#import "Des.h"

//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>

///正式
#define ProKey @"www.jingomall.com"

@implementation Des


/**
 封装好的加密
 */
+(NSString *)DesEncryptWithSting:(NSString *)string{
    
    NSData *strData=[string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptData = [self DESEncrypt:strData WithKey:ProKey];
    
    
//    NSString * hexStr =[self dataToHexString:encryptData];
    NSString * encryptStr=[encryptData base64EncodedStringWithOptions:0];
    
    return encryptStr;
}

/**
 封装好的解密
 */
+(NSString *)DesDecryptWithSting:(NSString *)string{
    
//    NSData *data=[self hexStringToData:string];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    
    NSData *decryptData=[self DESDecrypt:data WithKey:ProKey];
    
    NSString *dataStr= [[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding];
    return dataStr;
}




/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

+(NSString *)dataToHexString:(NSData *)data{
    Byte *bytes=(Byte *)[data bytes];
    NSString *hexStr=@"";
    NSInteger dataLength=[data length];
    for (int i=0; i<dataLength; i++) {
        NSString *newHexStr=[NSString stringWithFormat:@"%x",bytes[i]&0xff];
        if ([newHexStr length]==1) {
            hexStr =[NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }else{
            hexStr=[NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    
    return hexStr;
    
    
}
+(NSData *)hexStringToData:(NSString *)str{
    
    NSString *strTmp=[str stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSInteger lengthTmp=strTmp.length/2;
    SignedByte bytes[lengthTmp];
    
    for (int i=0; i<lengthTmp; i++) {
        int j=i*2;
        NSString *tmp=[strTmp substringWithRange:NSMakeRange(j, 2)];
        unsigned int anTnt;
        NSScanner *scanner=[[NSScanner alloc]initWithString:tmp];
        [scanner scanHexInt:&anTnt];
        bytes[i]=anTnt;
    }
    return [NSData dataWithBytes:bytes length:lengthTmp];
    
}





@end






