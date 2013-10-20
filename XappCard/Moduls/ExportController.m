//
//  ExportController.m
//  iCamAlbum
//
//  Created by AppDevelopper on 13-10-12.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "ExportController.h"
#import "LoadingView.h"
#import "Macros.h"

@implementation ExportController

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

#pragma mark - Email

- (void)sendEmailWithImages:(NSArray*)images{
   MFMailComposeViewController* mailPicker = [[MFMailComposeViewController alloc] init];
	mailPicker.mailComposeDelegate = self;
	
    NSString *subject = @"Subject Test";
	
	[mailPicker setSubject:subject];
    
    for (int i = 0; i<[images count]; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i+1];
        [mailPicker addAttachmentData:UIImageJPEGRepresentation(images[i], 0.8) mimeType:@"image/jpg" fileName:fileName];
        
    }
    
//	[_root presentModalViewController:mailPicker animated:YES];
    [_root presentViewController:mailPicker animated:YES completion:nil];
}

- (void)sendEmail:(NSDictionary *)info{
	[[LoadingView sharedLoadingView] removeView];
	
	MFMailComposeViewController* mailPicker = [[MFMailComposeViewController alloc] init];
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
	
	
//	[_root presentModalViewController:mailPicker animated:YES];
     [_root presentViewController:mailPicker animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller

		  didFinishWithResult:(MFMailComposeResult)result

						error:(NSError *)error

{
	
	L();
	
//    [controller dismissModalViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:nil];
    
	if (result == MFMailComposeResultSent) {
        
	}
	
}
- (void)sendTweetWithText:(NSString*)text image:(UIImage*)image{
	[[LoadingView sharedLoadingView]removeView];
	
	// Set up the built-in twitter composition view controller.
//	if (!tweetViewController) {
//		tweetViewController = [[TWTweetComposeViewController alloc] init];
//	}

   TWTweetComposeViewController* tweetViewController = [[TWTweetComposeViewController alloc] init];
    
	// 如果没有image
	if (!image) {
        image = tweetDefaultImg;
    }

	[tweetViewController addImage:image];

	if (!ISEMPTY(text)) {
		[tweetViewController setInitialText:text];

	}
	else{
		[tweetViewController setInitialText:tweetInitText];

	}
	   
    __block TWTweetComposeViewController *vc = tweetViewController;
     [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
         
         [vc dismissViewControllerAnimated:YES completion:nil];

         
     }];
    // Create the completion handler block.
//    [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
////        NSString *output;
////        
////        switch (result) {
////            case TWTweetComposeViewControllerResultCancelled:
////                // The cancel button was tapped.
////                output = @"Tweet cancelled.";
////                break;
////            case TWTweetComposeViewControllerResultDone:
////                // The tweet was sent.
////                output = @"Tweet done.";
////				//				[FlurryAnalytics logEvent:@"Tweet sent"];
////                break;
////            default:
////                break;
////        }
//		
//        [_root dismissModalViewControllerAnimated:YES];
//    }];
    
    // Present the tweet composition view controller modally.
//    [_root presentModalViewController:tweetViewController animated:YES];
     [_root presentViewController:tweetViewController animated:YES completion:nil];
	
}

- (void)linkToAppStoreWithID:(NSString*)appID{
//    NSURL *url = [NSURL urlWithAppID:appID];
    NSString *urlStr =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?mt=8",appID];
	
	NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
    
    [[UIApplication sharedApplication]openURL:url];
}

//
- (void)toRate{
	
	
	NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
					 appIDStr];

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; 
}

@end
