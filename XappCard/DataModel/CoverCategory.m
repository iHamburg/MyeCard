//
//  CoverCategory.m
//  MyeCard
//
//  Created by AppDevelopper on 09.01.13.
//
//

#import "CoverCategory.h"
#import "Utilities.h"

@implementation CoverCategory

@synthesize name,coverImgNames,iapKey,available;

- (BOOL)available{

	if ([name isEqualToString:SFreeCatName] ||[name isEqualToString:SAllCatName]) {
		return YES;
	}
	else {
		return isPaid()||isIAPFullVersion;
	}

	
}

- (id)init{
	if (self = [super init]) {
		coverImgNames = [NSMutableArray array];
	}
	return self;
}

#pragma mark -

-(NSString *)coverImgNameWithIndex:(int)index{
	return coverImgNames[index];
}

- (int)numOfCovers{

	return [coverImgNames count];
}

@end
