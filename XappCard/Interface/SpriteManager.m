//
//  SpriteManager.m
//  XappCard_2_0
//
//  Created by  on 17.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "SpriteManager.h"
#import "MERootViewController.h"


@implementation SpriteManager

@synthesize rateTitle,rateMsg,fullZettels,fullZettelCats,coverThanksgivingImgNames,coverCategorys;
@synthesize coverCategoryFont,greenColor,lightGreenColor, yellowColor;

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (id)init{
	
	if (self = [super init]) {

		coverCategoryFont = [UIFont fontWithName:@"Archive" size:isPad?36:18];
		
		greenColor = [UIColor colorWithHEX:@"1eac1e"];
		lightGreenColor = [UIColor colorWithHEX:@"add58a"];
		yellowColor = [UIColor colorWithHEX:@"f6fc37"];
		
		
		NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
		NSArray* languages = [defs objectForKey:@"AppleLanguages"];
		NSString* lang = [languages objectAtIndex:0]; 
		lang = [lang uppercaseString];
		
		
		// DE or EN
		if ([lang isEqualToString:@"DE"]) {
			preferredLang = @"DE";
		}
		else{
			preferredLang = @"EN";
		}
		
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Material" ofType:@"plist"];
		NSDictionary *materialDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];

		//----Zettel
		
		NSDictionary *zettelDicts = [materialDict objectForKey:@"Zettel"];
		
		NSString *zettelKey = [preferredLang stringByAppendingFormat:@"Full"];
		NSString *zettelCatKey  =[zettelKey stringByAppendingFormat:@"Cat"];
		
		
		fullZettels = [zettelDicts objectForKey:zettelKey];
		fullZettelCats = [zettelDicts objectForKey:zettelCatKey];
		
		
		// iphone ohne rateTitle
		if (isPad) {
			rateTitle = LString(@"rateTitlePad");
			rateMsg = LString(@"rateMsgPad");
		}
		else {
			rateTitle = nil;
			rateMsg = LString(@"rateMsg");
		}
		
		//=------- Cover ---------------//

		coverFreeImgNames = materialDict[@"Cover_Free_3_0"];
		coverHalloweenImgNames = materialDict[@"Cover_Halloween"];
		coverThanksgivingImgNames = materialDict[@"Cover_Thanksgiving"];
		coverAnniversaryImgNames = materialDict[@"Cover_Anniversary"];
		coverChristmasImgNames = materialDict[@"Cover_Christmas"];
		_coverValentinImgNames = materialDict[@"Cover_Valentine"];
		_coverEasterImgNames = materialDict[@"Cover_Easter"];
		_coverMotherImgNames = materialDict[@"Cover_Muttertag"];
		coverFathersDayImgNames = materialDict[@"Cover_FathersDay"];
        coverHalloween2013ImgNames = materialDict[@"Cover_Halloween2013"];
		// Cover Category
		coverCategorys = [NSMutableArray array];

//		NSLog(@"CoverEaster: %@",_coverEasterImgNames);
		
		[self setupCoverImgNames];


	}
	
	return self;

}






- (void)setupCoverImgNames{
	
	// Cover Category
	[coverCategorys removeAllObjects];

	CoverCategory *coverCat = [[CoverCategory alloc]init];
	
	if (isPaid()||isIAPFullVersion) {
		coverCat.name = @"Others";
		coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverFreeImgNames];
		[coverCategorys addObject:coverCat];
		
	}
	else{
		coverCat.name = SFreeCatName;
		coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverFreeImgNames];
		[coverCategorys addObject:coverCat];
		
	}
	
    coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Halloween 2013";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverHalloween2013ImgNames];
	[coverCategorys addObject:coverCat];
	
    
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Halloween";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverHalloweenImgNames];
	[coverCategorys addObject:coverCat];
    
    coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"anniversary";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverAnniversaryImgNames];
	[coverCategorys addObject:coverCat];
    
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Fathers Day";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverFathersDayImgNames];
	[coverCategorys addObject:coverCat];
	
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Mother's Day";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:_coverMotherImgNames];
	[coverCategorys addObject:coverCat];
	
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Easter";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:_coverEasterImgNames];
	[coverCategorys addObject:coverCat];
	
	coverCat =[[CoverCategory alloc]init];
	coverCat.name = @"Valentine's Day";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:_coverValentinImgNames];
	[coverCategorys addObject:coverCat];
	
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"anniversary";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverAnniversaryImgNames];
	[coverCategorys addObject:coverCat];
	
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Xmas & New Year";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverChristmasImgNames];
	[coverCategorys addObject:coverCat];
	
	
	coverCat = [[CoverCategory alloc]init];
	coverCat.name = @"Thanksgiving";
	coverCat.coverImgNames = [NSMutableArray arrayWithArray:coverThanksgivingImgNames];
	[coverCategorys addObject:coverCat];

	
}



