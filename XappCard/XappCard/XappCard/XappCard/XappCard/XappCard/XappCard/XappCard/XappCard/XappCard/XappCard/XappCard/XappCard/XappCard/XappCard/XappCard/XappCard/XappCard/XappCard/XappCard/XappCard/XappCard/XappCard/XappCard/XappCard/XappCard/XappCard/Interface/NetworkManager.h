//
//  Connection.h
//  SoundRecording
//
//  Created by AppDevelopper on 31.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@interface NetworkManager : NSObject {
    
}

+ (void)test:(id)delegate;

/**
 @brief 查询最新的版本号
 
 */
+ (ASIHTTPRequest*)requestUpdateMsg:(id)delegate;

+ (void)signInAndUp:(NSString*)username pw:(NSString*)pw avatar:(NSData*)avatar delegate:(id)delegate;
+ (void)uploadFile:(NSString*)fileName category:(int)category slot:(int)slot delegate:(id)delegate;
+ (void)updateUserProfile:(id)user delegate:(id)delegate;
+ (void)displayChart:(int)category username:(NSString*)username delegate:(id)delegate;
+ (void)displayChart:(int)category username:(NSString*)username page:(int)page delegate:(id)delegate;
+ (void)updateHit:(int)audioId category:(int)category searchString:(NSString*)searchString delegate:(id)delegate;
+ (void)updateVoteWithAudio:(int)audioId quantity:(int)quantity username:(NSString*)username category:(int)category searchString:(NSString*)searchString delegate:(id)delegate;
+ (void)insertRecommendation:(NSString*)code delegate:(id)delegate;
+ (void)updateIAPVotes:(int)votes delegate:(id)delegate;
+ (void)getAllLands:(id)param delegate:(id)delegate;



@end
