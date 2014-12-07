//
//  AppSetting.m
//  XappCard
//
//  Created by  on 07.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AppSetting.h"
#import "Utilities.h"

@implementation AppSetting

@synthesize fontName,fontColor,cardNumber;
static id sharedInstance;

+(id)sharedInstance{
//	static id sharedInstance;
	if (sharedInstance == nil) {
		sharedInstance = loadArchived(@"AppSetting");
		if (!sharedInstance) {
			sharedInstance = [[[self class] alloc]init];

		}
	}
	
	return sharedInstance;
	
}
- (void)firstLoad{
	fontName = @"Chalkboard SE";
	fontColor = [UIColor colorWithHEXString:@"855b27"];

}

- (void)load{

	[super load];
	keys = [NSMutableArray arrayWithObjects:@"fontName", @"fontColor",nil];
}

+ (void)save{

//	NSLog(@"sharedInstance:%@",sharedInstance);
	
	saveArchived(sharedInstance, @"AppSetting");
}
@end
