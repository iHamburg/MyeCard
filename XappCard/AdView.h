//
//  AdView.h
//  MyeCard
//
//  Created by AppDevelopper on 02.02.13.
//
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"

#define kKeyPathAdDisplaying @"isAdDisplaying"



@interface AdView : UIView<ADBannerViewDelegate, GADBannerViewDelegate>{
	
	ADBannerView *_iadView;
	GADBannerView *_gadView;

}

+(id)sharedInstance;
+(void)releaseSharedInstance;

@property (nonatomic, assign) BOOL isAdDisplaying;
- (void)setupIAD;


@end

