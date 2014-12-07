//
//  Card.h
//  XappCard
//
//  Created by  on 10.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardSetting.h"
#import "CodingObject.h"


@interface Card :CodingObject

@property (nonatomic, strong) CardSetting *setting;
@property (nonatomic, strong) NSString *cardName;
@property (nonatomic, strong) UIImage *previewImg;

@property (nonatomic, strong) NSURL *coverBgUrl;
@property (nonatomic, strong) NSString *coverImgName;
@property (nonatomic, strong) NSMutableArray *coverElements;
@property (nonatomic, strong) NSMutableArray *coverMaskPhotos; //只有一张照片

@property (nonatomic, strong) NSURL *contentBGURL;
@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic, strong) UILocalNotification *notification;


@property (nonatomic, assign) BOOL coverMaskFlag;
@property (nonatomic, assign) BOOL changed; // needn't be saved, init when load


- (id)initWithName:(NSString*)name;
- (void)saveWithInformation:(NSDictionary*)info;

- (void)loadEmptyKeys:(NSArray*)emptyKeys;
@end
