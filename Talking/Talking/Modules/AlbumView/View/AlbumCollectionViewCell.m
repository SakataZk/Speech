//
//  AlbumCollectionViewCell.m
//  Talking
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "AlbumCollectionViewCell.h"
#import "AlbumModel.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@interface AlbumCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation AlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.1, self.height * 0.1, self.width * 0.8, self.width * 0.8)];
        _imageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _imageView.layer.shadowOffset = CGSizeMake(3,2);
        _imageView.layer.shadowOpacity = 0.6;
        _imageView.layer.shadowRadius = 1.0;
        _imageView.clipsToBounds = NO;
        [self.contentView addSubview:_imageView];

        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.15, self.height * 0.6 , self.width * 0.7, self.height * 0.25)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor lightGrayColor];
        
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)setModel:(AlbumModel *)model {
    if (_model != model) {
        
        NSURL *url = [NSURL URLWithString:model.pictureSmall];
        [_imageView sd_setImageWithURL:url];
//        if (model.template == 6) {
//            _textLabel.frame = CGRectMake(self.width * 0.15, self.height * 0.1, self.width * 0.7, self.height * 0.76);
//        }
        _textLabel.text = [NSString stringWithFormat:@"%@",model.text];
        
    }






}





@end
