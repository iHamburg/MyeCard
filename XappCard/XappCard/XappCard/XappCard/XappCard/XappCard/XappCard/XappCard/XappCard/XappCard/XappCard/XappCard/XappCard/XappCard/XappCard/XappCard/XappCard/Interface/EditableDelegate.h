//
//  EditableDelegate.h
//  XappCard
//
//  Created by  on 14.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EditableDelegate <NSObject>

@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, assign) BOOL locked;


@end

