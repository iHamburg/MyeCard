//
//  FBViewController.m
//  FacebookTest
//
//  Created by  on 12.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "FBViewController.h"

@interface FBViewController ()

@end

@implementation FBViewController

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}


- (id)init{
	if (self = [super init]) {

	}
	return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)feed{
	AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	Facebook *facebook = [appDelegate facebook];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] 
		&& [defaults objectForKey:@"FBExpirationDateKey"]) {
		NSLog(@"has tokenkey");
		facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
		facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
	
	if (![facebook isSessionValid]) {
		[facebook authorize:nil];
	}
	
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   FBAppID, @"app_id",
								   kApplink, @"link",
//								   @"http://fbrell.com/f8.jpg", @"picture",
								   @"My eCard", @"name",
								   @"An amazing iPhone/iPad App for my own eCard", @"caption",
								   @"My eCard is an app that can help you create your personal and individual e-cards with your own photos, in a very comfortable way. \nBesides writing your own texts, you can also find beautiful and special verses to simplify creating a card or for your spirit.", @"description",
								   nil];
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];

}

- (void)sendImage:(UIImage*)img delegate:(id)_delegate{
	AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	Facebook *facebook = [appDelegate facebook];
	delegate = _delegate;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] 
		&& [defaults objectForKey:@"FBExpirationDateKey"]) {
		NSLog(@"has tokenkey");
		facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
		facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
	
	NSLog(@"facebook:%@",facebook);
	
	if (![facebook isSessionValid]) {
		
		[facebook authorize:nil];
	}
	else {
		NSLog(@"fb is already authorized");
	}

	
	NSData *picData = UIImageJPEGRepresentation(img, 0.8);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"via My eCard",@"message",
                                   picData, @"picture",
                                   nil];
    
	
	NSLog(@"begin send");
	
	
	
    [facebook requestWithGraphPath:@"me/photos"
									andParams:params
								andHttpMethod:@"POST"
								  andDelegate:self];
//	
//	NSURL *picUrl = [NSURL fileURLWithPath:[NSString dataFilePath:@"temp.jpg"]];
//	NSData *picData = UIImageJPEGRepresentation(img, 0.8);
//	NSLog(@"picUrl:%@",picUrl.description);
//	NSMutableDictionary* params2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//								   FBAppID, @"app_id",
//								   @"http://www.xappsoft.de/", @"link",
//								   @"My ecard", @"name",
//								   @"Xappsoft", @"caption",
//								   @"Description", @"description",
////									picData, @"picture",
//
//								   nil];

	
//	NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"I'm using the Hackbook for iOS app222", @"name",
//                                   @"Hackbook for iOS.", @"caption",
//                                   @"Check out Hackbook for iOS to learn how you can make your iOS apps social using Facebook Platform.", @"description",
//								   //                                   @"http://m.facebook.com/apps/hackbookios/", @"link",
////                                   @"http://www.facebookmobileweb.com/hackbook/img/facebook_icon_large.png", @"picture",
//								   //                                   actionLinksStr, @"actions",
//                                   nil];
//	
//    HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//	[facebook dialog:@"feed" andParams:params2 andDelegate:self];

	
}


#pragma mark - FBSessionDelegate Methods



- (void)fbDidLogin {
	
	NSLog(@"fb Did login");
	AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	Facebook *facebook = [appDelegate facebook];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
	
}


/**
 * Called when the user has logged in successfully.
 */

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
	//    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"fb not login");
	//    [pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
	//    pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
	//    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [self fbDidLogout];
}


#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	
	
    NSLog(@"received response");
	
	//发声音作为提示更好
	
//	[[LoadingView sharedLoadingView]showTitle:@"Added into Facebook" inView:[delegate view]];
//	[[AudioController sharedInstance]play:AudioTypeFacebook delegate:nil];
	[[LoadingView sharedLoadingView]addTitle:LString(@"Done") inView:[delegate view]];
	[Flurry logEvent:@"Facebook Sent"];
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
	
	NSLog(@"result:%@",result);
	
   }

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
	
	
	[[LoadingView sharedLoadingView] addTitle:LString(@"tryitagain") inView:[delegate view]];
}



@end
