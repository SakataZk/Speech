//
//  TalkingTextCollectionViewCell.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TalkingTextCollectionViewCell.h"

@implementation TalkingTextCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        _label.text = @"";
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}
-(void)setTitleText:(NSString *)titleText {
    if (_titleText != titleText) {
        _label.text = titleText;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}


@end
