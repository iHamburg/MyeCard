//
//  FBViewController.h
//  FacebookTest
//
//  Created by  on 12.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "Utilities.h"


#define FBAppID @"189613711144314"

@interface FBViewController : UIViewController<FBSessionDelegate, FBRequestDelegate, FBDialogDelegate>{

	id delegate;

}
+ (id)sharedInstance;


- (void)feed;
- (void)sendImage:(UIImage*)img delegate:(id)delegate;



@end
