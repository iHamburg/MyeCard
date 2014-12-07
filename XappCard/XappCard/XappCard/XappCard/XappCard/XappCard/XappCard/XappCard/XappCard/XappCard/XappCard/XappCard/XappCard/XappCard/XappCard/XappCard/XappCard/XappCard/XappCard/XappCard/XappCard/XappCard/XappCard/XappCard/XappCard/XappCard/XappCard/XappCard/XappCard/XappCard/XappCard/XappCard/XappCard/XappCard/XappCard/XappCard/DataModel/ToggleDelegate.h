//
//  ToggleDelegate.h
//  XappCard
//
//  Created by  on 16.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ToggleDelegate <NSObject>
									
@property (nonatomic,assign) BOOL selected;

@required

- (void)toggleSelect;


@end
