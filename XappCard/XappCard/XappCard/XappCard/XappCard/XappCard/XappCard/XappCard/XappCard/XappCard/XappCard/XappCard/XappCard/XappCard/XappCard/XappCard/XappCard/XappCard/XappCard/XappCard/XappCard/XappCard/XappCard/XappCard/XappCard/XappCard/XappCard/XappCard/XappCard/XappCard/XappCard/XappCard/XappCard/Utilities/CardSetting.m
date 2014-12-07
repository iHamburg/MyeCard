//
//  CardSetting.m
//  XappCard
//
//  Created by  on 07.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardSetting.h"

@implementation CardSetting

@synthesize frameColor,frameEnable,coverEnable,shadowEnable,profileEnable, insideEnable;


- (id)init{
	if (self = [super init]) {
		frameColor = [UIColor whiteColor];
		frameEnable = YES;
		shadowEnable = YES;
		coverEnable = YES;
		profileEnable = YES;
		insideEnable = YES;
		settingKeys = [NSArray arrayWithObjects:@"frameEnable",@"shadowEnable",@"coverEnable",@"frameColor",@"profileEnable", @"insideEnable",nil];
	}
	return self;
}



- (id)initWithCoder:(NSCoder *)aDecoder{
	settingKeys = [NSArray arrayWithObjects:@"frameEnable",@"shadowEnable",@"coverEnable",@"frameColor", @"profileEnable",@"insideEnable", nil];
	
	frameColor = [aDecoder decodeObjectForKey:@"frameColor"];
	shadowEnable = [aDecoder decodeBoolForKey:@"shadowEnable"];
	frameEnable = [aDecoder decodeBoolForKey:@"frameEnable"];
	coverEnable = [aDecoder decodeBoolForKey:@"coverEnable"];
	profileEnable = [aDecoder decodeBoolForKey:@"profileEnable"];
	insideEnable = [aDecoder decodeBoolForKey:@"insideEnable"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeBool:frameEnable forKey:@"frameEnable"];
	[aCoder encodeBool:shadowEnable forKey:@"shadowEnable"];
	[aCoder encodeBool:coverEnable forKey:@"coverEnable"];
	[aCoder encodeObject:frameColor forKey:@"frameColor"];
	[aCoder encodeBool:profileEnable forKey:@"profileEnable"];
	[aCoder encodeBool:insideEnable forKey:@"insideEnable"];
}

@end
