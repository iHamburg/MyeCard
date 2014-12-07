//
//  AppSetting.h
//  XappCard
//
//  Created by  on 07.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Setting.h"


@interface AppSetting : Setting


@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, assign) int cardNumber;
+(id)sharedInstance;
+ (void)save;
@end
