//
//  EverydayViewController.h
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseViewController.h"

@protocol  EverydayViewControllerDelegate <NSObject>

- (void)showTheCard ;

@end

@interface EverydayViewController : SpBaseViewController

@property (nonatomic, assign) id<EverydayViewControllerDelegate>delegate;

@end
