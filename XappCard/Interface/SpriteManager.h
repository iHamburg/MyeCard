//
//  SpriteManager.h
//  XappCard_2_0
//
//  Created by  on 17.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"
#import "CoverCategory.h"

@interface SpriteManager : NSObject{
	NSArray *covers;
	NSArray *coverFreeImgNames,*coverHalloweenImgNames,  *coverThanksgivingImgNames,
	*coverAnniversaryImgNames, *coverChristmasImgNames, *_coverValentinImgNames, *_coverEasterImgNames, *_coverMotherImgNames,
	*coverFathersDayImgNames;

	NSArray *fullZettels;
	NSDictionary *fullZettelCats;
	NSString *preferredLang;
	
}


@property (nonatomic, strong) NSString *rateTitle;
@property (nonatomic, strong) NSString *rateMsg;
@property (nonatomic, strong) NSArray *fullZettels;
@property (nonatomic, strong) NSDictionary *fullZettelCats;

@property (nonatomic, strong) NSArray *coverThanksgivingImgNames;
@property (nonatomic, strong) NSMutableArray *coverCategorys;

@property (nonatomic, strong) UIFont *coverCategoryFont;
@property (nonatomic, strong) UIColor *lightGreenColor, *greenColor, *yellowColor;

+(id)sharedInstance;

- (UIImage*)coverImageWithIndex:(int)index;


- (UIImage*)portfolioImageWithIndex:(int)index;

- (UIImage*)stepImageWithIndex:(int)index;

- (UIImage*)instructionImageWithIndex:(int)index;

- (UIImage*)cardBGImageWithIndex:(int)index;

- (UIImage*)retinaLocalizedImage:(NSString*)imageName;

- (UIImage*)retinaImage:(NSString*)imageName type:(int)type;

#pragma mark - New
- (NSString*)resetCoverImgName:(int)index;   //deprecated, just for update 2.5/1.2, 


- (void)setupCoverImgNames;
//- (int)indexOfCoverImageName:(NSString*)coverImageName;
- (NSIndexPath*)indexPathOfImageName:(NSString*)coverImageName;

@end
