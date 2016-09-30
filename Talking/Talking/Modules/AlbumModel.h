//
//  AlbumModel.h
//  Talking
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseModel.h"

@interface AlbumModel : SpBaseModel


@property (nonatomic, strong) NSString *pictureSmall;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger template;

@property (nonatomic, strong) NSString *pictureCut;

@property (nonatomic, strong) NSString *albumName;

@property (nonatomic, strong) NSString *albumMainTag;

@property (nonatomic, strong) NSString *albumSubTag;

@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, assign) NSInteger view;

//@property (nonatomic, assign)

@end
