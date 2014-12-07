//
//  DateView.m
//  MyeCard
//
//  Created by  on 28.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "DateView.h"

@implementation DateView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
		
		UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"title"];
		
		navBar.items = [NSArray arrayWithObject:item];

		
		cancelBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(buttonClicked:)];
		doneBB   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonClicked:)];
		item.leftBarButtonItem = cancelBB;
		item.rightBarButtonItem = doneBB;

		
		datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width, 220)];
		datePicker.datePickerMode = UIDatePickerModeDate;
		
		datePicker.minimumDate = [NSDate date];
		
		
		[self addSubview:datePicker];

		self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		
		[self addSubview:navBar];
		
    }
    return self;
}

- (IBAction)buttonClicked:(id)sender{
	L();
	if (sender == cancelBB) {
		
	}
	else if(sender == doneBB){
		NSDate *sendTermin = [datePicker date];

		// card add termin
		[delegate dateViewDidSelectDate:sendTermin];
	}
	
	[self removeFromSuperview];
}

@end
