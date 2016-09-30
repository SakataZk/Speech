//
//  UserModel.h
//  Talking
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface UserModel : SpBaseModel
/**
 *  用户昵称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  用户性别
 */
@property (nonatomic, strong) NSNumber *sex;
/**
 *  头像大图
 */
@property (nonatomic, strong) NSString *bigPicture;
/**
 *  头像小图
 */
@property (nonatomic, strong) NSString *smallPicture;
/**
 *  背景图
 */
@property (nonatomic, strong) NSString *coverPicture;
/**
 *  个人简介
 */
@property (nonatomic, strong) NSString *aboutMe;

@end
