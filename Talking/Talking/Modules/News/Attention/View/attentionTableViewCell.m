//
//  attentionTableViewCell.m
//  Talking
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "attentionTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Categories.h"
#import "attentionModel.h"

@interface attentionTableViewCell ()

@property (nonatomic, strong) UIImageView *headImage;

@property (nonatomic, strong) UILabel *attentionLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *albumImageView;

@end


@implementation attentionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImage = [[UIImageView alloc] initWithFrame: CGRectZero];
        [self.contentView addSubview:_headImage];
        
        
        self.attentionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _attentionLabel.textColor = [UIColor lightGrayColor];
        _attentionLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_attentionLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_timeLabel];
        
        self.albumImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_albumImageView];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _headImage.frame = CGRectMake(self.width * 0.03, self.width * 0.03, self.height - self.width * 0.06, self.height - self.width * 0.06);
    _headImage.layer.cornerRadius = (self.height - self.width * 0.06) / 2;
    _headImage.clipsToBounds = YES;
    _attentionLabel.frame = CGRectMake(_headImage.x * 2 + _headImage.width , _headImage.y, self.width * 0.7, _headImage.height / 5);
    _timeLabel.frame = CGRectMake(_attentionLabel.x, _attentionLabel.y + _attentionLabel.height * 2, _attentionLabel.width, _attentionLabel.height);
    _albumImageView.frame = CGRectMake(_attentionLabel.x + _attentionLabel.width, _attentionLabel.y, _headImage.width, _headImage.height);
}
-(void)setModel:(attentionModel *)model {

    if (_model != model) {
        _model = model;
        NSURL *headUrl = [NSURL URLWithString:_model.userCoverSmall];
        [_headImage sd_setImageWithURL:headUrl];

        _attentionLabel.text = [NSString stringWithFormat:@"%@ 关注了「 %@ 」",_model.uname, _model.albumName];
        _timeLabel. text = [NSDate intervalSinceNow:_model.createTime];
        NSURL *albumUrl = [NSURL URLWithString:_model.albumCover];
        [_albumImageView sd_setImageWithURL:albumUrl];
    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
