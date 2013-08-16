//
//  InfoViewController.m
//  XappCard
//
//  Created by  on 14.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize textView,emailB,rateB, moreAppB;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	
    [super viewDidLoad];
    
	UIScrollView *scrollV = (UIScrollView*)self.view;
	

	scrollV.frame = CGRectMake(0, 0, 480, 490);
	scrollV.contentSize = CGSizeMake(0, 490);
	
    self.title = NSLocalizedString(@"InformationTitle", nil);
    self.navigationItem.rightBarButtonItem = nil;
    self.textView.text = NSLocalizedString(@"InformationText", nil);
    self.textView.userInteractionEnabled = NO;
	
	
	UIImage *imgNormal = [UIImage imageNamed:@"Info_email.png"];
	UIImage *imgStretchable = [imgNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	

	[emailB setTitle:NSLocalizedString(@"Contact", nil) forState:UIControlStateNormal];
	[rateB setTitle:NSLocalizedString(@"Instruction", nil) forState:UIControlStateNormal];
	[moreAppB setTitle:LString(@"MoreApps") forState:UIControlStateNormal];
	[rateB setOrigin:CGPointMake(80, 430)];
	[emailB setOrigin:CGPointMake(320, 430)];
 	[moreAppB setOrigin:CGPointMake(200, 430)];
	
	[rateB setBackgroundImage:imgStretchable forState:UIControlStateNormal];
	[emailB setBackgroundImage:imgStretchable forState:UIControlStateNormal];
	[moreAppB setBackgroundImage:imgStretchable forState:UIControlStateNormal];
	
//	moreAppB = [UIButton buttonWithFrame:CGRectMake(200, 430, 100, 40) title:LString(@"MoreApps") image:imgStretchable target:self actcion:@selector(buttonClicked:)];
	[moreAppB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[moreAppB.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];

	
	[scrollV addSubview:moreAppB];
	[scrollV addSubview:emailB];
	[scrollV addSubview:rateB];

//	NSLog(@"scrollView.subview:%@,emailB:%@",scrollV.subviews, emailB);
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);

}

//
//- (IBAction)buttonClicked:(id)sender{
//	
//	if (sender == moreAppB) {
//		
//		
//		[rootVC toMoreApp];
//	}
//	
//}

- (IBAction)toEmail:(id)sender{
    L();

	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"InfoEmailSubject", nil), @"subject",
						  [NSArray arrayWithObjects:@"myecard@xappsoft.de",nil],@"toRecipients",
						  nil];
	
//	[[ExportController sharedInstance] sendEmail:dict delegate:self];
	[[ExportController sharedInstance]sendEmail:dict];
}



- (IBAction)toInstruction{
//	L();
	[self cancel:nil];
	[rootVC toInstruction];
}



- (IBAction)toMoreApps{
	
//	[rootVC toMoreApp];
}

// The mail compose view controller delegate method

- (void)mailComposeController:(MFMailComposeViewController *)controller

		  didFinishWithResult:(MFMailComposeResult)result

						error:(NSError *)error

{
	
    [controller dismissModalViewControllerAnimated:NO];
	
	
}



@end
