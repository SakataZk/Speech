//
//  NSString+EAMD5.h
//  UI23_加密
//
//  Created by dllo on 16/9/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EAMD5)


- (NSString *)ea_stringByMD5Bit32;

- (NSString *)ea_stringByMD5Bit32Uppercase;

- (NSString *)ea_stringByMD5Bit16;

- (NSString *)ea_stringByMD5Bit16Uppercase;
@end
