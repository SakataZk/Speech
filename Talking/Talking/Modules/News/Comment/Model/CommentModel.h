//
//  CommentModel.h
//  Talking
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface CommentModel : SpBaseModel
/**
 *  卡片内容
 */
@property (nonatomic, strong) NSString *context;
/**
 *  评论内容
 */
@property (nonatomic, strong) NSString *commentText;
/**
 *  评论者昵称
 */
@property (nonatomic, strong) NSString *uname;
/**
 *  评论者头像
 */
@property (nonatomic,strong) NSString *uprofile;
/**
 *  卡片图片
 */
@property (nonatomic, strong) NSString  *coverSmall;
/**
 *  评论时间
 */
@property (nonatomic, assign) long  long createTime;
@end
