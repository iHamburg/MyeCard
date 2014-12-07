//
//  CardCover.m
//  MyeCard
//
//  Created by  on 01.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardCover.h"

@implementation CardCover

@synthesize  deleteB, calendarB;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		

		
		deleteB = [UIButton buttonWithFrame:CGRectMake(frame.size.width-90, -10, 70, 70) title:nil image:[UIImage imageNamed:@"icon_delete.png"] target:self actcion:@selector(buttonClicked:)];
		deleteB.tag = kTagCoverDeleteCard;
		deleteB.autoresizingMask = AUTORESIZINGMASK;
		
		calendarB = [UIButton buttonWithFrame:CGRectMake(20, -20, 100, 100) title:nil image:[UIImage imageNamed:@"icon_clock.png"] target:self actcion:@selector(buttonClicked:)];
		calendarB.tag = kTagCoverCalendar;
		calendarB.autoresizingMask = AUTORESIZINGMASK;
		calendarB.hidden = YES;
		
		
		[self addSubview:calendarB];
		[self addSubview:deleteB];

    }
    return self;
}

- (IBAction)buttonClicked:(id)sender{
	L();
	[delegate cover:self buttonClicked:[sender tag]];
	
}

@end
