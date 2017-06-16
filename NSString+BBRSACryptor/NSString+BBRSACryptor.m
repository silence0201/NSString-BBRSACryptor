//
//  NSString+BBRSACryptor.m
//  BBRSACryptorDemo
//
//  Created by Silence on 2017/5/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "NSString+BBRSACryptor.h"
#import "BBRSACryptor.h"
#import "GTMBase64.h"

@implementation NSString (GenerateKey)

+ (void)generatePublicAndPrivateKey {
    BBRSACryptor *reaCryptor = [[BBRSACryptor alloc]init] ;
    [reaCryptor generateRSAKeyPairWithKeySize:1024] ;
}

+ (NSString *)RSAKeyDir {
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    return [documentDir stringByAppendingPathComponent:@".openssl_rsa"] ;
}

+ (NSString *)RSAPrivateKeyFilePath {
    return [[self RSAKeyDir] stringByAppendingPathComponent:@"bb.publicKey.pem"] ;
}

+ (NSString *)RSAPublicKeyFilePath {
    return [[self RSAKeyDir] stringByAppendingPathComponent:@"bb.privateKey.pem"] ;
}

@end

@implementation NSString (RSAKeyPEMData)

+ (NSString *)encryptString:(NSString *)string publicKeyPEMData:(NSData *)publicKey
{
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyPEMData:publicKey])
    {
        NSData *cipherData = [rsaCryptor encryptWithPublicKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 plainData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *cipherString = [GTMBase64 stringByEncodingData:cipherData];
        return cipherString;
    }
    return nil;
}

- (NSString *)encryptWithPublicKeyPEMData:(NSData *)publicKey {
    return [NSString encryptString:self publicKeyPEMData:publicKey] ;
}

+ (NSString *)decodeString:(NSString *)string publicKeyPEMData:(NSData *)publicKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyPEMData:publicKey])
    {
        NSData *cipherData = [GTMBase64 decodeString:string];
        NSData *plainData =  [rsaCryptor decryptWithPublicKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 cipherData:cipherData];
        NSString *plainStr = [[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding];
        return plainStr;
    }
    return nil;
}

- (NSString *)decodeWithPublicKeyPEMData:(NSData *)publicKey {
    return [NSString decodeString:self publicKeyPEMData:publicKey] ;
}

+ (NSString *)encryptString:(NSString *)string privateKeyPEMData:(NSData *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyPEMData:privateKey])
    {
        NSData *cipherData = [rsaCryptor encryptWithPrivateKeyUsingPadding:RSA_PKCS1_PADDING plainData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *cipherString = [GTMBase64 stringByEncodingData:cipherData];
        return cipherString;
    }
    return nil;
}

- (NSString *)encryptWithPrivateKeyPEMData:(NSData *)privateKey {
    return [NSString encryptString:self privateKeyPEMData:privateKey] ;
}

+ (NSString *)decodingString:(NSString *)string privateKeyPEMData:(NSData *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyPEMData:privateKey])
    {
        NSData *cipherData = [GTMBase64 decodeString:string];
        NSData *plainData = [rsaCryptor decryptWithPrivateKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 cipherData:cipherData];
        NSString *plainText = [[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding];
        return plainText;
    }
    return nil;
}

- (NSString *)decodeWithPrivateKeyPEMData:(NSData *)privateKey {
    return [NSString decodingString:self privateKeyPEMData:privateKey] ;
}

+ (NSString *)singString:(NSString *)string privateKeyPEMData:(NSData *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyPEMData:privateKey])
    {
        NSData *plainData = [rsaCryptor signWithPrivateKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_SHA1 plainData:[string dataUsingEncoding:NSUTF8StringEncoding]] ;
        NSString *sing = [plainData base64EncodedStringWithOptions:0] ;
        return sing;
    }
    return nil;
}

- (NSString *)singWithPrivateKeyPEMData:(NSData *)privateKey {
    return [NSString singString:self privateKeyPEMData:privateKey] ;
}

+ (NSString *)singMD5String:(NSString *)string privateKeyPEMData:(NSData *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyPEMData:privateKey])
    {
        NSData *plainData = [rsaCryptor signWithPrivateKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_MD5 plainData:[string dataUsingEncoding:NSUTF8StringEncoding]] ;
        NSString *sing = [plainData base64EncodedStringWithOptions:0] ;
        return sing;
    }
    return nil;
}

- (NSString *)singMD5WithPrivateKeyPEMData:(NSData *)privateKey {
    return [NSString singMD5String:self privateKeyPEMData:privateKey];
}

+ (BOOL)verifyString:(NSString *)string sign:(NSString *)signString publicKeyPEMData:(NSData *)publicKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyPEMData:publicKey])
    {
        NSData *signatureData = [[NSData alloc]initWithBase64EncodedString:signString options:0];
        NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding] ;
        return [rsaCryptor verifyWithPublicKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_SHA1 signData:signatureData plainData:plainData] ;
    }
    return NO;
}

