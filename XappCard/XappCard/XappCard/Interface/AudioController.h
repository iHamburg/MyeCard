//
//  AudioController.h
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import  <AVFoundation/AVFoundation.h>
#import "Utilities.h"

typedef enum{
	AudioTypeFacebook
}AudioType;

@interface AudioController : NSObject{

	NSArray *audioPlayers;


}

+(id)sharedInstance;

- (void)play:(AudioType)type delegate:(id)delegate;

@end
