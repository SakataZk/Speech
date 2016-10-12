//
//  CommentTableViewCell.m
//  Talking
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentModel.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Categories.h"


@interface CommentTableViewCell ()

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *albumView;

@property (nonatomic, strong) UIImageView *albumImageView;

@property (nonatomic, strong) UILabel *albumLabel;
@end



@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.view = [[UIView alloc] init];
        _view.layer.borderWidth = 0.5;
        _view.layer.borderColor =[[UIColor grayColor] CGColor];
        _view.layer.cornerRadius = 5;
        _view.clipsToBounds = YES;
        [self.contentView addSubview:_view];
        
        self.headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor redColor];
        [_view addSubview:_headImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        _nameLabel.font = [UIFont systemFontOfSize:15.f];
        _nameLabel.textColor = [UIColor lightGrayColor];
        [_view addSubview:_nameLabel];
        
        self.commentLabel = [[UILabel alloc] init];
        _commentLabel.text = @"";
        _commentLabel.font = [UIFont systemFontOfSize:15.f];
        _commentLabel.textColor = [UIColor lightGrayColor];
        [_view addSubview:_commentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"";
        _timeLabel.font = [UIFont systemFontOfSize:12.f];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [_view addSubview:_timeLabel];
        
        self.albumView = [[UIView alloc] init];
        _albumView.backgroundColor = [UIColor colorWithRed:0.9098 green:0.9098 blue:0.9373 alpha:1.0];
        [_view addSubview:_albumView];
        
        self.albumImageView = [[UIImageView alloc] init];
        [_albumView addSubview:_albumImageView];
        
        self.albumLabel = [[UILabel alloc] init];
        _albumLabel.text = @"";
        _albumLabel.textColor = [UIColor lightGrayColor];
        [_albumView addSubview:_albumLabel];
        
    }


    return self;

}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _view.frame = CGRectMake(10, 5, self.width - 10 * 2, self.height - 5 * 2);
    
    _headImageView.frame = CGRectMake(_view.height * 0.07, _view.height * 0.07, _view.height * 0.25, _view.height * 0.25);
    _headImageView.layer.cornerRadius = _view.height * 0.25 / 2;
    _headImageView.clipsToBounds = YES;
    
    _nameLabel.frame = CGRectMake(_view.height * 0.35, _headImageView.y, _view.width * 0.7, _headImageView.height / 2);
    _commentLabel.frame = CGRectMake(_nameLabel.x, _nameLabel.y + _nameLabel.height, _nameLabel.width, _nameLabel.height);
    
    _timeLabel.frame = CGRectMake(_nameLabel.x + _nameLabel.width, _nameLabel.y, _view.width - (_nameLabel.x + _nameLabel.width) - _view.height * 0.07, _nameLabel.height);
    
    _albumView.frame = CGRectMake(0, _view.height * 0.39, _view.width, _view.height * 0.61);
    
    _albumImageView.frame = CGRectMake(_headImageView.x, _headImageView.y, _view.height * 0.47, _view.height * 0.47);
    
    _albumLabel.frame = CGRectMake(_view.width * 0.35, 0, _view.width * 0.6, _albumImageView.height);
    _albumLabel.centerY = _albumImageView.centerY;
}

- (void)setCommentModel:(CommentModel *)commentModel {
    if (_commentModel != commentModel) {
        _commentModel = commentModel;
        NSURL *headUrl = [NSURL URLWithString:_commentModel.uprofile];
        [_headImageView sd_setImageWithURL:headUrl];
        _nameLabel.text = _commentModel.uname;
        _commentLabel.text = _commentModel.commentText;
        NSURL *albumUrl = [NSURL URLWithString:_commentModel.coverSmall];
        [_albumImageView sd_setImageWithURL:albumUrl];
        _albumLabel.text = _commentModel.context;
        _timeLabel.text = [NSDate intervalSinceNow:_commentModel.createTime];
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
