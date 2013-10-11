//
//  CardController.h
//  XappCard
//
//  Created by  on 11.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//


#import "Utilities.h"

#import "AppSetting.h"       //Setting
#import "CardSetting.h"
#import "Card.h"             

#define kFileCardNames @"cardNames"

@interface Controller : NSObject{
	
	NSMutableArray *cardNames;
	NSMutableArray *cards;
}


@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, assign) RootMode rootMode;

+ (Controller*)sharedController;

+ (void)saveProfilePhoto:(UIImage*)img;


- (Card*)newCard;
- (Card*)firstCard;
- (void)deleteCard:(Card*)card;
- (void)cancelNotificationWithCard:(Card*)c;
- (Card*)cardWithName:(NSString*)name;


- (int)indexOfCard:(Card*)card;
- (void)save;

+ (NSString*)dateFormatWithDate:(NSDate*)date;

- (AppVersion)appversion;

@end
