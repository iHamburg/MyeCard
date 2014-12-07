//
//  AdView.m
//  MyeCard
//
//  Created by AppDevelopper on 02.02.13.
//
//

#import "AdView.h"
#import "MERootViewController.h"
#import <QuartzCore/QuartzCore.h>

NSString *const NotificationAdChanged = @"ADChanged";

@interface AdView()



@end

@implementation AdView


//static bool _isIAD = NO;
//static bool _iadAvailable = NO;

static bool _isGADLoaded = NO;

static NSString *MY_BANNER_UNIT_ID=@"a1510c1bf584fb4";    // myecard
//static NSString *MY_BANNER_UNIT_ID=@"a15226a64014da4";   //iCA
//static NSString *MY_BANNER_UNIT_ID=@"a1510c1a0d38138"; // Everalbum
//static NSString *MY_BANNER_UNIT_ID=@"a1510e69df21727"; // TinyKitchen


@synthesize isAdDisplaying;

- (void)setIsAdDisplaying:(BOOL)isAdDisplaying_{
    isAdDisplaying = isAdDisplaying_;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAdChanged object:self];
}


#pragma mark -
static id sharedInstance;

+(id)sharedInstance{

    if (isPaid() || isIAPFullVersion) {
        return nil;
    }
    
    if (sharedInstance == nil) {
		CGFloat hBanner = isPad?66:32;
		sharedInstance = [[[self class] alloc]initWithFrame:CGRectMake(0, _h, _w, hBanner)];
	}
	
	return sharedInstance;
	
}


+(void)releaseSharedInstance{

    sharedInstance = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADChanged" object:nil];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleResignActive)
													 name:UIApplicationWillResignActiveNotification
												   object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleBecomeActive)
													 name:UIApplicationDidBecomeActiveNotification
												   object:nil];

//		static NSSet* supportedCountries = nil;
//		if (supportedCountries == nil)
//		{
//			supportedCountries = [NSSet setWithObjects:
//								  @"ES", // spain
//								  @"US", // usa
//								  @"UK", // united kingdom
//								  @"CA", // canada
//								  @"FR", // france
//								  @"DE", // german
//								  @"IT", // italy
//								  @"JP", // japan
//								  nil];
//		}
//		
//		NSLocale* currentLocale = [NSLocale currentLocale];  // get the current locale.
//		NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
//		NSLog(@"contryCode # %@",countryCode);
//		
//		if ([supportedCountries containsObject:countryCode]) {
//			_iadAvailable = YES;
//		}
//		else{
//			_iadAvailable = NO;
//		}
//		
//		// 优先调用IAD
//		
//		
//		if (_iadAvailable) { // iad
//
//			[self setupIAD];
//		}
//		else{ //gad
//			[self setupGAD];
//		}
		
//        [self setupGAD];
	
        [self setupIAD];
    }
    return self;
}

-(void)dealloc{
    L();
}

- (void)handleResignActive{
//	L();
	
	
}

- (void)handleBecomeActive{
//	L();

//	[[ViewController sharedInstance] initBanner];
}
#pragma mark - iAD Banner


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	L();

//	self.hidden = NO;
	
	self.isAdDisplaying = YES;
	
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	//	L();
	NSLog(@"error # %@",[error localizedDescription]);

//	self.hidden= YES;
	
	self.isAdDisplaying = NO;

	//iad fail 自动调用 admob
//	[self setupGAD];
	
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	
	
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
	L();
	
}
#pragma mark -

- (void)setupIAD{
	L();
	if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
		_iadView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
		
	}
	else {
		_iadView = [[ADBannerView alloc] init];
	}
	_iadView.delegate = self;
	_iadView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
	
	[self addSubview:_iadView];
	
	
}

//- (void)setupGAD{
//	L();
//
//	_gadView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerLandscape origin:CGPointZero];
//	
//	//设置阴影
//	_gadView.layer.shadowOffset = CGSizeMake(5, 3);
//	_gadView.layer.shadowOpacity = 0.9;
//	_gadView.layer.shadowColor = [UIColor grayColor].CGColor;
//	
//	_gadView.adUnitID = MY_BANNER_UNIT_ID;
//	_gadView.rootViewController = [MERootViewController sharedInstance];
//	
//	_gadView.delegate = self;
//	[_gadView loadRequest:[GADRequest request]];
//	
//	[self addSubview:_gadView];
//	
//	[_iadView removeFromSuperview];
//	_iadView.delegate = nil;
//	_iadView = nil;
//	
//}



@end
