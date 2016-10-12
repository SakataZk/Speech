//
//  ClassCollectionCell.m
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "ClassCollectionCell.h"

@interface ClassCollectionCell ()

@property (nonatomic ,strong) UILabel *classLabel;

@property (nonatomic, strong) UIImageView *classImageView;

@property (nonatomic, strong) UILabel *textLabel;


@end

@implementation ClassCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * 0.08 , self.width * 0.25, self.height * 0.06)];
        _classLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_classLabel];
        
        self.classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.1 , _classLabel.y + _classLabel.height * 2, self.width * 0.8, self.width * 0.8)];
        _classImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_classImageView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(_classImageView.x, _classImageView.y + _classImageView.height, _classImageView.width, self.height - _classImageView.y - _classImageView.height)];
        _textLabel.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_textLabel];
        
        
    }
    return self;
}











@end
