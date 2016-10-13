//
//  CheckActivityViewController.h
//  
//
//  Created by dllo on 16/9/28.
//
//

#import "SpBaseViewController.h"


@class ActivityModel;
@interface CheckActivityViewController : SpBaseViewController

@property (nonatomic, strong) ActivityModel *model;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSNumber *uid;
@end
