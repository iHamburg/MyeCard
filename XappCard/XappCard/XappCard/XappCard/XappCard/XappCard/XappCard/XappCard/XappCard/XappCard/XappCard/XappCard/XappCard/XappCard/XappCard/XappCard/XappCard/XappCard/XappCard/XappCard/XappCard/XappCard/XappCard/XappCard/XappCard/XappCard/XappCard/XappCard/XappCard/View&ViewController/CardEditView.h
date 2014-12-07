//
//  CardEditView.h
//  XappCard
//
//  Created by  on 19.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableDelegate.h"
#import "SaveLoadDelegate.h"
#import "Controller.h"

#import <QuartzCore/QuartzCore.h>

@interface CardEditView : UIView<EditableDelegate,SaveLoadDelegate>{
	UIMenuItem *lockItem ;
	UIMenuItem *unlockItem;
	UIMenuItem *editItem;
	UIMenuItem *bgMenuItem;
}

- (void)dealloc;
@end
