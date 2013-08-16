//
//  InfoViewController.h
//  XappCard
//
//  Created by  on 14.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//


#import "PopoverContentViewController.h"


@interface InfoViewController : PopoverContentViewController<MFMailComposeViewControllerDelegate>
{

	
}

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *emailB;
@property (nonatomic, strong) IBOutlet UIButton *rateB;
@property (nonatomic, strong) IBOutlet UIButton *moreAppB;

- (IBAction)toEmail:(id)sender;

- (IBAction)toInstruction;

- (IBAction)toMoreApps;

@end
