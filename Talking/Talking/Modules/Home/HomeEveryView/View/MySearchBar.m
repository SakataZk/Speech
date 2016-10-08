//
//  MySearchBar.m
//  Talking
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "MySearchBar.h"

@implementation MySearchBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.9098 green:0.9059 blue:0.9176 alpha:1.0];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"search"];
        
        leftView.width = leftView.image.size.width ;
        leftView.height = leftView.image.size.height ;
        leftView.contentMode = UIViewContentModeCenter;
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.placeholder = @"搜索言集、用户";
        
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}



@end
