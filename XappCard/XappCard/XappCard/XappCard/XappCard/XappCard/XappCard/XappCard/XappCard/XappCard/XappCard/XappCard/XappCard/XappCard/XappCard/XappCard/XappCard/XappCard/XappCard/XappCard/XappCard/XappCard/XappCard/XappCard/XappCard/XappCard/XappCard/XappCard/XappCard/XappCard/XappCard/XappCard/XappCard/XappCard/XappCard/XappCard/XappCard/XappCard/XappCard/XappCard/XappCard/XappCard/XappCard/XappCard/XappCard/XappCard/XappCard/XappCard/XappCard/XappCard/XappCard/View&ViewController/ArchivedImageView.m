//
//  ArchivedImageView.m
//  XappCard
//
//  Created by  on 17.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ArchivedImageView.h"
#import "PictureWithFrameView.h"
#import <QuartzCore/QuartzCore.h>


@implementation ArchivedImageView

@synthesize archorPoint,locked,url,shadowEnabled,frameColor,frameEnabled;

- (id)initWithPictureView:(PictureWithFrameView*)pictureV{
	if (self = [super initWithFrame:pictureV.bounds]) {

	}
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
//	L();
	[super encodeWithCoder:coder];

	[coder encodeCGPoint:self.archorPoint forKey:@"anchorPoint"];
	[coder encodeBool:self.locked forKey:@"locked"];
	[coder encodeObject:self.url forKey:@"url"];

	[coder encodeBool:self.shadowEnabled forKey:@"shadowEnabled"];
	[coder encodeBool:self.frameEnabled forKey:@"frameEnabled"];
	[coder encodeObject:self.frameColor forKey:@"frameColor"];
//	NSLog(@"encode transform:%@, origin:%@",NSStringFromCGAffineTransform(imgTransform), NSStringFromCGPoint(imgOrigal));
//	NSLog(@"encode color:%@",self.frameColor);
	
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {

		self.archorPoint = [aDecoder decodeCGPointForKey:@"anchorPoint"];
		self.locked = [aDecoder decodeBoolForKey:@"locked"];
		self.url = [aDecoder decodeObjectForKey:@"url"];

		self.shadowEnabled = [aDecoder decodeBoolForKey:@"shadowEnabled"];
		self.frameEnabled = [aDecoder decodeBoolForKey:@"frameEnabled"];
		self.frameColor = [aDecoder decodeObjectForKey:@"frameColor"];
//		NSLog(@"decode center:%@",NSStringFromCGPoint(imgCenter));
//		NSLog(@"init frameColor:%@",self.frameColor);
	}
	return self;
}


#pragma mark -

// 没有调用controller的save all changed cards 是不会调用encode的

- (void)willSaveView:(PictureWithFrameView*)pictureV{
//	L();

	self.bounds = pictureV.bounds;
	self.archorPoint = pictureV.layer.anchorPoint;
	self.locked = pictureV.locked;
	self.url = pictureV.url;
	self.transform = pictureV.transform;
	self.center = pictureV.center;


	// 第二次self的color就没有了
//	NSLog(@"self.frameColor:%@",self.frameColor);
}
@end
