//
//  TitleCollectionCell.m
//  Talking
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TitleCollectionCell.h"

@interface TitleCollectionCell ()



@end

@implementation TitleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.text = @"";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_label];
    }
    return self;
}
- (void)setText:(NSString *)text {
    if (_text != text) {
        _label.text = text;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.contentView.bounds;
}


@end
