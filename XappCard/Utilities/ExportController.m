//
//  ExportController.m
//  FirstThings_Uni
//
//  Created by  on 12.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ExportController.h"
#import "RootViewController.h"
//#import "Info2ViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "Utilities.h"

@implementation ExportController


+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}




#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

}

#pragma mark - Email

- (void)sendEmail:(NSDictionary *)info{
	[[LoadingView sharedLoadingView] removeView];
	
	mailPicker = [[MFMailComposeViewController alloc] init];
	mailPicker.mailComposeDelegate = self;
	
	NSString *emailBody = [info objectForKey:@"emailBody"];
	NSString *subject = [info objectForKey:@"subject"];
	NSArray *toRecipients = [info objectForKey:@"toRecipients"];
	NSArray *ccRecipients = [info objectForKey:@"ccRecipients"];
	NSArray *bccRecipients = [info objectForKey:@"bccRecipients"];
	NSArray *attachment = [info objectForKey:@"attachment"]; //0: nsdata, 1: mimetype, 2: filename
	
	[mailPicker setMessageBody:emailBody isHTML:YES];
	[mailPicker setSubject:subject];
    [mailPicker setToRecipients:toRecipients];
	[mailPicker setCcRecipients:ccRecipients];
	[mailPicker setBccRecipients:bccRecipients];
	
	
	if (!ISEMPTY(attachment)) {
		
		[mailPicker addAttachmentData:[attachment objectAtIndex:0] mimeType:[attachment objectAtIndex:1] fileName:[attachment objectAtIndex:2]];
	}
	
	
	[[RootViewController sharedInstance] presentModalViewController:mailPicker animated:NO];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller

		  didFinishWithResult:(MFMailComposeResult)result

						error:(NSError *)error

{
	
	L();
	
    [controller dismissModalViewControllerAnimated:NO];
	
	if (result == MFMailComposeResultSent) {
		
	}
	
}


#pragma mark - Tweet

- (void)sendTweetWithText:(NSString*)text image:(UIImage*)image{
	[[LoadingView sharedLoadingView]removeView];
	
	// Set up the built-in twitter composition view controller.
	if (!tweetViewController) {
		tweetViewController = [[TWTweetComposeViewController alloc] init];
	}
    
    
    // Set the initial tweet text. See the framework for additional properties that can be set.
	
	if (image) {
		[tweetViewController addImage:image];
	}
	
	if (!ISEMPTY(text)) {
		[tweetViewController setInitialText:text];
		
	}

	
    // Create the completion handler block.
    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
        NSString *output;
        
        switch (result) {
            case TWTweetComposeViewControllerResultCancelled:
                // The cancel button was tapped.
                output = @"Tweet cancelled.";
                break;
            case TWTweetComposeViewControllerResultDone:
                // The tweet was sent.
                output = @"Tweet done.";
				//				[FlurryAnalytics logEvent:@"Tweet sent"];
                break;
            default:
                break;
        }
		
        [[RootViewController sharedInstance] dismissModalViewControllerAnimated:YES];
//		[tweetViewController.view removeFromSuperview];
    }];
    
    // Present the tweet composition view controller modally.
    [[RootViewController sharedInstance] presentModalViewController:tweetViewController animated:YES];

}
#pragma mark - Rate
- (void)toRate{
	int appId = isPaid()?495584349:540736134;

	NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",  
					 appId ];   
	// NSLog(str);  
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; 
}

#pragma mark - Save Image


- (void)saveImageInAlbum:(UIImage*)img{
	
	ALAssetsLibrary* library  = [[ALAssetsLibrary alloc] init];
    
	[library saveImage:img toAlbum:kAppName withCompletionBlock:^(NSError *error){
	//            NSLog(@"saved!");
	
		if (!error) {
			[[LoadingView sharedLoadingView]addTitle:@"Saved!" inView:[[RootViewController sharedInstance]view]];
		}else{
			NSLog(@"error # %@",[error description]);
			[[LoadingView sharedLoadingView]addTitle:@"Please try it again later." inView:[[RootViewController sharedInstance]view]];
		}
	}];
	
	
}

#pragma mark -

- (void)linkToAppStoreWithID:(NSString*)appID{
    NSURL *url = [NSURL urlWithAppID:appID];
    
    [[UIApplication sharedApplication]openURL:url];
}
 @end
