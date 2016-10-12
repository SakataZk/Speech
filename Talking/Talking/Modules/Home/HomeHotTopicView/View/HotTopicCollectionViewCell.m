//
//  HotTopicCollectionViewCell.m
//  
//
//  Created by dllo on 16/9/22.
//
//

#import "HotTopicCollectionViewCell.h"
#import "HotTopicModel.h"
#import <UIImageView+WebCache.h>
#import "HotTopicLabel.h"
@interface HotTopicCollectionViewCell ()
/**
 *  上方大图
 */
@property (nonatomic, strong)UIImageView *hotTopicImageView;
/**
 *  下方Label
 */
@property (nonatomic, strong)UILabel *label;
/**
 *  言集标题
 */
@property (nonatomic, strong)HotTopicLabel *titleLabel;
/**
 *  推荐理由
 */
@property (nonatomic, strong)HotTopicLabel *recommendLabel;
/**
 *  浏览量和收藏量的Label
 */
@property (nonatomic, strong)HotTopicLabel *numberLabel;
/**
 *  浏览量
 */
@property (nonatomic, strong)UIImageView *viewImage;
@property (nonatomic, strong)HotTopicLabel *viewLabel;
/**
 *  收藏量
 */
@property (nonatomic, strong)UIImageView *subscribeImage;
@property (nonatomic, strong)HotTopicLabel *subscribeLabel;
/**
 *  标签
 */
@property (nonatomic, strong)HotTopicLabel *tagLabel;
/**
 *  博主头像
 */
@property (nonatomic, strong)UIImageView *ownerProfileImageView;
/**
 *  博主昵称
 */
@property (nonatomic, strong)HotTopicLabel *unameLabel;
/**
 *  言集简介
 */
@property (nonatomic, strong)HotTopicLabel *aboutLabel;

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
        _label.size = CGSizeMake(_hotTopicImageView.width, 260);
        [self.contentView addSubview:_label];
        
        self.titleLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(0, 0, self.width, (_label.height - 4 ) * 0.15)];
        [_label addSubview:_titleLabel];
        
        self.recommendLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(0,(_label.height - 4 ) * 0.15, _titleLabel.width, _titleLabel.height)];
        [_label addSubview:_recommendLabel];
        
        self.numberLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(0, _recommendLabel.y + _recommendLabel.height + 2, _recommendLabel.width, _recommendLabel.height)];
        [_label  addSubview:_numberLabel];
        
        self.viewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view"]];
        _viewImage.frame = CGRectMake(5, 5, _numberLabel.height /3 * 2, _numberLabel.height / 3 * 2);
        [_numberLabel addSubview:_viewImage];
        
        self.viewLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(_viewImage.width + _viewImage.x + 5, _viewImage.y - 5, _viewImage.width * 2, _numberLabel.height)];
        _viewLabel.text = @"";
        [_numberLabel addSubview:_viewLabel];
        
        
        self.subscribeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focus"]];
        _subscribeImage.frame = CGRectMake(15 + _viewImage.width +_viewLabel.width, _viewImage.y, _viewImage.width, _viewImage.height);
        [_numberLabel addSubview:_subscribeImage];
        
        self.subscribeLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(_subscribeImage.width + _subscribeImage.x, _viewLabel.y, _viewLabel.width, _viewLabel.height)];
        _subscribeLabel.text = @"";
        [_numberLabel addSubview:_subscribeLabel];
        
        self.tagLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(0, _numberLabel.y + _numberLabel.height, _numberLabel.width, _numberLabel.height)];
        [_label addSubview:_tagLabel];
        
        HotTopicLabel *buttonLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(0, _tagLabel.y + _tagLabel.height + 2, _tagLabel.width / 5, _tagLabel.width / 5)];
        [_label addSubview:buttonLabel];
        
        
        self.ownerProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _tagLabel.width / 5, _tagLabel.width / 5)];
        _ownerProfileImageView.layer.cornerRadius = 18;
        _ownerProfileImageView.layer.masksToBounds = YES;
        _ownerProfileImageView.backgroundColor = [UIColor whiteColor];
        [buttonLabel addSubview:_ownerProfileImageView];
        
        self.unameLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(buttonLabel.width, buttonLabel.y, _tagLabel.width - _ownerProfileImageView.width, _ownerProfileImageView.height)];
        [_label addSubview:_unameLabel];
        
        self.aboutLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(0, _unameLabel.y + _unameLabel.height, _tagLabel.width, (_label.height - 4) * 0.4 - _unameLabel.height)];
        _aboutLabel.numberOfLines  = 0;
        [_label addSubview:_aboutLabel];
    
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _hotTopicImageView.frame = CGRectMake(self.contentView.x, self.contentView.y, self.contentView.width, self.contentView.height - _label.height);
    _label.frame = CGRectMake(0, _hotTopicImageView.frame.origin.y + _hotTopicImageView.frame.size.height, _hotTopicImageView.frame.size.width, 260);
}

- (void)setHotTopicCell:(HotTopicModel *)hotTopicCell {
    if (_hotTopicCell != hotTopicCell) {
        _hotTopicCell = hotTopicCell;
        _titleLabel.text = [NSString stringWithFormat:@"「 %@ 」",_hotTopicCell.name];
        _recommendLabel.text = [NSString stringWithFormat:@" %@",_hotTopicCell.recommend];
        if (_hotTopicCell.view < 100) {
            _viewLabel.text = [NSString stringWithFormat:@"%ld",_hotTopicCell.view];
        } else {
            _viewLabel.text = [NSString stringWithFormat:@"%ld.%ldk",_hotTopicCell.view / 1000,_hotTopicCell.view % 1000 / 100];
        }
        _subscribeLabel.text = [NSString stringWithFormat:@"%ld",_hotTopicCell.subscribe];
        _tagLabel.text = [NSString stringWithFormat:@"标签:%@,%@",_hotTopicCell.tagMain,_hotTopicCell.tagSub];
        _unameLabel.text = [NSString stringWithFormat:@"  %@",_hotTopicCell.uname];
        if ([_hotTopicCell.about isEqualToString:@""]) {
            _aboutLabel.text = @"  言集简介: (该作者很懒,并没有写什么简介)";
        }else {
            _aboutLabel.text = [NSString stringWithFormat:@"  言集简介:%@",_hotTopicCell.about];
        }
        NSURL *url = [NSURL URLWithString:_hotTopicCell.ownerProfile];
        [_ownerProfileImageView sd_setImageWithURL:url];
        NSURL *bigurl = [NSURL URLWithString:_hotTopicCell.coverSmall];
        [_hotTopicImageView sd_setImageWithURL:bigurl];
    }




}








@end
