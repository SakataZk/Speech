//
//  TalkingCollectionViewCell.m
//  Talking
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "TalkingCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface TalkingCollectionViewCell ()
@property (nonatomic, retain) UIImageView *myImageView;
@end

@implementation TalkingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_myImageView];
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_myImageView];
    }
    return self;
}

-(void)setImageString:(NSString *)imageString {
    if (_imageString != imageString) {
        _imageString = imageString;
        NSURL *url = [NSURL URLWithString:_imageString];
        [_myImageView sd_setImageWithURL:url];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _myImageView.frame = self.contentView.bounds;
}
@end
