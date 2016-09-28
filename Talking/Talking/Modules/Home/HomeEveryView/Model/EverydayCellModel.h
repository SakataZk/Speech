//
//  EverydayCellModel.h
//  Talking
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface EverydayCellModel : SpBaseModel
/**
 *  博主头像
 */
@property (nonatomic, strong) NSString *albumCover;
/**
 *  博主昵称
 */
@property (nonatomic, strong) NSString *albumName;
/**
 *  封面图片
 */
@property (nonatomic, strong) NSString *pictureSmall;
/**
 *  轮播图
 */
@property (nonatomic, strong) NSString *pictureCut;
/**
 *  封面文字
 */
@property (nonatomic, strong) NSString *text;
/**
 *  cell样式
 */
@property (nonatomic, assign) NSInteger template;
/**
 *  长篇文本 字典
 */
@property (nonatomic, strong)NSArray *cardContents;
@end
