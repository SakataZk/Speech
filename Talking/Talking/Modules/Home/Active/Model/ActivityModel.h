//
//  ActivityModel.h
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface ActivityModel : SpBaseModel

@property (nonatomic, strong) NSString *finishPicture;

@property (nonatomic, strong) NSString *bigPicture;

@property (nonatomic, strong) NSString *picture;

@property (nonatomic, assign) NSInteger acid;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSNumber *tpid;

@property (nonatomic, strong) NSString *urlSuffix;
@end
