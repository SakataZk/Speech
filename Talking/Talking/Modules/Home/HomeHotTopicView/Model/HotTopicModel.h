//
//  HotTopicModel.h
//  Talking
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface HotTopicModel : SpBaseModel
/**
 *  封面图
 */
@property (nonatomic, strong)NSString *coverSmall;
/**
 *  标题
 */
@property (nonatomic, strong)NSString *name;
/**
 *  推荐理由
 */
@property (nonatomic, strong)NSString *recommend;
/**
 *  浏览量
 */
@property (nonatomic, assign)NSInteger view;
/**
 *  收藏量
 */
@property (nonatomic, assign)NSInteger subscribe;
/**
 *  主标签
 */
@property (nonatomic, strong)NSString *tagMain;
/**
 *  子标签
 */
@property (nonatomic, strong)NSString *tagSub;
/**
 *  博主头像
 */
@property (nonatomic, strong)NSString *ownerProfile;
/**
 *  博主昵称
 */
@property (nonatomic, strong)NSString *uname;
/**
 *  言集简介
 */
@property (nonatomic, strong)NSString *about;
/**
 *  图片大小
 */
@property (nonatomic, assign)CGFloat imageRatio;
@end
