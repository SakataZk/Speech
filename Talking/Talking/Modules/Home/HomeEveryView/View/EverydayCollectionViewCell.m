//
//  EverydayCollectionViewCell.m
//  Talking
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "EverydayCollectionViewCell.h"
#import "HotTopicLabel.h"
#import "EverydayCellModel.h"
#import <UIImageView+WebCache.h>
#import "cardContentsModel.h"
@interface EverydayCollectionViewCell ()
/**
 *  博主头像
 */
@property (nonatomic, strong)UIImageView *albumImage;
/**
 *  博主昵称
 */
@property (nonatomic, strong)HotTopicLabel *albumNameLabel;
/**
 *  封面图片
 */
@property (nonatomic, strong)UIImageView *pictureSmall;
/**
 *  内容
 */
@property (nonatomic, strong)HotTopicLabel *textLabel;

@end


@implementation EverydayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.albumImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.width / 5, self.width / 5)];
        [self.contentView addSubview:_albumImage];
        
        self.albumNameLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(_albumImage.x, _albumImage.y + _albumImage.height, self.width - _albumImage.x, _albumImage.height / 2)];
        [self.contentView addSubview:_albumNameLabel];
        
        self.pictureSmall = [[UIImageView alloc] initWithFrame:CGRectMake(_albumImage.x, _albumNameLabel.y + _albumNameLabel.height, self.width - _albumImage.x * 2, self.height * 0.35)];
        [self.contentView addSubview:_pictureSmall];
        
        self.textLabel = [[HotTopicLabel alloc] initWithFrame:CGRectMake(_albumImage.x, _pictureSmall.y + _pictureSmall.height, self.width - _albumImage.x * 2, self.height - _pictureSmall.y - _pictureSmall.height - 5)];
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
        
    }
    return self;
}
- (void)setEverydayCell:(EverydayCellModel *)everydayCell {
    if (_everydayCell != everydayCell) {
        
        NSURL *url = [NSURL URLWithString:everydayCell.albumCover];
        [_albumImage sd_setImageWithURL:url];
        _albumNameLabel.text = [NSString stringWithFormat:@"「 %@ 」",everydayCell.albumName];
                
        if ([everydayCell.text isEqualToString:@"此内容为长文内容,请升级客户端到最新版本查看"]) {
            NSArray *array = everydayCell.cardContents;
            for (int i = 0; i < array.count; i++) {
                cardContentsModel *cards = [[cardContentsModel alloc] initWithDic:array[i]];
                if (cards.type == 2) {
                    NSURL *url = [NSURL URLWithString:cards.imageSmall];
                    [_pictureSmall sd_setImageWithURL:url];
                } else {
                    _textLabel.text = cards.content;
                }
            }
        }else {
            NSURL *coverUrl = [NSURL URLWithString:everydayCell.pictureSmall];
            [_pictureSmall sd_setImageWithURL:coverUrl];
            _textLabel.text = everydayCell.text;
            if (everydayCell.template == 6) {
                _pictureSmall.frame = CGRectMake(_albumImage.x, _albumNameLabel.y + _albumNameLabel.height, self.width * 0.4, self.height * 0.4);
                _pictureSmall.layer.cornerRadius = _pictureSmall.frame.size.height / 2;
                _pictureSmall.layer.masksToBounds = YES;
                _textLabel.frame = CGRectMake(_albumImage.x, _pictureSmall.y + _pictureSmall.height, self.width - _albumImage.x * 2, self.height - _pictureSmall.y - _pictureSmall.height - 5);
            }
            if ( !(everydayCell.template == 3 || everydayCell.template == 5)) {
                _pictureSmall.frame = CGRectMake(_albumImage.x + _albumImage.width / 2, _albumNameLabel.y + _albumNameLabel.height, self.width - (_albumImage.x + _albumImage.width / 2) * 2, self.height * 0.4);
                _textLabel.frame = CGRectMake(_albumImage.x, _pictureSmall.y + _pictureSmall.height, self.width - _albumImage.x * 2, self.height - _pictureSmall.y - _pictureSmall.height - 5);
            }
        }


    }
}


@end
