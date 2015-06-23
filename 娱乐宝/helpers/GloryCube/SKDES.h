//
//  SKDES.h
//  SimpleKit
//
//  Created by SimpleKit on 12-7-31.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface SKDES : NSObject

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
+ (NSString *)decryptUseDES:(NSString *)ciphertext key:(NSString *)key;
+ (NSString *)parseByteArray2HexString:(Byte[]) bytes;
+ (NSString *)stringByBase64EncodingWithData:(NSData *)data;

@end
