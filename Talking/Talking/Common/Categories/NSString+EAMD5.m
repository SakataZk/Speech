//
//  NSString+EAMD5.m
//  UI23_加密
//
//  Created by dllo on 16/9/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "NSString+EAMD5.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (EAMD5)

- (NSString *)ea_stringByMD5Bit32 {
    const char *cString = [self UTF8String];
    CC_LONG length = (CC_LONG)strlen(cString);
    unsigned char finalString[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, length, finalString);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",finalString[i]];
    }
    return  result;
}
- (NSString *)ea_stringByMD5Bit32Uppercase {
    return [[self ea_stringByMD5Bit32] uppercaseString];
}
- (NSString *)ea_stringByMD5Bit16 {
    NSString *md5_32BitString = [self ea_stringByMD5Bit32];
    NSString *md5_16BitString = [md5_32BitString substringWithRange:NSMakeRange(8, 16)];
    return md5_16BitString;
}
- (NSString *)ea_stringByMD5Bit16Uppercase {
    return [[self ea_stringByMD5Bit16] uppercaseString];
}



@end
