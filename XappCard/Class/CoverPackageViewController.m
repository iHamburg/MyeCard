//
//  CoverPackageViewController.m
//  MyeCard
//
//  Created by AppDevelopper on 03.10.12.
//
//

#import "CoverPackageViewController.h"

@interface CoverPackageViewController ()

@end

@implementation CoverPackageViewController

@synthesize vc, thumbImgVs , type;

- (void)setType:(CoverPackageType)_type{
	type = _type;
	
	[self setup];
}
- (void)loadView{
	CGFloat height = isPad?500:320;
	CGRect rect = CGRectMake(0, 0, 480, height);
	CGRect containerRect = CGRectMake(0, 0, 480, height);
	if(isPhoneRetina4){
		rect = CGRectMake(0, 0, 568, height);
		containerRect = CGRectMake(44, 0, 480, height);
	}
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIView *container = [[UIView alloc]initWithFrame:containerRect];
	
	

	
	naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, isPad?44:32)];
	naviBar.barStyle = UIBarStyleBlack;
	UINavigationItem *naviItem = [[UINavigationItem alloc]initWithTitle:SHalloweenTitle];
	backBB = [[UIBarButtonItem alloc]initWithTitle:SCancel style:UIBarButtonItemStyleBordered target:self action:@selector(buttonClicked:)];
	buyBB = [[UIBarButtonItem alloc]initWithTitle:SBuy style:UIBarButtonItemStyleDone target:self action:@selector(buttonClicked:)];
	naviItem.leftBarButtonItem = backBB;
	naviItem.rightBarButtonItem = buyBB;
	naviBar.items = @[naviItem];
	
	headerL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 480, 30)];
	headerL.text = SHalloweenPackagePrice;
	headerL.textAlignment = UITextAlignmentCenter;
	headerL.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tableviewHeader.png"]];
	headerL.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
	headerL.textColor = [UIColor whiteColor];
	headerL.shadowColor = [UIColor colorWithWhite:0 alpha:0.44];
	headerL.shadowOffset = CGSizeMake(0, 1);
	headerL.minimumFontSize = 12;
	headerL.numberOfLines = 1;
	headerL.adjustsFontSizeToFitWidth = YES;
	
	scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(naviBar.frame), 480, height-naviBar.frame.size.height)];
	scrollView.contentSize = CGSizeMake(0, 930);

	imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 35, 480, 827)];
	imgV.image = [UIImage imageWithContentsOfFileUniversal:@"Halloween_IAP_Preview.jpg"];

	imgV.userInteractionEnabled = YES;
	[imgV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyPackage)]];
	
	
	UIImage *imgNormal = [UIImage imageNamed:@"Info_email.png"];
	UIImage *imgStretchable = [imgNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	restoreB = [UIButton buttonWithFrame:CGRectMake(20, 867, container.frame.size.width-40, 50) title:SRestore image:imgStretchable target:self actcion:@selector(restore)];
	[restoreB.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
	
	[scrollView addSubview:headerL];
	[scrollView addSubview:imgV];
	[scrollView addSubview:restoreB];
	
	[container addSubview:scrollView];
	[self.view addSubview:container];
	[self.view addSubview:naviBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)setup{
	// title, imgV.image
	if (type == CoverPackageTypeHalloween) {
		imgV.image = [UIImage imageWithContentsOfFileUniversal:@"Halloween_IAP_Preview.jpg"];
		headerL.text = SHalloweenPackagePrice;
//		iapIdentifier = kIAPHalloween;

	}
	else if(type == CoverPackageTypeThanksgiving){
		imgV.image = [UIImage imageWithContentsOfFileUniversal:@"Thanksgiving_IAP_Preview.jpg"];
		headerL.text = LString(@"ThanksgivingPackagePrice");
//		iapIdentifier = kIAPThanksgiving;
	}
	else if(type == CoverPackageTypeAnniversary){
		imgV.image = [UIImage imageWithContentsOfFileUniversal:@"Preview_Anniversary.jpg"];
		headerL.text = LString(@"AnniveraryPackageTitle");
		iapIdentifier = kIAPAnniversary;
	}
	else if(type == CoverPackageTypeChristmas){
		imgV.image = [UIImage imageWithContentsOfFileUniversal:@"Christmas_IAP_Preview.jpg"];
		headerL.text = LString(@"ChristmasPackageTitle");
//		iapIdentifier = kIAPChristmas;

	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSUInteger)supportedInterfaceOrientations{

	return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
	L();
	if (sender == backBB) {
		[self cancel];
	}
	else if(sender == buyBB){
		[self buyPackage];
	}
}

#pragma mark -
- (void)cancel{
	L();

//	[vc dismissPopVC];
}

- (void)buyPackage{
	L();
	
	[[MyStoreObserver sharedInstance]requestProductWithIdendifier:iapIdentifier delegate:self];

}

- (void)restore{
	L();
	[[MyStoreObserver sharedInstance]checkRestoredItemsWithDelegate:self];
}

#pragma mark - IAP
//- (void)didCompleteIAPWithIdentifier:(NSString*)identifier{
//	L();
//	NSLog(@"iap:%@ is completed",identifier);
//	
////
////	if ([identifier isEqualToString:kIAPHalloween] || ) {// buy
////		[[RootViewController sharedInstance] enableIAPCoverpackage];
////	}
////
////	else if([identifier isEqualToString:kIAPThanksgiving]){ //buy or reset
////		[[RootViewController sharedInstance] enableIAPCoverpackage];
////	}
//	[[RootViewController sharedInstance]enableIAPCoverpackage];
//	
//	// dismiss self
////	[vc dismissPopVC];
//}
- (UIView*)viewForLoading{
	return self.view;
}

@end
