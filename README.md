# NSString-BBRSACryptor
## 介绍

使用OpenSSL进行公钥和私钥的解密和解密,并且对私钥签名,公钥验证

1.加密:客户端使用公钥加密数据,服务器端使用私钥解密数据(主要实现数据加密)。  
2.加签:客户端用私钥加签,服务器端用公钥验签(主要为了防止别人模拟我们的客户端来攻击我们的服务器,导致瘫痪)。

#### 1. 公钥私钥生成,保存
* 客户端生成一对公钥私钥,假如叫公钥K、私钥K,服务器生成一对公钥私钥,假如叫公钥F、私钥F.
* 客服端把公钥K发给服务器,服务器保存公钥K,服务器把公钥F 发给客服端,客服端保存公钥F.(公钥都发给对方,自己保留私钥)
    
#### 2. 加密交互流程
* 客服端用公钥F加密数据,服务器接收后,用私钥F解密.<br>
* 服务器用公钥K加密数据,客服端接收后,用私钥k解密.

#### 3.签名交互流程
* 客服端用私钥K签名,服务器用公钥K验证签名

## 代码使用
### 添加到你的工程

```
pod 'NSString+BBRSACryptor'
```

### 导入头文件

```objective-c
#import "NSString+BBRSACryptor.h"
```

### 使用
```objective-c
/// 生成公钥和私钥
+ (void)generatePublicAndPrivateKey ;

/// 公钥加密
+ (NSString *)encryptString:(NSString *)string publicKey:(NSString *)publicKey;

/// 公钥解密
+ (NSString *)decodeString:(NSString *)string publicKey:(NSString *)publicKey ;

/// 私钥签名
+ (NSString *)singString:(NSString *)string privateKey:(NSString *)privateKey;

/// 私钥签名MD5
+ (NSString *)singMD5String:(NSString *)string privateKey:(NSString *)privateKey;

/// RSA验证签名
+ (BOOL)verifyString:(NSString *)string sign:(NSString *)signString publicKey:(NSString *)publicKey;

/// RSA MD5 验证签名
+ (BOOL)verifyMD5String:(NSString *)string sign:(NSString *)signString publicKey:(NSString *)publicKey;
```

## NSString-BBRSACryptor
NSString-BBRSACryptor is available under the MIT license. See the LICENSE file for more info.