+ (BOOL)verifyMD5String:(NSString *)string sign:(NSString *)signString publicKeyPEMData:(NSData *)publicKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyPEMData:publicKey])
    {
        NSData *signatureData = [[NSData alloc]initWithBase64EncodedString:signString options:0];
        NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding] ;
        return [rsaCryptor verifyWithPublicKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_MD5 signData:signatureData plainData:plainData] ;
    }
    return NO;
}

- (BOOL)verifySign:(NSString *)signString publicKeyPEMData:(NSData *)publicKey {
    return [NSString verifyString:self sign:signString publicKeyPEMData:publicKey] ;
}

- (BOOL)verifyMD5Sign:(NSString *)signString publicKeyPEMData:(NSData *)publicKey {
    return [NSString verifyMD5String:self sign:signString publicKeyPEMData:publicKey] ;
}


@end

@implementation NSString (RSAKeyString)

+ (NSString *)encryptString:(NSString *)string publicKey:(NSString *)publicKey
{
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyBase64:publicKey])
    {
        NSData *cipherData = [rsaCryptor encryptWithPublicKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 plainData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *cipherString = [GTMBase64 stringByEncodingData:cipherData];
        return cipherString;
    }
    return nil;
}

- (NSString *)encryptWithPublicKey:(NSString *)publicKey {
    return [NSString encryptString:self publicKey:publicKey] ;
}

+ (NSString *)decodeString:(NSString *)string publicKey:(NSString *)publicKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyBase64:publicKey])
    {
        NSData *cipherData = [GTMBase64 decodeString:string];
        NSData *plainData =  [rsaCryptor decryptWithPublicKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 cipherData:cipherData];
        NSString *plainStr = [[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding];
        return plainStr;
    }
    return nil;
}

- (NSString *)decodeWithPublicKey:(NSString *)publicKey {
    return [NSString decodeString:self publicKey:publicKey] ;
}

+ (NSString *)encryptString:(NSString *)string privateKey:(NSString *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyBase64:privateKey])
    {
        NSData *cipherData = [rsaCryptor encryptWithPrivateKeyUsingPadding:RSA_PKCS1_PADDING plainData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *cipherString = [GTMBase64 stringByEncodingData:cipherData];
        return cipherString;
    }
    return nil;
}

- (NSString *)encryptWithPrivateKey:(NSString *)privateKey {
    return [NSString encryptString:self privateKey:privateKey] ;
}

+ (NSString *)decodingString:(NSString *)string privateKey:(NSString *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyBase64:privateKey])
    {
        NSData *cipherData = [GTMBase64 decodeString:string];
        NSData *plainData = [rsaCryptor decryptWithPrivateKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 cipherData:cipherData];
        NSString *plainText = [[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding];
        return plainText;
    }
    return nil;
}

- (NSString *)decodeWithPrivateKey:(NSString *)privateKey {
    return [NSString decodingString:self privateKey:privateKey] ;
}

+ (NSString *)singString:(NSString *)string privateKey:(NSString *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyBase64:privateKey])
    {
        NSData *plainData = [rsaCryptor signWithPrivateKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_SHA1 plainData:[string dataUsingEncoding:NSUTF8StringEncoding]] ;
        NSString *sing = [plainData base64EncodedStringWithOptions:0] ;
        return sing;
    }
    return nil;
}

- (NSString *)singWithPrivateKey:(NSString *)privateKey {
    return [NSString singString:self privateKey:privateKey] ;
}

+ (NSString *)singMD5String:(NSString *)string privateKey:(NSString *)privateKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPrivateKeyBase64:privateKey])
    {
        NSData *plainData = [rsaCryptor signWithPrivateKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_MD5 plainData:[string dataUsingEncoding:NSUTF8StringEncoding]] ;
        NSString *sing = [plainData base64EncodedStringWithOptions:0] ;
        return sing;
    }
    return nil;
}

- (NSString *)singMD5WithPrivateKey:(NSString *)privateKey {
    return [NSString singMD5String:self privateKey:privateKey];
}

+ (BOOL)verifyString:(NSString *)string sign:(NSString *)signString publicKey:(NSString *)publicKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyBase64:publicKey])
    {
        NSData *signatureData = [[NSData alloc]initWithBase64EncodedString:signString options:0];
        NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding] ;
        return [rsaCryptor verifyWithPublicKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_SHA1 signData:signatureData plainData:plainData] ;
    }
    return NO;
}

+ (BOOL)verifyMD5String:(NSString *)string sign:(NSString *)signString publicKey:(NSString *)publicKey {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    if([rsaCryptor importRSAPublicKeyBase64:publicKey])
    {
        NSData *signatureData = [[NSData alloc]initWithBase64EncodedString:signString options:0];
        NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding] ;
        return [rsaCryptor verifyWithPublicKeyUsingDigest:RSA_SIGN_DIGEST_TYPE_MD5 signData:signatureData plainData:plainData] ;
    }
    return NO;
}

- (BOOL)verifySign:(NSString *)signString publicKey:(NSString *)publicKey {
    return [NSString verifyString:self sign:signString publicKey:publicKey] ;
}

- (BOOL)verifyMD5Sign:(NSString *)signString publicKey:(NSString *)publicKey {
    return [NSString verifyMD5String:self sign:signString publicKey:publicKey] ;
}


@end
