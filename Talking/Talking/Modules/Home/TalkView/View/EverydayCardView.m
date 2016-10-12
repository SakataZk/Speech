//
//  EverydayCardView.m
//  Talking
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "EverydayCardView.h"
#import "UIImageView+WebCache.h"
#import "AlbumModel.h"


@interface EverydayCardView ()

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *imageView;
/**
 *  标签
 */
@property (nonatomic, strong) UILabel *mainTagLabel;
@property (nonatomic, strong) UILabel *subTagLabel;
/**
 *  文字
 */
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *albumNameLabel;
/**
 *  浏览量量
 */
@property (nonatomic, strong) UIImageView *viewImageView;
@property (nonatomic, strong) UILabel *viewLabel;
/**
 *  评论
 */
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentLabel;
/**
 *  分享
 */
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *shareLabel;
/**
 *  关注
 */
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UILabel *attentionLabel;

@end

@implementation EverydayCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.18, self.height * 0.05, self.width * 0.64, self.width * 0.64)];
        _imageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _imageView.layer.shadowOffset = CGSizeMake(3,2);
        _imageView.layer.shadowOpacity = 0.6;
        _imageView.layer.shadowRadius = 1.0;
        _imageView.clipsToBounds = NO;
        [self addSubview:_imageView];
        
        
        self.mainTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * 0.3, self.width * 0.09, self.width * 0.045)];
        _mainTagLabel.backgroundColor = [UIColor grayColor];
        _mainTagLabel.alpha = 0.8f;
        _mainTagLabel.textColor = [UIColor whiteColor];
        _mainTagLabel.font = [UIFont systemFontOfSize:15.f];
        _mainTagLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mainTagLabel];
        
        self.subTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * 0.35, _mainTagLabel.width, _mainTagLabel.height)];
        _subTagLabel.backgroundColor = [UIColor grayColor];
        _subTagLabel.alpha = 0.8f;
        _subTagLabel.textColor = [UIColor whiteColor];
        _subTagLabel.font = [UIFont systemFontOfSize:15.f];
        _subTagLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subTagLabel];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.x, _imageView.y + _imageView.height + self.height * 0.04, _imageView.width, 40)];
        _textLabel.text = @"";
        _textLabel.textColor = [UIColor lightGrayColor];
        _textLabel.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:_textLabel];
        
        
        
        self.albumNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_textLabel.x, _textLabel.y + _textLabel.height, _textLabel.width, 40)];
        _albumNameLabel.text = @"";
        _albumNameLabel.textColor = [UIColor lightGrayColor];
        _albumNameLabel.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:_albumNameLabel];
        
        
        self.viewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.5, self.height * 0.94, self.width * 0.5 / 8, self.height * 0.06 / 2)];
        _viewImageView.image = [UIImage imageNamed:@"view"];
        [self addSubview:_viewImageView];
        
        self.viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(_viewImageView.x, _viewImageView.y + _viewImageView.height, _viewImageView.width, _viewImageView.height / 2)];
        _viewLabel.font = [UIFont systemFontOfSize:12];
        _viewLabel.textColor = [UIColor lightGrayColor];
        _viewLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_viewLabel];
        
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame = CGRectMake(self.width * 0.5 / 4 + self.width * 0.5, _viewImageView.y, _viewImageView.width, _viewImageView.height);
        [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [self addSubview:_commentButton];
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_commentButton.x, _viewLabel.y, _viewLabel.width, _viewLabel.height)];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        _commentLabel.textColor = [UIColor lightGrayColor];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_commentLabel];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CGRectMake(self.width * 0.5 / 2 + self.width * 0.5, _commentButton.y, _commentButton.width, _commentButton.height);
        [_shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self addSubview:_shareButton];
        
        
        self.shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shareButton.x, _commentLabel.y, _commentLabel.width, _commentLabel.height)];
        _shareLabel.text = @"分享";
        _shareLabel.font = [UIFont systemFontOfSize:12];
        _shareLabel.textColor = [UIColor lightGrayColor];
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_shareLabel];
        
        
        self.attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.frame = CGRectMake(self.width - self.width * 0.5 / 4, _commentButton.y, _commentButton.width, _commentButton.height);
        [_attentionButton setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
        [self addSubview:_attentionButton];
        
        self.attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_attentionButton.x, _shareLabel.y, _shareLabel.width, _shareLabel.height)];
        _attentionLabel.text = @"关注";
        _attentionLabel.font = [UIFont systemFontOfSize:12];
        _attentionLabel.textColor = [UIColor lightGrayColor];
        _attentionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_attentionLabel];

    }
    return self;
}

