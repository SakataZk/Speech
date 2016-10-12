//
//  NoticeModel.h
//  Talking
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface NoticeModel : SpBaseModel
/**
 *  通知来自谁
 */
@property (nonatomic, strong) NSString *fromName;
/**
 *  通知头像
 */
@property (nonatomic, strong) NSString *fromProfile;
/**
 *  通知时间
 */
@property (nonatomic, assign) long long createTime;
/**
 *  通知内容
 */
@property (nonatomic, strong) NSString *message;
/**
 *  Cell类型
 */
@property (nonatomic, assign) NSInteger contextType;
/**
 *  messageId
 */
@property (nonatomic, strong) NSNumber *mid;

@end
