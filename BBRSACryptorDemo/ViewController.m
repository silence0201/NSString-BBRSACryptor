//
//  ViewController.m
//  BBRSACryptorDemo
//
//  Created by Silence on 2017/5/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "NSString+BBRSACryptor.h"
#import <BBRSACryptor/BBRSACryptor.h>

//公钥 (请替换)
#define RSAPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC2jwfgvEvKbEfzMOatwlagzISSYTcxl/PQHAtjs5qHMUadVwconH7sPuRHuN4FtpXFsxTMFdedW5r9wV0pHZ21HG4fqEctDxGe8epwxe/XP8hZ0nrYjOTD85bNcdC9YLqsM0ueiZsKC/zOZ2N1yZYYVu1CGVsJwCiAvGfGI1QQGwIDAQAB"

//私钥 (请替换)
#define RSAPrivateKey  @"MIICXgIBAAKBgQC2jwfgvEvKbEfzMOatwlagzISSYTcxl/PQHAtjs5qHMUadVwconH7sPuRHuN4FtpXFsxTMFdedW5r9wV0pHZ21HG4fqEctDxGe8epwxe/XP8hZ0nrYjOTD85bNcdC9YLqsM0ueiZsKC/zOZ2N1yZYYVu1CGVsJwCiAvGfGI1QQGwIDAQABAoGBAKJtZC76mdyCtwmTassS7AypqxKqWHdRoWZ6bU/KDyVWHGQFeKMTioIb+vQtca1XpK6ABXMHxA2H4cEA+CiK5zMqX/2Ma0EZfQkB4OebxG48LSoOPsKjxg6usCCcsP8alXYuu7Wny2ZG2fsncGHHI8TVOBVRrK+w0Lwae5CSVaZRAkEA2mJQswbnOYHB/UoClinvzmjvxjQziFnPQw4nLcxgDctFIADzvt0m4OEhb/Mi3DDW7rQMginA46ym6FT5o+6aJQJBANYA/bIVlVb8/KZUeKH03y13PDKt0DvZXXUD09wrgnWOB9SrI3U46a66n3/kZhs7h6pj9cGcoYNQeq0G/jSTTT8CQQCQ2uvqhGa1h3N0njXvAyw0/vgkwZV5GRFYyjeEsm74V1+npdoIPUs/mTWDu4PhCGhY94bgg++VVX102ICqk2cdAkBA99wNDHBiEDvDYzGcOXLnoqMr34iwIrU0qQzQcoUQmyXVcn85PyXyXcW+VeCJs/Dj0aTyOlLuQqh7jvvtiiqRAkEApkO4RP9LP4tnoUoIMbP07j7HMYDIFpvBO3laXDT9o3cXZaG3g4kAmHvMwTllHtuqo8jCpWklBORSrCFK+pMF9w=="

@interface ViewController ()

@property (nonatomic,strong) BBRSACryptor *rsaCryptor ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rsaCryptor = [[BBRSACryptor alloc]init] ;
    [self.rsaCryptor importRSAPublicKeyBase64:RSAPublicKey] ;
    [self.rsaCryptor importRSAPrivateKeyBase64:RSAPrivateKey] ;
    
    
    // 创建密钥
    [NSString generatePublicAndPrivateKey] ;
    
    NSString *str = [NSString encryptString:@"你好" publicKey:RSAPublicKey] ;
    NSLog(@"公钥加密:%@",str);
    NSString *s = [str decodeWithPrivateKey:RSAPrivateKey] ;
    NSLog(@"私钥解密:%@",s) ;
    
    NSString *sign = [NSString singString:@"sign1" privateKey:RSAPrivateKey] ;
    NSLog(@"%@",sign);
    
    NSString *sign2 = [NSString singMD5String:@"sign2" privateKey:RSAPrivateKey] ;
    NSLog(@"%@",sign2) ;
    
    
    BOOL v1 = [NSString verifyString:@"sign1" sign:sign publicKey:RSAPublicKey] ;
    if (v1){
        NSLog(@"sign1验证通过") ;
    }
    
    BOOL v2 = [NSString verifyMD5String:@"sign2" sign:sign2 publicKey:RSAPublicKey] ;
    if (v2){
        NSLog(@"sign2验证通过") ;
    }
    
    
}


@end
