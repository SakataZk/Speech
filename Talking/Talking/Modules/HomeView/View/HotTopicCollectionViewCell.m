//
//  HotTopicCollectionViewCell.m
//  
//
//  Created by dllo on 16/9/22.
//
//

#import "HotTopicCollectionViewCell.h"

@interface HotTopicCollectionViewCell ()

@property (nonatomic, retain)UIImageView *hotTopicImageView;
@property (nonatomic, retain)UILabel *label;
@end


@implementation HotTopicCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        self.hotTopicImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_hotTopicImageView];
        
        self.label = [[UILabel alloc] init];
        _label.size = CGSizeMake(_hotTopicImageView.width, 200);
        _label.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_label];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _hotTopicImageView.frame = CGRectMake(self.contentView.x, self.contentView.y, self.contentView.width, self.contentView.height - _label.height);
    _label.frame = CGRectMake(0, _hotTopicImageView.frame.origin.y + _hotTopicImageView.frame.size.height, _hotTopicImageView.frame.size.width, 1000);
}
- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _hotTopicImageView.image = image;
    }
}









@end
