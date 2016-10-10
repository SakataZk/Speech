//
//  NewsViewController.m
//  Talking
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "NewsViewController.h"
#import "NoticeViewController.h"
#import "CommentViewController.h"
#import "AttentionViewController.h"
#import "likeViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9725 alpha:1.0];
    
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.05)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.05, self.view.width, self.view.height * 0.08)];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.text = @"消息中心";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(self.view.width * 0.055, 0, self.view.width * 0.055, _titleLabel.height / 3);
    returnButton.centerY = _titleLabel.centerY;
    [returnButton setImage:[UIImage imageNamed:@"darkReturn"] forState:UIControlStateNormal];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:returnButton];
    
    [self creatButton];
    
    
    // Do any additional setup after loading the view.
}
- (void)creatButton {
    
    
    
    
    
    UIButton *NoticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NoticeButton.frame = CGRectMake(0,_titleLabel.y + _titleLabel.height + 1 , (self.view.width - 1 ) / 2,( SCREEN_HEIGHT - 1 - _titleLabel.y - _titleLabel.height ) / 2);
    NoticeButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NoticeButton];

    UIImageView *noticeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NoticeButton.width * 0.16, NoticeButton.height * 0.1)];
    noticeImageView.image = [UIImage imageNamed:@"notice"];
    noticeImageView.userInteractionEnabled = YES;
    noticeImageView.center = NoticeButton.center;
    [self.view addSubview:noticeImageView];
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(noticeImageView.x - noticeImageView.width / 2, noticeImageView.y + noticeImageView.height, noticeImageView.width * 2, noticeImageView.height / 2)];
    noticeLabel.text = @"人言通知";
    noticeLabel.font = [UIFont systemFontOfSize:15];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noticeLabel];
    
    [NoticeButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NoticeViewController *noticeView = [[NoticeViewController alloc] init];
        noticeView.uid = _uid;
        noticeView.token = _token;
        [self.navigationController pushViewController:noticeView animated:YES];
    }];

    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(NoticeButton.width + 1, NoticeButton.y, NoticeButton.width, NoticeButton.height);
    commentButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commentButton];

    UIImageView *commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, noticeImageView.width, noticeImageView.height)];
    commentImageView.center = commentButton.center;
    commentImageView.image = [UIImage imageNamed:@"black comment"];
    commentImageView.userInteractionEnabled = YES;
    [self.view addSubview:commentImageView];
    
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(commentImageView.x - commentImageView.width / 2, commentImageView.y + commentImageView.height, commentImageView.width * 2, commentImageView.height / 2)];
    commentLabel.text = @"评论";
    commentLabel.font = [UIFont systemFontOfSize:15];
    commentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:commentLabel];

    [commentButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        CommentViewController *commentView = [[CommentViewController alloc] init];
        commentView.uid = _uid;
        commentView.token = _token;
        [self.navigationController pushViewController:commentView animated:YES];
    }];
    
    
    
    
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionButton.frame = CGRectMake(0, NoticeButton.y + NoticeButton.height + 1, NoticeButton.width, NoticeButton.height);
    attentionButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:attentionButton];
    
    UIImageView *attentionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, commentImageView.width, commentImageView.height)];
    attentionImageView.center = attentionButton.center;
    attentionImageView.image = [UIImage imageNamed:@"black attention"];
    attentionImageView.userInteractionEnabled = YES;
    [self.view addSubview:attentionImageView];
    
    UILabel *attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(attentionImageView.x - attentionImageView.width / 2, attentionImageView.y + attentionImageView.height, attentionImageView.width * 2, attentionImageView.height / 2)];
    attentionLabel.text = @"关注";
    attentionLabel.textAlignment = NSTextAlignmentCenter;
    attentionLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:attentionLabel];
    [attentionButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        AttentionViewController *attentionView = [[AttentionViewController alloc] init];
        attentionView.uid = _uid;
        attentionView.token = _token;
        [self.navigationController pushViewController:attentionView animated:YES];
    }];
    
    
    
    
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(commentButton.x, attentionButton.y, attentionButton.width, attentionButton.height);
    likeButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:likeButton];
    
    UIImageView *likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, attentionImageView.width, attentionImageView.height)];
    likeImageView.center = likeButton.center;
    likeImageView.image = [UIImage imageNamed:@"black like"];
    likeImageView.userInteractionEnabled = YES;
    [self.view addSubview:likeImageView];
    
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(likeImageView.x - likeImageView.width / 2, likeImageView.y + likeImageView.height, likeImageView.width * 2, likeImageView.height / 2)];
    likeLabel.text = @"点赞";
    likeLabel.textAlignment = NSTextAlignmentCenter;
    likeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:likeLabel];
    [likeButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        likeViewController *likeView = [[likeViewController alloc] init];
        [self.navigationController pushViewController:likeView animated:YES];
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
