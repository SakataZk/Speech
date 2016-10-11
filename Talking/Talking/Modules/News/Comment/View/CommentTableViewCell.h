//
//  CommentTableViewCell.h
//  Talking
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CommentModel;
@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, strong) CommentModel *commentModel;

@end
