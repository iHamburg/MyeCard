//
//  PopoverViewController.h
//  XappCard
//
//  Created by  on 09.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface PopoverContentViewController : UIViewController{

	__unsafe_unretained RootViewController *rootVC;
	UIBarButtonItem* cancelBB;
	UIBarButtonItem *doneBB;
}

@property (nonatomic, unsafe_unretained) RootViewController *rootVC;

//- (void)initSubViews;
- (void)initBarButtons;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
