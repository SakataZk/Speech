//
//  AllAlbumModel.h
//  Talking
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface AllAlbumModel : SpBaseModel
/**
 *  标题
 */
@property (nonatomic, strong) NSString *name;
/**
 * 背景图
 */
@property (nonatomic, strong) NSString *coverSmall;

/**
 *  浏览量
 */
@property (nonatomic, assign)NSInteger view;
/**
 *  收藏量
 */
@property (nonatomic, assign)NSInteger subscribe;
/**
 *  用户id
 */
@property (nonatomic, strong) NSNumber *uid;
/**
 *  博主头像
 */
@property (nonatomic, strong)NSString *ownerProfile;

@end
