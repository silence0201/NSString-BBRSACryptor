//
//  NSString+BBRSACryptor.h
//  BBRSACryptorDemo
//
//  Created by Silence on 2017/5/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GenerateKey)

/// 生成公钥和私钥
+ (void)generatePublicAndPrivateKey ;
/// RSAKey的目录
+ (NSString *)RSAKeyDir ;
/// 公钥的路径
+ (NSString *)RSAPublicKeyFilePath ;
/// 私钥的路径
+ (NSString *)RSAPrivateKeyFilePath ;

@end

@interface NSString (RSAKeyString)

/// 公钥加密
+ (NSString *)encryptString:(NSString *)string publicKey:(NSString *)publicKey;
/// 公钥加密
- (NSString *)encryptWithPublicKey:(NSString *)publicKey ;

/// 公钥解密
+ (NSString *)decodeString:(NSString *)string publicKey:(NSString *)publicKey ;
/// 公钥解密
- (NSString *)decodeWithPublicKey:(NSString *)publicKey ;

/// 私钥加密
+ (NSString *)encryptString:(NSString *)string privateKey:(NSString *)privateKey ;
/// 私钥加密
- (NSString *)encryptWithPrivateKey:(NSString *)privateKey ;

/// 私钥解密
+ (NSString *)decodingString:(NSString *)string privateKey:(NSString *)privateKey;
/// 私钥解密
- (NSString *)decodeWithPrivateKey:(NSString *)privateKey ;

/// 私钥签名
+ (NSString *)singString:(NSString *)string privateKey:(NSString *)privateKey;
/// 私钥签名
- (NSString *)singWithPrivateKey:(NSString *)privateKey ;

/// 私钥签名MD5
+ (NSString *)singMD5String:(NSString *)string privateKey:(NSString *)privateKey;
/// 私钥签名MD5
- (NSString *)singMD5WithPrivateKey:(NSString *)privateKey ;

/// RSA验证签名
+ (BOOL)verifyString:(NSString *)string sign:(NSString *)signString publicKey:(NSString *)publicKey;
/// RSA验证签名
- (BOOL)verifySign:(NSString *)signString publicKey:(NSString *)publicKey ;

/// RSA MD5 验证签名
+ (BOOL)verifyMD5String:(NSString *)string sign:(NSString *)signString publicKey:(NSString *)publicKey;
/// RSA MD5 验证签名
- (BOOL)verifyMD5Sign:(NSString *)signString publicKey:(NSString *)publicKey ;

@end
