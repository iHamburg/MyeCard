//
//  ColorChooseViewController.h
//  XappCard
//
//  Created by  on 27.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"

@interface ColorChooseViewController : UIViewController<MyColorPlatteDelegate>{
	CardSetting *setting;
	MyColorPlatteView *colorPlatteV;
}


@property (nonatomic, strong) CardSetting *setting;

@end
