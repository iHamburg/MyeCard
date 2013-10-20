//
//  PopoverViewController.h
//  XappCard
//
//  Created by  on 09.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MERootViewController.h"

@interface PopoverContentViewController : UIViewController{

	__unsafe_unretained MERootViewController *rootVC;
	UIBarButtonItem* cancelBB;
	UIBarButtonItem *doneBB;
}

@property (nonatomic, unsafe_unretained) MERootViewController *rootVC;

- (void)initBarButtons;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
