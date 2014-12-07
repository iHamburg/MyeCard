//
//  Card.m
//  XappCard
//
//  Created by  on 10.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Card.h"
#import "WidgetComponent.h"
#import "CardEditView.h"



@implementation Card

@synthesize contentBGURL,elements,coverBgUrl,coverElements,setting,previewImg, cardName, notification, coverImgName,coverMaskPhotos;
@synthesize coverMaskFlag,changed;
//@synthesize ;

- (BOOL)coverMaskFlag{
	
	if ([coverImgName rangeOfString:@"png"].location == NSNotFound) { // 没有png，肯定不是mask
		return NO;  
	}
	else if([coverImgName rangeOfString:@"Logo"].location != NSNotFound){ // 如果有logo，就是CoverWithLogo3~ipad.png
		return NO;
	}
	
	return YES;
	
}

- (id)initWithName:(NSString*)name{
	
	if (self = [self init]) {
		cardName = name;
	}
	return self;
}

- (void)firstLoad{
	
	self.coverBgUrl = nil;
//	self.coverBGIndex = -1;
	self.coverElements = [NSMutableArray array];
	self.coverMaskPhotos = [NSMutableArray array];
	
	self.contentBGURL = nil;
	self.elements = [NSMutableArray array];
	self.setting = [[CardSetting alloc] init];
	self.previewImg = [UIImage imageNamed:@"Mars.png"];
	
}


- (void)load{
	[super load];
	keys = [NSMutableArray arrayWithObjects:@"coverBgUrl",@"coverElements",@"contentBGURL",
			@"elements",@"setting",@"cardName",@"notification",@"coverImgName",@"coverMaskPhotos",nil];

	changed = NO;
	
	if (ISEMPTY(coverMaskPhotos)) {
		coverMaskPhotos = [NSMutableArray array];
	}
}

- (void)loadOthers:(NSCoder *)aDecoder{
	
//	self.coverBGIndex = [aDecoder decodeIntForKey:@"coverBGIndex"];

	
	if (kVersion>=5.0) {
		self.previewImg = [aDecoder decodeObjectForKey:@"previewImg"];
	}
	else {
		NSData *previewData = [aDecoder decodeObjectForKey:@"previewImg"];
		self.previewImg = [UIImage imageWithData:previewData];
	}
	
}

- (void)loadEmptyKeys:(NSArray *)emptyKeys{


	if ([emptyKeys containsObject:@"cardName"]) {
	}
	if ([emptyKeys containsObject:@"previewImg"]) {
		self.previewImg = [UIImage imageNamed:@"Mars.png"];
	}
}
- (void)saveOthers:(NSCoder *)coder{
//	L();
	
//	[coder encodeInt:self.coverBGIndex forKey:@"coverBGIndex"];

//	NSLog(@"card.coverMaskPhotos # %@",self.coverMaskPhotos);

	
	// preview image
	if (kVersion>=5.0) {
		[coder encodeObject:previewImg forKey:@"previewImg"];
		
	}
	else {
		[coder encodeObject:UIImagePNGRepresentation(previewImg) forKey:@"previewImg"];
	}
}

/**
 
 把momentWidget存到elements去
 
 */
- (void)saveWithInformation:(NSDictionary*)info{
	
	
	[coverElements removeAllObjects];
	[elements removeAllObjects];
	[coverMaskPhotos removeAllObjects];
	
	
	NSArray *coverMaskElements = info[@"coverMaskPhotos"];
	
	

	for (UIView *v in coverMaskElements) {
		
		if ([v isKindOfClass:[CardEditView class]]) {
			[coverMaskPhotos addObject:[(CardEditView *)v save]];
			
		}
		
//		else if ([v respondsToSelector:@selector(encodedObject)]) {
//			id encodeObj = [(id<WidgetDelegate>)v encodedObject];
//			[coverElements addObject:encodeObj];
//		}
	}

	
		NSArray * _coverElements = [info objectForKey:@"coverSubviews"];
	for (UIView *v in _coverElements) {
		
		if ([v isKindOfClass:[CardEditView class]]) {
			[coverElements addObject:[(CardEditView *)v save]];
	
		}
		else if ([v respondsToSelector:@selector(encodedObject)]) {
			id encodeObj = [(id<WidgetDelegate>)v encodedObject];
			[coverElements addObject:encodeObj];
		}
	}
	
	
	
	NSArray *subviews = [info objectForKey:@"contentSubviews"];

	for (UIView *v in subviews) {
		
		if ([v isKindOfClass:[CardEditView class]]) {
			
			[elements addObject:[(CardEditView *)v save]];
			
		}
		else if ([v respondsToSelector:@selector(encodedObject)]) {
			id encodeObj = [(id<WidgetDelegate>)v encodedObject];
			[elements addObject:encodeObj];
		}
	}
	
	previewImg = [info objectForKey:@"preview"];

//	NSLog(@"after save card # %@",NSStringFromClass([previewImg class]));
}


- (NSString*)description{
	
	NSString *description = @"";
	for (int i = 0; i<[keys count]; i++) {
		NSString *key = [keys objectAtIndex:i]; 
		description = [description stringByAppendingFormat:@"%@:%@ \n",key,[self valueForKey:key]];
	}
//	description = [description stringByAppendingFormat:@"coverbgindex:%d \n",coverBGIndex];


	return description;
}


@end
