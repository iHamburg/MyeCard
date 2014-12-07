//
//  CardsViewController.h
//  MyeCard
//
//  Created by  on 27.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//


#import <TapkuLibrary/TapkuLibrary.h>
#import "Controller.h"
#import "MERootViewController.h"
#import "MyStoreObserver.h"
#import "DateViewController.h"
#import "CardCover.h"
#import "Card.h"

#import "QuartzCore/QuartzCore.h"

#define kTagDelete 123
#define kTagCalendar 124
#define kTagCardsLock 125

@class DateViewController;
@interface CardsViewController : UIViewController<TKCoverflowViewDelegate,TKCoverflowViewDataSource, UIAlertViewDelegate, CoverDelegate, IAPDelegate>{
	TKCoverflowView *coverflow;
	NSArray *cards;

	int selectedIndex;
	int cardIndex; // if delete or calendar is clicked, cardIndex will be set

	UILabel *calendarL;
	
	DateViewController *dateVC;
	UINavigationController *nav;
	UIPopoverController *popVC;
	UIAlertView *deleteAlert;
	
	
}
@property (nonatomic, unsafe_unretained) MERootViewController *rootVC;

@property (nonatomic, assign) int selectedIndex;

- (void)setup;

- (void)deleteCard:(int)cardIndex;
- (void)newCard;
- (void)selectCard:(int)cardIndex;

- (void)dismissDateVC:(BOOL)successful;


@end
