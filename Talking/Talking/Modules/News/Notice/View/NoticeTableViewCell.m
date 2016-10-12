//
//  NoticeTableViewCell.m
//  Talking
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "NoticeModel.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Categories.h"
@interface NoticeTableViewCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *replyButton;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIImageView *firstImage;

@property (nonatomic, strong) UIImageView *secondImage;

@property (nonatomic, strong) UIImageView *thirdImage;


@end



@implementation NoticeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_headImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"";
        [self.contentView addSubview:_nameLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"";
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_timeLabel];
        
        self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        [_replyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_replyButton];
        
        self.messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"";
        _messageLabel.font = [UIFont systemFontOfSize:15.f];
        _messageLabel.textColor = [UIColor darkGrayColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_messageLabel];
        
        self.firstImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_firstImage];
        
        self.secondImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_secondImage];
        
        self.thirdImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_thirdImage];
        
        _headImageView.frame = CGRectMake(self.width * 0.03, self.width * 0.03, self.width * 0.1, self.width * 0.1);
        _nameLabel.frame = CGRectMake(self.width *0.15, _headImageView.y, self.width * 0.8, self.width * 0.03);
        _timeLabel.frame = CGRectMake(_nameLabel.x, _nameLabel.y * 2 + _nameLabel.height, self.width * 0.3,_nameLabel.height );
        _replyButton.frame = CGRectMake(_nameLabel.x + _nameLabel.width, _nameLabel.y, _headImageView.width * 2, _nameLabel.height);
        _messageLabel.frame = CGRectMake(_nameLabel.x, _timeLabel.y + _timeLabel.height * 2, SCREEN_WIDTH - _nameLabel.x - self.width * 0.05, 100);
        
        

    }
    return self;
}



-(void)setNoticeModel:(NoticeModel *)noticeModel {
 
    if (_noticeModel != noticeModel) {
        _noticeModel = noticeModel;
        NSURL *headUrl = [NSURL URLWithString:_noticeModel.fromProfile];
        [_headImageView sd_setImageWithURL:headUrl];
        _nameLabel.text = _noticeModel.fromName;
        _timeLabel.text = [NSDate secondToDate:_noticeModel.createTime  WithFormat:@"MM-dd HH:mm"];
        
        NSString *text = @"";
        if (_noticeModel.contextType == 9 || _noticeModel.contextType == 3) {
            text = _noticeModel.message;
            [_firstImage removeFromSuperview];
            [_secondImage removeFromSuperview];
            [_thirdImage removeFromSuperview];
            
        }
        if (_noticeModel.contextType == 4) {
            NSArray *array = [_noticeModel.message componentsSeparatedByString:@";"];
            text = [array lastObject];
            NSURL *firstUrl = [NSURL URLWithString:[array firstObject]];
            [_firstImage sd_setImageWithURL:firstUrl];
            
            NSURL *secondUrl = [NSURL URLWithString:[array objectAtIndex:1]];
            [_secondImage sd_setImageWithURL:secondUrl];
            
            NSURL *thirdUrl = [NSURL URLWithString:[array objectAtIndex:2]];
            [_thirdImage sd_setImageWithURL:thirdUrl];
        }
        _messageLabel.text = text;
        [_messageLabel sizeToFit];
       
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15.f]};
        CGSize textSize = CGSizeMake(SCREEN_WIDTH * 0.8, 1000);
        CGRect textRect = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        _firstImage.frame = CGRectMake(_messageLabel.x, _messageLabel.y + textRect.size.height, (SCREEN_WIDTH - _messageLabel.x) / 6, SCREEN_WIDTH * 0.3);
        _secondImage.frame = CGRectMake(_firstImage.x + _firstImage.width * 2, _firstImage.y, _firstImage.width, _firstImage.height);
        _thirdImage.frame = CGRectMake(_secondImage.x + _secondImage.width * 2, _secondImage.y, _secondImage.width, _secondImage.height);
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
