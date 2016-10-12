//
//  TalkingHomeView.m
//  Talking
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TalkingHomeView.h"

@interface TalkingHomeView ()

@property (nonatomic, retain) UIButton *userInfoButton;
@property (nonatomic, retain) UIButton *searchButton;

@end


@implementation TalkingHomeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userInfoButton.backgroundColor = [UIColor redColor];
        [self addSubview:_userInfoButton];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.backgroundColor =  [UIColor cyanColor];
        [self addSubview:_searchButton];
        
        
    }
    return self;
}




- (void)layoutSubviews {
    [super layoutSubviews];
    _userInfoButton.frame = CGRectMake(0, 0, self.width * 0.2, self.height);
    _searchButton.frame = CGRectMake(self.width * 0.8, 0, self.width * 0.2, self.height);

}



@end
