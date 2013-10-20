//
//  test.m
//  TravelAlbum_1_0
//
//  Created by  on 25.04.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Utilities.h"

CGFloat _h,_w;
CGRect _r,_containerRect;

void saveArchived(id obj, NSString *name){
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
								 initForWritingWithMutableData:data];
	[archiver encodeObject:obj forKey:name];
	[archiver finishEncoding];
	[data writeToFile:[NSString dataFilePath:name] atomically:YES];
	
}

id loadArchived(NSString* name){
	
	NSString *filePath = [NSString dataFilePath:name];
	//	NSLog(@"filePath:%@",filePath);
	id obj = nil;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
										 initForReadingWithData:data];
		obj = [unarchiver decodeObjectForKey:name];
		[unarchiver finishDecoding];
	}
	return obj;
}

BOOL isPaid(void){
	BOOL flag;
#ifdef PAID
	flag = YES;
#else
	flag= NO;
#endif
	return flag;
}


NSArray* getAllFontNames(void){
    NSArray *array = [UIFont familyNames];
    NSMutableArray* fontNames_ = [NSMutableArray array];
    
    for(NSString *familyName in array)
    {
        [fontNames_ addObject:familyName];
    }
    [fontNames_ sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return fontNames_;
}


