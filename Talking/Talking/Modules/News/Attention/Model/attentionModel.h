//
//  attentionModel.h
//  Talking
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface attentionModel : SpBaseModel
/**
 *  昵称
 */
@property (nonatomic, strong) NSString *uname;
/**
 *  言集名称
 */
@property (nonatomic, strong) NSString *albumName;
/**
 *  关注时间
 */
@property (nonatomic, assign) long long createTime;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *userCoverSmall;
/**
 *  言集图片
 */
@property (nonatomic, strong) NSString *albumCover;
/**
 *  关注id
 */
@property (nonatomic, strong) NSNumber *sid;



@end
