//
//  ExportController.m
//  FirstThings_Uni
//
//  Created by  on 12.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MEExportController.h"
#import "MERootViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"


@implementation MEExportController


- (id)init{
	if (self = [super init]) {
		
		_root = [MERootViewController sharedInstance];
        tweetInitText = @"";
        tweetDefaultImg = nil;
        appIDStr = kAppID;
	}
	return self;
}



#pragma mark - Save Image


- (void)saveImageInAlbum:(UIImage*)img{
	
	ALAssetsLibrary* library  = [[ALAssetsLibrary alloc] init];
    
	[library saveImage:img toAlbum:kAppName withCompletionBlock:^(NSError *error){
	
		if (!error) {
			[[LoadingView sharedLoadingView]addTitle:@"Saved!" inView:[[MERootViewController sharedInstance]view]];
		}else{
			NSLog(@"error # %@",[error description]);
			[[LoadingView sharedLoadingView]addTitle:@"Please try it again later." inView:[[MERootViewController sharedInstance]view]];
		}
	}];
	
	
}

 @end
