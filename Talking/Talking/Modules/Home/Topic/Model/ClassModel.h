//
//  ClassModel.h
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface ClassModel : SpBaseModel
/**
 *  卡片类型
 */
@property (nonatomic, strong) NSString *albumMainTag;
/**
 *  封面图片地址
 */
@property (nonatomic, strong) NSString *imageString;
/**
 *  封面图片内容
 */
@property (nonatomic, strong) NSString *text;
/**
 *  图片样式
 */
@property (nonatomic, assign) NSInteger template;

@end
