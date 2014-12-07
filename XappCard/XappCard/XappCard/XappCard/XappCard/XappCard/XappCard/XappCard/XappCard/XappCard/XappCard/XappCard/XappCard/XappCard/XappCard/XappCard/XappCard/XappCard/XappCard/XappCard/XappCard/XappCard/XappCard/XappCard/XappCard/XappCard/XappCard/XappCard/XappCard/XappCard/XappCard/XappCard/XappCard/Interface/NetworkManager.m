//
//  Connection.m
//  SoundRecording
//
//  Created by AppDevelopper on 31.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkManager.h"
#import "Constant.h"


@implementation NetworkManager



+ (ASIHTTPRequest*)requestUpdateMsg:(id)delegate{
	
//	NSString *testServerStr = @"http://localhost/xappsoft/mobile/updateApp.php";
	NSString *serverStr = @"http://www.xappsoft.de/mobile/updateApp.php";
	
	NSString *str=[serverStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"urlStr # %@",str);
	
	NSURL *url = [NSURL URLWithString :str];

	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:kAppID forKey:@"app_id"];
	[request setDelegate:delegate];
	[request startAsynchronous];
	return request;
}
#pragma mark -
+(void)signInAndUp:(NSString*)username pw:(NSString*)pw avatar:(NSData*)avatar delegate:(id)delegate{
    
    NSString *urlStr = kHost;
    urlStr = [urlStr stringByAppendingString:@"signinandup"];
//    NSLog(@"url:%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:pw forKey:@"passwd"];
    [request addData:avatar withFileName:@"avatar.png" andContentType:@"image/png" forKey:@"avatar"];
    [request setDelegate:delegate];
    [request startAsynchronous];
    
	
}

//ProfileVC
+ (void)updateUserProfile:(id)user delegate:(id)delegate{
    
    NSString *urlStr = kHost;
    urlStr = [urlStr stringByAppendingString:@"updateUserProfile"];
    NSLog(@"url:%@",urlStr);
     
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSString *username = @"Username";
    NSString *land = @"Land";
    NSLog(@"Connect land:%@",land);
    NSString *code = @"Code";
    NSData *avatar;
    int addVote = 0;
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"landStatus"] == 1) {
        addVote++;
        [defaults setInteger:2 forKey:@"landStatus"];
    }

    if ([defaults integerForKey:@"avatarStatus"] == 1) {
        addVote++;
        [defaults setInteger:2 forKey:@"avatarStatus"];
    }
	
    [defaults synchronize];
    NSLog(@"addVote:%d",addVote);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:land forKey:@"land"];
    [request setPostValue:code forKey:@"code"];
    [request setPostValue:[NSString stringWithFormat:@"%d",addVote] forKey:@"addVote"];
    [request addData:avatar withFileName:@"avatar.png" andContentType:@"image/png" forKey:@"avatar"];
    [request setDelegate:delegate];
    [request startAsynchronous];
}

+(void)uploadFile:(NSString*)fileName category:(int)category slot:(int)slot delegate:(id)delegate{
      NSString *urlString = [kHost stringByAppendingString:@"upload"];
    NSURL *url = [NSURL URLWithString:urlString];

 //   NSLog(@"url:%@",url);
//    NSString *filePath = [fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSString *filePath = fileName;
    NSLog(@"filepath:%@",filePath);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSString *username = [[[NSUserDefaults standardUserDefaults] valueForKey:@"username"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:[NSNumber numberWithInt:category] forKey:@"category"];
    [request setPostValue:[NSNumber numberWithInt:slot] forKey:@"slot"];
    [request setFile:filePath forKey:@"file"];
    [request setDelegate:delegate];
    [request startAsynchronous];

}

+ (void)displayChart:(int)category username:(NSString*)username  delegate:(id)delegate{

    NSString *urlStr = kHost;
    urlStr = [urlStr stringByAppendingString:@"charts"];
    NSLog(@"url:%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSNumber numberWithInt:category] forKey:@"category"];
    [request setPostValue:username forKey:@"username"];
    [request setDelegate:delegate];
    [request startAsynchronous];
}

+ (void)displayChart:(int)category username:(NSString*)username page:(int)page delegate:(id)delegate{
	
    NSString *urlStr = kHost;
    urlStr = [urlStr stringByAppendingString:@"charts"];
    NSLog(@"url:%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSNumber numberWithInt:category] forKey:@"category"];
    [request setPostValue:username forKey:@"username"];
	[request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [request setDelegate:delegate];
    [request startAsynchronous];
}

+ (void)updateHit:(int)audioId category:(int)category searchString:(NSString*)searchString delegate:(id)delegate{
    NSString *urlStr = kHost;
    urlStr = [urlStr stringByAppendingString:@"updateHit"];
    NSLog(@"url:%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[NSNumber numberWithInt:audioId] forKey:@"audioId"];
    [request setPostValue:[NSNumber numberWithInt:category] forKey:@"category"];
    [request setPostValue:searchString forKey:@"searchString"];
    [request setDelegate:delegate];
    [request startAsynchronous];

}

+ (void)updateVoteWithAudio:(int)audioId quantity:(int)quantity username:(NSString*)username category:(int)category searchString:(NSString*)searchString delegate:(id)delegate{
    NSString *urlStr = kHost;
    urlStr = [urlStr stringByAppendingString:@"updateVote"];
    NSLog(@"url:%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSNumber numberWithInt:audioId] forKey:@"audioId"];
    [request setPostValue:[NSNumber numberWithInt:quantity] forKey:@"quantity"];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:[NSNumber numberWithInt:category] forKey:@"category"];
    [request setPostValue:searchString forKey:@"searchString"];
    [request setDelegate:delegate];
    [request startAsynchronous];

}


+ (void)insertRecommendation:(NSString*)code delegate:(id)delegate{

    
    NSString *urlString = [kHost stringByAppendingString:@"recommandation"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setPostValue:code forKey:@"code"];
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"] forKey:@"username"];
    [request setDelegate:delegate];
    [request startAsynchronous];

}

+ (void)updateIAPVotes:(int)votes delegate:(id)delegate{
    NSString *urlString = [kHost stringByAppendingString:@"iap"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setPostValue:[NSNumber numberWithInt:votes] forKey:@"vote"];
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"] forKey:@"username"];
    [request setDelegate:delegate];
    [request startAsynchronous];
}

+ (void)getAllLands:(id)param delegate:(id)delegate{
    NSString *urlString = [kHost stringByAppendingString:@"lands"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setDelegate:delegate];
    [request startAsynchronous];

}

+ (void)test:(id)delegate{

	NSString *str=[@"http://douban.fm/j/mine/playlist?type=n&h=&channel=0&from=mainsite&r=4941e23d79" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [NSURL URLWithString :str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:delegate];
	[request startAsynchronous];
}


@end
