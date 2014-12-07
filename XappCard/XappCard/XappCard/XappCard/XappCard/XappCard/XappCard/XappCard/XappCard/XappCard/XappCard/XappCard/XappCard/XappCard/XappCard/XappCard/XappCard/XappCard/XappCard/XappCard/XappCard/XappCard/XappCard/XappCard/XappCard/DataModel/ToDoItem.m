//
//  ToDoItem.m
//  XappCard
//
//  Created by  on 20.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

@synthesize day,month,year,hour,minute,eventKey,eventName,sendDate;

- (id)initWithName:(NSString *)name key:(NSString *)key{
	if (self = [self init]) {
		eventKey = key;
		eventName = name;
	}
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	
	

//	[coder encodeInt:day forKey:@"day"];
//	[coder encodeInt:month forKey:@"month"];
//	[coder encodeInt:year forKey:@"year"];
//	[coder encodeInt:hour forKey:@"hour"];
//	[coder encodeInt:minute forKey:@"minute"];
	[coder encodeObject:sendDate forKey:@"sendDate"];
	[coder encodeObject:eventKey forKey:@"eventKey"];
	[coder encodeObject:eventName forKey:@"eventName"];
	//	NSLog(@"elements:%@",elements);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	
	//	L();

//	day = [aDecoder decodeIntForKey:@"day"];
//	month = [aDecoder decodeIntForKey:@"month"];
//	year = [aDecoder decodeIntForKey:@"year"];
//	hour = [aDecoder]

	sendDate = [aDecoder decodeObjectForKey:@"sendDate"];
	eventKey = [aDecoder decodeObjectForKey:@"eventKey"];
	eventName = [aDecoder decodeObjectForKey:@"eventName"];
	
	return self;
}
@end
