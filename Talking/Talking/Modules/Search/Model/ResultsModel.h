//
//  ResultsModel.h
//  Talking
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface ResultsModel : SpBaseModel

@property (nonatomic, assign) NSNumber *allid;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *image;


@end
