//
//  AppDelegate.h
//  XappCard
//
//  Created by Xappsoft on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBViewController.h"

@class MERootViewController;

void uncaughtExceptionHandler(NSException *exception);

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (nonatomic, strong) Facebook *facebook;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MERootViewController *viewController;

@end
