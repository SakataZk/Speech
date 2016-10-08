
//
//  ResultsModel.m
//  Talking
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "ResultsModel.h"

@implementation ResultsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.allid = value;
        return;
    }
    [super setValue:value forUndefinedKey:key];

}



@end