- (void)setModel:(AlbumModel *)model {
    if (_model != model) {
        _model = model;
        NSURL *url = [NSURL URLWithString:_model.pictureCut];
        [_imageView sd_setImageWithURL:url];
        NSString *maintagString = [NSString stringWithFormat:@"%@",_model.albumMainTag];
        _mainTagLabel.text = maintagString;
        _subTagLabel.text = [NSString stringWithFormat:@"%@",_model.albumSubTag];
        
        NSDictionary *tagDic = @{NSFontAttributeName : [UIFont systemFontOfSize:15.f]};
        CGSize maintagSize = CGSizeMake(1000, self.width * 0.045);
        CGRect maintagRect = [maintagString boundingRectWithSize:maintagSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tagDic context:nil];
        _mainTagLabel.frame = CGRectMake(- maintagRect.size.height, self.width * 0.3, maintagRect.size.width + maintagRect.size.height * 2, maintagRect.size.height);
        _mainTagLabel.layer.cornerRadius = maintagRect.size.height / 2;
        _mainTagLabel.clipsToBounds = YES;
        
        CGSize subtagSize = CGSizeMake(1000, self.width * 0.045);
        NSString *subtagString = _model.albumSubTag;
        CGRect subtagRect = [subtagString boundingRectWithSize:subtagSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tagDic context:nil];
        _subTagLabel.frame = CGRectMake(-subtagRect.size.height, self.width * 0.35, subtagRect.size.width + subtagRect.size.height * 2,  subtagRect.size.height);
        _subTagLabel.layer.cornerRadius = subtagRect.size.height / 2;
        _subTagLabel.clipsToBounds = YES;
        if ([_model.albumSubTag isEqualToString:@""]) {
            [_subTagLabel removeFromSuperview];
        }
        if (_model.template == 1) {
            _textLabel.frame = CGRectMake(self.width * 0.18, self.height * 0.15, self.width * 0.64, self.width * 0.64);
        }else {        
            _textLabel.frame = CGRectMake(_imageView.x, _imageView.y + _imageView.height + self.height * 0.04, _imageView.width, 40);
        }
        NSString *text = _model.text;
        NSString *albumName = [NSString stringWithFormat:@"「 %@ 」",_model.albumName];
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:17.f]};
        
        CGSize textSize = CGSizeMake(_imageView.width, 1000);
        CGRect textRect = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        CGSize albumNameSize = CGSizeMake(1000, _mainTagLabel.height);
        CGRect albumNameRect = [albumName boundingRectWithSize:albumNameSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        _textLabel.text = text;
        if (textRect.size.height > self.height * 0.4) {
            _textLabel.size = CGSizeMake(textRect.size.width, textRect.size.height);
            
        }else  {
            _textLabel.size = CGSizeMake(textRect.size.width, textRect.size.height);
            
        }
        _textLabel.numberOfLines = 0;
        
        _albumNameLabel.text = albumName;
        _albumNameLabel.frame = CGRectMake(self.width - _imageView.x - albumNameRect.size.width, _textLabel.y + _textLabel.size.height + self.height * 0.04, albumNameRect.size.width, albumNameRect.size.height);
        
        _viewLabel.text = [NSString stringWithFormat:@"%ld",_model.view];
        _commentLabel.text = [NSString stringWithFormat:@"%ld",_model.comment];

    }
}




















@end
