//
//  cardContentsModel.h
//  Talking
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface cardContentsModel : SpBaseModel

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong)NSString *imageSmall;

@property (nonatomic, strong)NSString *content;


@end
