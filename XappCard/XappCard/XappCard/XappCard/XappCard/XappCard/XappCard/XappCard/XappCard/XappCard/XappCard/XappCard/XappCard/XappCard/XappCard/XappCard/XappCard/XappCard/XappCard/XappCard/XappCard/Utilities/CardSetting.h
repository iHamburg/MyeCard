//
//  CardSetting.h
//  XappCard
//
//  Created by  on 07.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Setting.h"

@interface CardSetting : Setting

@property (nonatomic, assign) BOOL frameEnable;
@property (nonatomic, assign) BOOL shadowEnable;
@property (nonatomic, assign) BOOL coverEnable;
@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, assign) BOOL profileEnable;
@property (nonatomic, assign) BOOL insideEnable;

@end
