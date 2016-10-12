//
//  ResultTableViewCell.m
//  Talking
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "ResultsModel.h"
#import "UIImageView+WebCache.h"

@interface ResultTableViewCell ()


@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@end



@implementation ResultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = ( SCREEN_HEIGHT * 0.1 - 5 ) / 2;
        _headImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
    }




    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(5, 5, SCREEN_HEIGHT * 0.1 - 10, SCREEN_HEIGHT * 0.1 - 10);
    _nameLabel.frame = CGRectMake(_headImageView.x * 2 + _headImageView.width, 0, self.width - (_headImageView.x * 2 + _headImageView.width), _headImageView.height);
    _nameLabel.centerY = _headImageView.centerY;
}

- (void)setResultModel:(ResultsModel *)resultModel {
    if (_resultModel != resultModel) {
        NSURL *url = [NSURL URLWithString:resultModel.image];
        [_headImageView sd_setImageWithURL:url];
        if (resultModel.type == 2) {
            _nameLabel.text = resultModel.name;
        } else {
            _nameLabel.text = [NSString stringWithFormat:@"「 %@ 」",resultModel.name];
        }
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
