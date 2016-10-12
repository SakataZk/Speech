//
//  ActivityTableViewCell.m
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//



#import "ActivityTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ActivityTableViewCell()

@property (nonatomic, strong) UIImageView *activityImageView;

@end



@implementation ActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.activityImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _activityImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_activityImageView];
        
    }

    return self;
}


- (void)setImageUrl:(NSString *)imageUrl {
    if (_imageUrl != imageUrl) {
        _imageUrl = imageUrl;
        NSURL *url = [NSURL URLWithString:_imageUrl];
        [_activityImageView sd_setImageWithURL:url];
    }
}
- (void) layoutSubviews {
    [super layoutSubviews];
    self.activityImageView.frame = CGRectMake(0, 0, self.width, self.height);

}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