- (int)indexOfCoverImageName:(NSString*)coverImageName{
	NSArray *coverNames = [coverCategorys[0] coverImgNames];
	int index = [coverNames indexOfObject:coverImageName];
	if (index!=NSNotFound) {
		return index;
	}
	else{
		return 0;
	}

}

// 这个index是coverflow，card的index，不是cover的index前3张图片不一样
- (UIImage*)coverImageWithIndex:(int)index{
	
	
	NSString *imgPath;
	
	if (index>2) { // regular covers
		if (isPad&&isRetina) {
			imgPath = [NSString stringWithFormat:@"pic/Cover/%@@3x.jpg",[covers objectAtIndex:index-3]];
		}
		else
			imgPath = [NSString stringWithFormat:@"pic/Cover/%@.jpg",[covers objectAtIndex:index-3]];
	}
	else { // 3 special cover
		if (index == 0) {
			imgPath = @"CoverWithLogo1~ipad.jpg";
		}
		else {
			imgPath = [NSString stringWithFormat:@"CoverWithLogo%d~ipad.png",index+1];
		}


	}


	UIImage *img = [UIImage imageWithContentsOfFile:GetFullPath(imgPath)];


	return img;
}

- (UIImage*)stepImageWithIndex:(int)index{
	
	NSString *imagePath = [NSString stringWithFormat:@"pic/Steps/Step%d",index];


	return [self retinaLocalizedImage:imagePath];
}


- (UIImage*)portfolioImageWithIndex:(int)index{
	NSString *imagePath = nil;
	// 0: love, 1: frame, 2:frametext
	switch (index) {
		case 0:
			imagePath = @"Profile_love";
			break;
			
		case 1:
			imagePath = @"pic/Background/ProfileFrame";
			break;
		case 2:
			imagePath = @"pic/Background/ProfileFrameText";
			break;
		default:
			break;
	}
	return [self retinaImage:imagePath type:0];
}


- (UIImage*)instructionImageWithIndex:(int)index{
	NSString *imagePath = [NSString stringWithFormat:@"pic/Instruction/Instruction_%d",index];
	
	return [self retinaLocalizedImage:imagePath];
}


// 可以给card做更多的bg图片
- (UIImage*)cardBGImageWithIndex:(int)index{

	return [self retinaImage:@"pic/Background/content_BG" type:1]; //jpg
}


// 0: png, 1:jpg
- (UIImage*)retinaImage:(NSString*)imageName type:(int)type{
	
	NSString *finalPath = imageName;
	if (isPad&&isRetina) {
		finalPath = [finalPath stringByAppendingString:@"@3x"];
	}
	
	if (type == 0) { //png
		finalPath = [finalPath stringByAppendingString:@".png"];
	}
	else{
		finalPath = [finalPath stringByAppendingString:@".jpg"];
	}
	
//	NSLog(@"finalPath:%@",finalPath);
    return [UIImage imageWithContentsOfFile:GetFullPath(finalPath)];
}



//全是png
- (UIImage*)retinaLocalizedImage:(NSString*)imageName{
	
	NSString *imageLocalizedPath;
    if([preferredLang isEqualToString:@"DE"]){
        imageLocalizedPath = [imageName stringByAppendingFormat:@"_%@",preferredLang];
    }
    else{ // default en
		
        imageLocalizedPath = [imageName stringByAppendingFormat:@"_%@",@"EN"];
    }
	//    DLog(@"imageLocalizedPath:%@",imageLocalizedPath);
	
	NSString *finalPath;
	if (isPad&&isRetina) {
		finalPath = [imageLocalizedPath stringByAppendingFormat:@"@3x.png"];
	}
	else
		finalPath = [imageLocalizedPath stringByAppendingFormat:@".png"];
	
	//NSLog(@"finalPath:%@",finalPath);
    return [UIImage imageWithContentsOfFile:GetFullPath(finalPath)];

}

//
//- (int)numberOfCovers{
//
//	return [_coverImgNames count];
//}

- (NSIndexPath*)indexPathOfImageName:(NSString*)coverImageName{

	for (int i = 0; i<[coverCategorys count]; i++) {
		CoverCategory *cat  = coverCategorys[i];
		for (int j = 0; j<[cat numOfCovers]; j++) {
			if ([coverImageName isEqualToString:[cat coverImgNameWithIndex:j ]]) {
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
				
				return indexPath;
			}
		}
	}

	return [NSIndexPath indexPathForRow:0 inSection:0];
}


#pragma mark - Deprecated
- (NSString*)resetCoverImgName:(int)index{
	NSString *imgPath;
	
	if (index>2) { // regular covers
		
		imgPath = covers[index-3];
	}
	else { // 3 special cover
		if (index == 0) {
			imgPath = @"CoverWithLogo1.jpg";
		}
		else {
			imgPath = [NSString stringWithFormat:@"CoverWithLogo%d.png",index+1];
		}
		
	}
	
	return imgPath;
}

@end
