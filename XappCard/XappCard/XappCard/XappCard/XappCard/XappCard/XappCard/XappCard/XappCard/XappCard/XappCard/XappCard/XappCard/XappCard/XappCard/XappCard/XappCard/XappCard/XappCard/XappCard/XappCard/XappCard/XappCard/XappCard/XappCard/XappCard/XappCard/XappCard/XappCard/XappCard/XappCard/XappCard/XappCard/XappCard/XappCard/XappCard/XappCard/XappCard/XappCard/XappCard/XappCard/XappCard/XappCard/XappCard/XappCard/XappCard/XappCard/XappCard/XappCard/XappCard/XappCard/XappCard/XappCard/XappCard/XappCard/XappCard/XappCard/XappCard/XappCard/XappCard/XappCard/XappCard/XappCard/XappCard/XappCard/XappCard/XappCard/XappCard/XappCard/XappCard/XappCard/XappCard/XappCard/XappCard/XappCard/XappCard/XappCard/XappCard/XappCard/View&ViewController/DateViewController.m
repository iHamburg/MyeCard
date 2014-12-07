//
//  DateViewController.m
//  MyeCard
//
//  Created by  on 28.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController

@synthesize cardsVC,date;

- (void)loadView{
	self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,480, 276)];

	
	UIBarButtonItem *removeBB = [[UIBarButtonItem alloc]initWithTitle:LString(@"Remove") style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = removeBB;
	
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, 480, 216)];
	datePicker.backgroundColor = [UIColor clearColor];
	datePicker.datePickerMode = UIDatePickerModeDate;
	// should be tomorrow
//	datePicker.minimumDate = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]];
    datePicker.minimumDate = [NSDate date];
	
	
	[self.view addSubview:datePicker];
	

	self.contentSizeForViewInPopover = self.view.bounds.size;
	self.title = LString(@"remindTitle");
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewWillAppear:(BOOL)animated{
	L();
	[super viewWillAppear:animated];
	
	
	[datePicker setSize:CGSizeMake(480, 216)];
	[self.view setSize:CGSizeMake(480, 276)];
	
	if (date) {
		datePicker.date = date;
	}
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);

}

#pragma mark - IBAction

- (void)cancel:(id)sender{
	L();
	if (cardsVC) {
		[cardsVC dismissDateVC:NO];
	}else {
		[super cancel:sender];
	}
	
}
- (void)done:(id)sender{
	L();

	//通过rootVC加入schedule
	[rootVC addDate:datePicker.date];
	
	if (cardsVC) {
		[cardsVC dismissDateVC:YES];
	}
	else {
		[super done:sender];
	}
}

#pragma mark -
- (void)setLinkBarButtonTitle:(NSString*)title{
	[cancelBB setTitle:title];
}
@end
