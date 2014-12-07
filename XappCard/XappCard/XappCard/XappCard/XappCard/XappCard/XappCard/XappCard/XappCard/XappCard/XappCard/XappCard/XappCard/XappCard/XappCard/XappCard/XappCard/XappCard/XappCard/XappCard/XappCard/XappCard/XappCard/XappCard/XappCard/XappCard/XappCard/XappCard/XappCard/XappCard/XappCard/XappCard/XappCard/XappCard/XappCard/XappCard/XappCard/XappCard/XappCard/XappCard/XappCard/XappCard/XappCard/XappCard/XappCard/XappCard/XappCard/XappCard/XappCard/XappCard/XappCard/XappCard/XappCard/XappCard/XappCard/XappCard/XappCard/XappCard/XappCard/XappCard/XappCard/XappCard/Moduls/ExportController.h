//
//  ExportController.h
//  iCamAlbum
//
//  Created by AppDevelopper on 13-10-12.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>
//#import "Flurry.h"


@interface ExportController : NSObject<MFMailComposeViewControllerDelegate> {
    
    UIViewController *_root;
    NSString *tweetInitText;
    UIImage *tweetDefaultImg;
    
    NSString *appIDStr;

    MFMailComposeViewController* _mailPicker;
}

@property (nonatomic, strong) MFMailComposeViewController* mailPicker;

+(id)sharedInstance;

- (void)sendEmailWithImages:(NSArray*)images;
- (void)sendEmail:(NSDictionary *)info;

- (void)sendTweetWithText:(NSString*)text image:(UIImage*)image;

- (void)linkToAppStoreWithID:(NSString*)appID;

- (void)toRate;

@end
