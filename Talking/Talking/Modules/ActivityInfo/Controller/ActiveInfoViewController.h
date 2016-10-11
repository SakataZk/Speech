//
//  ActiveInfoViewController.h
//  Talking
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseViewController.h"
@class ActivityModel;
@interface ActiveInfoViewController : SpBaseViewController


@property (nonatomic, strong) ActivityModel *model;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSNumber *uid;

@end
