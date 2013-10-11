//
//  CardController.m
//  XappCard
//
//  Created by  on 11.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Controller.h"
#import "Utilities.h"
#import <QuartzCore/QuartzCore.h>
#import "PictureWithFrameView.h"
#import "CardTextView.h"
#import "ArchivedImageView.h"
#import "AppDelegate.h"
#import "Card.h"

@implementation Controller



@synthesize  rootMode,cards;

static NSDateFormatter *formatter;

-(id)init{

	[AppSetting sharedInstance];

	formatter = [[NSDateFormatter alloc]init];
	formatter.dateStyle = NSDateFormatterMediumStyle;
	
	cardNames = [NSMutableArray arrayWithContentsOfFile:[NSString dataFilePath:kFileCardNames]];

	//	NSLog(@"card names:%@",cardNames);
	if (!cardNames) { // first open, no cardnames
		NSString *cardName = [[NSDate date]description];
		Card *card = [[Card alloc] initWithName:cardName];
		cardNames = [NSMutableArray arrayWithObject:cardName];
		cards = [NSMutableArray arrayWithObject:card];
	}
	else { // load cards
		
		cards = [NSMutableArray array];
		for (NSString *cardName in cardNames) {
			Card *aCard = loadArchived(cardName);
//			NSLog(@"aCard:%@",aCard);
			[cards addObject:aCard];
		}
	}

    return self;
}

+(Controller*)sharedController{
    static Controller *sharedController;
    
    @synchronized(sharedController){
        if (sharedController == nil) {
            sharedController = [[Controller alloc ]init];
        }
    }
    
    return sharedController;
}


+ (void)saveProfilePhoto:(UIImage*)img{
    NSString *fileName = [NSString stringWithFormat:@"Documents/%@.png",@"profile"];
    NSString  *avatarPath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSData *avatar = UIImagePNGRepresentation(img);
    
    [avatar writeToFile:avatarPath atomically:YES];
	
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"avatarStatus"]==0) {
    
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"avatarStatus"];
        
    }
	
}

- (Card*)firstCard{
	Card *aCard = [cards objectAtIndex:0];
	aCard.changed = YES;
	return aCard;
}
- (void)save{
//	L();
	[AppSetting save];

	
	[cardNames writeToFile:[NSString dataFilePath:kFileCardNames] atomically:YES];

	
	// only changed card should be saved.
	for (int i = 0; i<[cards count]; i++) {
		Card *aCard = [cards objectAtIndex:i];
		if (aCard.changed) {
//			NSLog(@"save aCard:%d",i);
			saveArchived(aCard, aCard.cardName);
		}
	}


	
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Cards Manager
- (Card*)newCard{
	NSString *cardName = [[NSDate date] description];
	Card *newCard = [[Card alloc]initWithName:cardName];
	newCard.changed = YES;
	[cardNames addObject:cardName];
	[cards addObject:newCard];
	
	return newCard;
}

- (void)deleteCard:(Card*)_card{
	NSString *cardName = _card.cardName;
	
	// delete notification
	if (_card.notification) {
		[[UIApplication sharedApplication]cancelLocalNotification:_card.notification];
	}
	
	[cardNames removeObject:cardName];
	[cards removeObject:_card];
	
	if (ISEMPTY(cards)) {
		NSLog(@"cards is empty");
		[self newCard];
	}
}

// card 在cards 这个array里的index
- (int)indexOfCard:(Card*)_card{
	return [cards indexOfObject:_card];
}

- (Card*)cardWithName:(NSString*)name{
	int index = [cardNames indexOfObject:name];
	NSLog(@"index:%d",index);
	
	if (index>=0) {
		return [cards objectAtIndex:index];
	}
	return nil;
}

- (void)cancelNotificationWithCard:(Card*)c{
	if (c.notification) {
		[[UIApplication sharedApplication]cancelLocalNotification:c.notification];
		c.notification = nil;
	}
}


+ (NSString*)dateFormatWithDate:(NSDate*)date{

	return [formatter stringFromDate:date];
}


- (AppVersion)appversion{

	AppVersion version = AppVersionFree;
#ifdef PAID
	version = AppVersionPaid;
	
#elif defined(IAP)

	version = AppVersionIAP;
	
#endif
	
	return version;
}

@end
