//
//  HotTopicLabel.m
//  Talking
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "HotTopicLabel.h"

@implementation HotTopicLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.text = @"";
        self.textColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


@end
