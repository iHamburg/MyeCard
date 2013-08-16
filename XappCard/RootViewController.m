//
//  ViewController.m
//  XappCard
//
//  Created by Xappsoft on 26.11.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "RootViewController.h"
#import "CoverViewController.h"
#import "ContentViewController.h"
#import "ZettelViewController.h"
#import "TextLabelViewController.h"
#import "PictureWithFrameView.h"
#import "SettingViewController.h"
#import "InstructionViewController.h"
#import "LoveViewController.h"
#import "CardsViewController.h"
#import "DateViewController.h"
#import "CoverflowViewController.h"
#import "Info2ViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "NetworkManager.h"


@implementation RootViewController


@synthesize coverVC,contentVC;
@synthesize photoSource,r,containerSize;
@synthesize photoBB;
@synthesize card;
@synthesize popOverStatus,toolbar;
@synthesize settingVC,loveVC,zettelVC,textLabelVC,cardsVC,dateVC,coverFlowVC,info2VC;
@synthesize firstVersion,lastVersion,thisVersion,isFirstOpen,isUpdateOpen;


static CGFloat _hAdBanner;

- (SettingViewController*)settingVC{
	if (!settingVC) {
		settingVC = [[SettingViewController alloc] init];
		settingVC.rootVC = self;
		settingVC.view.alpha = 1;
	}
	return settingVC;
}

- (LoveViewController*)loveVC{
	if (!loveVC) {
		loveVC = [[LoveViewController alloc] init];
		loveVC.rootVC = self;
		loveVC.view.alpha = 1;
	}
	return loveVC;
}

- (ZettelViewController*)zettelVC{
	if (!zettelVC) {
		[contentVC hideStep:3];
		zettelVC = [[ZettelViewController alloc] init];
		zettelVC.rootVC = self;
		zettelVC.view.alpha = 1;
	}
	return zettelVC;
}

- (TextLabelViewController*)textLabelVC{
	if (!textLabelVC) {
		textLabelVC = [[TextLabelViewController alloc] init];
		textLabelVC.rootVC = self;
		textLabelVC.view.alpha = 1;
	}
	return textLabelVC;
}

- (CardsViewController*)cardsVC{
	if (!cardsVC) {
		cardsVC = [[CardsViewController alloc]init];
		cardsVC.rootVC = self;
		cardsVC.view.alpha = 1;
	}
	return cardsVC;
}

- (void)setCard:(Card *)_card{
	card = _card;
	card.changed = YES;
	[self setup];
}



#pragma mark - View lifecycle
+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			sharedInstance = [[RootViewController alloc] initWithNibName:@"RootViewController_iPhone" bundle:nil];
		} else {
			sharedInstance = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
		}
	}
	
	return sharedInstance;
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
//		L();
		
		// Toolbar Button
		fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		
		fixed.width = isPad?10:0;
		flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		//BB for Cover
		UIBarButtonItem *addB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cards.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		addB.title = LString(@"Cards Dock");
		addB.tag = ToolbarTagAdd;
		
		UIBarButtonItem *switchB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_content.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		switchB.title = NSLocalizedString(@"iToContent", nil);
		switchB.tag = ToolbarTagSwitch;

		
		coverPhotoBB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_background.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		coverPhotoBB.title = NSLocalizedString(@"iCoverPhoto", nil);
		coverPhotoBB.tag = ToolbarTagCoverPhoto;
		
		coverTextBB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_text.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		coverTextBB.tag = ToolbarTagCoverText;
		coverTextBB.title = NSLocalizedString(@"iText", nil);
		
		UIBarButtonItem *chooseB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_choose.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		chooseB.title = NSLocalizedString(@"iChoose", nil);
		chooseB.tag = ToolbarTagChooseCover;
		
		UIBarButtonItem *infoB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_information.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		infoB.tag = ToolbarTagInfo;
		
		// BB for Content
		UIBarButtonItem *switchContentB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_cover.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		switchContentB.title = NSLocalizedString(@"iToCover", nil);
		switchContentB.tag = ToolbarTagSwitch;
		
		photoBB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_photo.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		photoBB.title = NSLocalizedString(@"iPhoto", nil);
		photoBB.tag = ToolbarTagContentPhoto;
		
		contentTextBB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_text.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		contentTextBB.title = NSLocalizedString(@"iText", nil);
		contentTextBB.tag = ToolbarTagContentText;
		
		UIBarButtonItem *zettelB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_zettel.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		zettelB.title = NSLocalizedString(@"iZettel", nil);
		zettelB.tag = ToolbarTagZettel;
		
		UIBarButtonItem *loveB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_love.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		loveB.title = NSLocalizedString(@"iLove", nil);
		loveB.tag = ToolbarTagLove;
		
		UIBarButtonItem *actionB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_action2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		actionB.title = NSLocalizedString(@"iAction", nil);
		actionB.tag = ToolbarTagAction;
		
		UIBarButtonItem *settingB = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_setting.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarButtonClicked:)];
		settingB.title = NSLocalizedString(@"iSetting", nil);
		settingB.tag = ToolbarTagSetting;
		
		float width = isPad?70:45;
		switchB.width= width;
		coverPhotoBB.width = width;
		coverTextBB.width = width;
		chooseB.width = width;
		switchContentB.width = width;
		photoBB.width = width;
		contentTextBB.width = width;
		zettelB.width = width;
		loveB.width = width;
		actionB.width = width;
		settingB.width = width;
		
		coverItems = [NSArray arrayWithObjects:fixed,addB,flexible,switchB,fixed,coverPhotoBB,fixed,coverTextBB,
					  fixed,chooseB,flexible,infoB,fixed,nil];
		
		contentItems =  [NSArray arrayWithObjects:fixed,addB,flexible,switchContentB,fixed,photoBB,fixed,contentTextBB,
						 fixed,zettelB,fixed,loveB,fixed,actionB,fixed,settingB,flexible,infoB,fixed,nil];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self checkVersion];
	
	card = [Controller sharedController].firstCard;
	
	r = [UIScreen mainScreen].bounds;
	r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180));
	r.origin = CGPointZero;
	
	w = r.size.width;
	h = r.size.height;
	
	//iphone
	containerRect = CGRectMake(0, 0, 480, 320);
	toolbarRect = CGRectMake(0, h-32, w, 32);
	bannerRect = CGRectMake(0, h-32, w, 32);
	bannerOutRect = CGRectMake(0, h, w, 32);
	containerWithBannerRect =containerRect;
	toolbarWithBannerRect = toolbarRect;
	_hAdBanner = isPad?90:32;
	
	if (isPad) {
		containerRect = CGRectMake(32, 32, 960, 640);
		containerWithBannerRect = CGRectMake(32, 9, 960, 640);
		toolbarRect = CGRectMake(0, h-44, w, 44);
		toolbarWithBannerRect = CGRectMake(0, 658, 1024, 44);
		bannerRect = CGRectMake(0, h-66, w, 66);
		bannerOutRect = CGRectMake(0, h, w, 66);
	}
	else if(isPhoneRetina4){ // iphone 5

		containerRect = CGRectMake(44, 0, 480, 320);
		containerWithBannerRect =containerRect;
		toolbarWithBannerRect = toolbarRect;

	}
	
	
	self.view.backgroundColor = [UIColor blackColor];
	
	container = [[UIView alloc]initWithFrame:containerRect];
	container.backgroundColor = [UIColor blackColor];
	containerSize = container.bounds.size;
	
	contentVC = [[ContentViewController alloc] initWithCard:card];
	[contentVC.view setSize:isPad?CGSizeMake(960, 640):CGSizeMake(480, 320)];
	contentVC.rootVC = self;
	
	coverVC = [[CoverViewController alloc] initWithCard:card];
	coverVC.rootVC = self;
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
	tap.delegate = self;
	[container addGestureRecognizer:tap];
	
	[container addSubview:coverVC.view];
	[container insertSubview:contentVC.view belowSubview:coverVC.view];
	
	
	imgPicker = [[UIImagePickerController alloc] init];
	imgPicker.delegate = self;
	imgPicker.allowsEditing = NO;
	imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
	
	
	
	self.textLabelVC.view.alpha = 1;
	self.zettelVC.view.alpha = 1;
	self.loveVC.view.alpha = 1;
	self.settingVC.view.alpha = 1;


	
	if (isPad) {
		UIViewController *vc = [[UIViewController alloc] init];
		popVC = [[UIPopoverController alloc] initWithContentViewController:vc];
		popVC.delegate = self;
		
	} 


	
	[self.view insertSubview:container belowSubview:toolbar];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(willDismissPopOverViewController)
												 name:NotifiRootDismiss object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotificationOpenTextViewController:)
												 name:NotifiRootOpenTextLabelVC object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotificationResignActive:)
												 name:UIApplicationWillResignActiveNotification
											   object: [UIApplication sharedApplication]];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
	
	actionActionSheet = [[UIActionSheet alloc] initWithTitle:nil
													delegate:self
										   cancelButtonTitle:nil
									  destructiveButtonTitle:nil
										   otherButtonTitles:NSLocalizedString(@"emailPNG", nil),LString(@"send it later"),NSLocalizedString(@"Save PNG", nil),@"Facebook",nil];
	
	if (kVersion>=5.0) {
		[actionActionSheet addButtonWithTitle:@"Twitter"];
	}

	
	[self preLoad];
	
	
	[self initBanner];
	
//	if (isUpdateOpen) {
//		// show whatsnew alert
//		
////		UIAlertView *whatsNewAlert = [[UIAlertView alloc]initWithTitle:@"What's new" message:<#(NSString *)#> delegate:<#(id)#> cancelButtonTitle:<#(NSString *)#> otherButtonTitles:<#(NSString *), ...#>, nil]
//	}
	

}



// 如果是iphone中调用了presentModalVC的话，viewdidAppear还是会不停出现的！！
- (void)viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];

	[self.view insertSubview:container belowSubview:toolbar];
	
	
	if (isPhone) {
	
		toolbar.frame = CGRectMake(0, 320-32, toolbar.width, 32);
	
	}
	
	
	[self test];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    
}

- (NSUInteger)supportedInterfaceOrientations{
	//	L();
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
	// Release any cached data, images, etc that aren't in use.
	
	if (!instrumentVC.view.superview) {
		instrumentVC = nil;
	}

//如果popVC显示的话，VC会在popVC被dismiss后dealloc
//    self.infoVC = nil;
	self.loveVC = nil;
	self.zettelVC = nil;
	self.settingVC = nil;
	self.textLabelVC = nil;
}

/**
 
 当切换当前card的时候调用
 */

- (void)setup{
	L();
	// cover setup
	coverVC.card = card;
	
	// content setup
	contentVC.card = card;

//	//if no cover is set -> to choose
	if (card.coverBgUrl== nil && ISEMPTY(card.coverImgName)) {
		[self toCoverflow];
	}
	else{
		[self toCover:NO];
	}

}


- (void)checkVersion{
	
	
	firstVersion = [[NSUserDefaults standardUserDefaults]floatForKey:kFirstVersionKey];
	lastVersion = [[NSUserDefaults standardUserDefaults]floatForKey:kLastVersionKey];
	thisVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey] floatValue];
	
	if (firstVersion == 0.0) { // 第一次安装app
		isFirstOpen = YES;
		
		firstVersion =  [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey] floatValue];
		[[NSUserDefaults standardUserDefaults]setFloat:firstVersion forKey:kFirstVersionKey];
		
		lastVersion = firstVersion;
		[[NSUserDefaults standardUserDefaults]setFloat:lastVersion forKey:kLastVersionKey];
		
	}
	else{ // 已经安装过app，再次打开
		if (thisVersion != lastVersion) {
			isUpdateOpen = YES;
		}
		
		[[NSUserDefaults standardUserDefaults]setFloat:thisVersion forKey:kLastVersionKey];
	}
	
	

}

/**
 这个是在所有的cover，contentVC都完成后才调用的
 */
- (void)preLoad{

	if (isFirstOpen) {

		[self setTBItems:RootModeChoose];
		
		[self toInstruction];
		
		if (!isPaid() && !isIAPFullVersion) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:LString(@"Tip") message:LString(@"UpdateMsg3.0") delegate:nil cancelButtonTitle:LString(@"I know about it") otherButtonTitles:nil];
			[alert show];
		}
		
		return;
	}
	else if(isUpdateOpen){
		
		// 告诉那些free 没有 upgrade的user，只要upgrade to fullversion 就能 获得 所有coverset
		if (!isPaid() && !isIAPFullVersion) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:LString(@"Limited Time Only") message:LString(@"UpdateMsg3.0") delegate:nil cancelButtonTitle:LString(@"Cancel") otherButtonTitles:nil];
			[alert show];
		}
	}

	
    [self setTBItems:RootModeCover];
	

}


#pragma mark - IBAction


// photo and text will be opened from another locatoin, so it's reasonable, add methode to handle these functions
- (IBAction)toolbarButtonClicked:(id)sender{
	NSLog(@"rootmode : %d",[[Controller sharedController]rootMode]);
	
	int tag = [sender tag];
	
	//在点击之前就dismiss，如果再次popoverstatus还是原来的status－》不再打开(乒乓键)
	//确保popViewController和switch的时候是没有popover窗口的。
	// 如果popOverStatus！＝PS_None,说明popVC是在显示的时候按的BB，那么就要考虑乒乓问题
	// 如果＝＝ PS_None,直接打开就可以了
	
	// 这里没有调用willDismissPopover是因为不想把popoverstatus设成none，当然也可以加个flag来控制
	
	// Dismiss all popover
	if (actionActionSheet.visible) {
		[actionActionSheet dismissWithClickedButtonIndex:-2 animated:NO];
	}
	
	// dismiss popVC
	if (isPad) {
		[popVC dismissPopoverAnimated:NO];
		
	}
	else{
		[self dismissModalViewControllerAnimated:YES];
	}
	// set menu unvisiable
	
	[[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
	
	
	if (tag == ToolbarTagAdd) { // cards
		
		int cardIndex = [[Controller sharedController]indexOfCard:card];
		
		[self toCards:cardIndex];
		
		popOverStatus = PS_None;
	}
	else if(tag == ToolbarTagSwitch){ // switch between content and cover
		[self switchCoverAndContent:sender];
	}

	else if(tag == ToolbarTagCoverPhoto) {
		
		photoSource = RPSCover;
		[self popViewController:imgPicker withStatus:PS_OneImage sender:sender];
		
	}
	else if(tag == ToolbarTagCoverText) {
		if (card.coverMaskFlag) {
			
			coverVC.controlMode = ControlModeText;
		}
	
		[self popText:[[TextWidget alloc]initWithFrame:CGRectMake(0, 0, 300, 200)]];
		
	}
	else if(tag == ToolbarTagChooseCover) { //

		[self toCoverflow];
	}
	else if(tag == ToolbarTagInfo) {
		
		[self toInfo];
	}
	else if(tag == ToolbarTagContentPhoto) {
		
		if ([contentVC picNum]>=MAXPICKEDPHOTO) {
			
			[[LoadingView sharedLoadingView]addTitle:NSLocalizedString(@"MaxPictureTitle", nil) inView:self.view];
			return;
		}
		
		[contentVC hideStep:2];
		
		self.photoSource = RPSContent;
		[self popViewController:imgPicker withStatus:PS_OneImage sender:sender];
		
	}
	else if(tag == ToolbarTagContentText) {
		
		
		[self popText:[[TextWidget alloc]initWithFrame:CGRectMake(0, 0, 300, 200)]];
		
	}
	else if(tag == ToolbarTagZettel) {
		
		[self popViewController:self.zettelVC withStatus:PS_Zettel sender:sender];
		
	}
	else if(tag == ToolbarTagLove) {
		
		[self popViewController:self.loveVC withStatus:PS_Love sender:sender];
		
	}
	else if(tag == ToolbarTagAction) {
		//如果status不是PS_Action,就可以直接打开action，否则就把status设成None,表示关闭popVC
		//其实点击action的时候就可以生成图片了，可是有一个后台锁的问题，
		if (popOverStatus != PS_Action) {
			popOverStatus = PS_Action;
			[actionActionSheet showFromBarButtonItem:sender animated:YES];
			
		}
		else {
			popOverStatus = PS_None;
		}
	}
	else if(tag == ToolbarTagSetting) {
		
		[self popViewController:self.settingVC withStatus:PS_Setting sender:sender];
	}
	
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	//	L();
	
	// if in choose card mode, return no, let gesture in card cover run
	if (coverFlowVC.view.superview) {
		return NO;
	}
	
	return YES;
}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
	//	L();
	if (isPhone) {
		toolbar.hidden = !toolbar.hidden;
	}
	
	// 隐藏menu
	UIMenuController *menuController = [UIMenuController sharedMenuController];
	[menuController setMenuVisible:NO animated:YES];
}



#pragma mark - Navigation

// 这里没有回到cover的选项？

- (void)switchCoverAndContent:(id)sender{
	
	
	RootMode rootMode = [[Controller sharedController]rootMode];
	
	if (rootMode == RootModeCover) {  // cover -> content
		
		[self toContent];
	}
	else{ // content -> cover
		[self toCover:YES];
	}
	
}


- (void)toCoverflow{
	
	
	
	if (!coverFlowVC) {
		coverFlowVC = [[CoverflowViewController alloc] init];
		coverFlowVC.view.alpha = 1;
	}

	NSString *coverImgName = card.coverImgName;

//	int coverIndex = 0;

	if (!ISEMPTY(coverImgName)) {

		coverFlowVC.coverImgName = coverImgName;
	}


//	coverFlowVC.initialIndex = coverIndex;
	
	[self.view addSubview:coverFlowVC.view];
	
	[self.view addSubview:_adContainer];
}

- (void)toCover:(BOOL)animated{
	
	L();
	if (isPhone) {
		[_adContainer removeFromSuperview];
	}

	[self setTBItems:RootModeCover];
	
	if (animated) {
		UIViewAnimationTransition transition = UIViewAnimationTransitionCurlDown;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		[UIView setAnimationTransition:transition
							   forView:container cache:YES];
		
		[container addSubview:coverVC.view];
	
		
		[UIView commitAnimations];
	}
	else {
		[container addSubview:coverVC.view];

		
	}
	
	[self.view addSubview:container];
	[self.view addSubview:toolbar];
	
//	[self.view addSubview:_banner];
	
	[self.coverFlowVC.view removeFromSuperview];
	self.coverFlowVC = nil;
	
}

- (void)toCoverWithMask{
	
	if (isPhone) {
		[_adContainer removeFromSuperview];
	}
	
	[self setTBItems:RootModeCover];
	[container addSubview:coverVC.view];

	[self.view addSubview:container];
	[self.view addSubview:toolbar];
	
	
	[self.coverFlowVC.view removeFromSuperview];
	self.coverFlowVC = nil;
	
	
	photoSource = RPSCover;
	[self popViewController:imgPicker withStatus:PS_OneImage sender:coverPhotoBB];

	
}
- (void)toContent{
	
	if (isPhone) {
		[_adContainer removeFromSuperview];
	}
	
	[self setTBItems:RootModeContent];
	
	UIViewAnimationTransition transition = UIViewAnimationTransitionCurlUp;
	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	[UIView setAnimationTransition:transition
						   forView:container cache:YES];
	
	[container addSubview:contentVC.view];
	
	[UIView commitAnimations];
	
	[self.view addSubview:container];
	[self.view addSubview:toolbar];
	
//	[self.view addSubview:_banner];

}

- (void)toCards:(int)cardIndex{
	
	// if date is yes, to termin!
	
	L();
	
	[self saveCard];
	
	[self.cardsVC setSelectedIndex:cardIndex];
	
	[self.view addSubview:self.cardsVC.view];
	
	[self.view addSubview:_adContainer];
	
}
- (void)toInstruction{
	
	if (!instrumentVC) {
		instrumentVC = [[InstructionViewController alloc]init];

	}
	
	[self.view addSubview:instrumentVC.view];
	
}

- (void)openDateVC{
	if (!dateVC) {
		dateVC = [[DateViewController alloc] init];
		dateVC.rootVC = self;
		dateVC.view.alpha = 1;
	}
	
	[self popViewController:dateVC withStatus:PS_SendLater sender:nil];
}

- (void)toInfo{
	if (!info2VC) {
		info2VC = [[Info2ViewController alloc]init];
		info2VC.view.alpha = 1;
		info2VC.root = self;
	}
	


	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
    [self.view addSubview:info2VC.view];
    
    [UIView commitAnimations];

	
}

- (void)closeInfo{
	
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
    [info2VC.view removeFromSuperview];
	
    [UIView commitAnimations];

}


#pragma mark - Photo Album

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	
	L();
	NSURL *url = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
	UIImage *originalImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	UIImage *image = ISEMPTY(originalImage)?editedImage:originalImage;
	
	NSLog(@"url:%@,image:%@,size:%@, scale # %f",url,image,NSStringFromCGSize(image.size),image.scale);
	
    if (photoSource == RPSCover) { // add image to cover
		
		// 如果是mask，那么cover add widget
		if (card.coverMaskFlag) {
			
			CGSize newSize;
			if (image.size.width>image.size.height) {
				newSize = containerSize;
			}
			else{
				newSize = CGSizeMake(containerSize.width, (containerSize.width*image.size.height)/image.size.width);

			}
			
			// 有mask就不要scale 图片了
			image = [image imageByScalingAndCroppingForSize:newSize];
			
			
	
			PictureWithFrameView *v = [[PictureWithFrameView alloc]initWithCoverMaskImage:image url:url];
			
			//删除以前的photo，用现在的这个
			[coverVC applyMaskPhoto:v];
			
			if (![[NSUserDefaults standardUserDefaults]boolForKey:kUnableTipAlertKey]) {
				[self performSelector:@selector(showTipAlert) withObject:nil afterDelay:1];
				
			}
			
			
		}
		else{ // 如果没有mask的话，scale照片到containerSize
			image = [image imageByScalingAndCroppingForSize:containerSize];
			
			card.coverBgUrl = url;
			
			[coverVC changeBG:image];
		}
		
		card.changed = YES;
    }
    else if(photoSource == RPSProfile){  // add image to profile view
        // select img to profile image
		
        UIImage *scaledImg = [image imageByScalingAndCroppingForSize:CGSizeMake(128.0f, 128.0f)];
        [contentVC setProfile:scaledImg];
        
		[Controller saveProfilePhoto:scaledImg];
    }
    else if(photoSource == RPSContent){  // add one picture to contentVC
		
		// init 内部会重新crop image
		PictureWithFrameView *v = [[PictureWithFrameView alloc] initWithImage:image];
		v.url = url;
		
		[v setFrameEnabled:card.setting.frameEnable];
		[v setFrameColor:card.setting.frameColor];
		[v setShadowEnabled:card.setting.shadowEnable];
		
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NotifiAddPicture object:[NSArray arrayWithObject:v]];
		
	}
	[self willDismissPopOverViewController];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self willDismissPopOverViewController];
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
	L();
	
	[[LoadingView sharedLoadingView]addTitle:LString(@"SavePNGAlertTitle") inView:self.view];
}

#pragma mark - AlertView
/// cancel: 0
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

	NSLog(@"button:%d",buttonIndex);
	
	
	if (alertView == coverTipAlert) {
		if (buttonIndex == 0) { // don't show
			[[NSUserDefaults standardUserDefaults]setBool:YES forKey:kUnableTipAlertKey];
		}
	}
	else if(alertView == updateAlert){
		if (buttonIndex == 1) { // goto app seite
			[[UIApplication sharedApplication]openURL:[NSURL urlWithAppID:kAppID]];
		}
	}
	else{
		
		switch (popOverStatus) {
			case RootVCStatusNewCardAlert:
				if (buttonIndex == 1) { //create
					
					[coverVC newCardVC];
					[contentVC newCardVC];
					
					[self toCoverflow];
				}
				break;
			case RootVCStatusRateAlert:
				if (buttonIndex == 0) { // never
					[[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"rate"];
				}
				else if(buttonIndex == 1){ // rate now
					
					[[ExportController sharedInstance] toRate];
					[[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"rate"];
					
				}
				else if(buttonIndex == 2){ // rate later
					[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"rate"];
				}
				
				[[NSUserDefaults standardUserDefaults] synchronize];
				int rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"rate"];
				NSLog(@"rate:%d",rate);
				
				break;
			default:
				break;
		}
		
		popOverStatus = PS_None;
	}
	
}

#pragma mark - Actionsheet

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	
    DLog(@"index:%d",buttonIndex);
	
	
	if (actionSheet == actionActionSheet) {
		
		//if buttonIndex == -2, the status needn't change.just for pinpang
		if (buttonIndex== -2) {
			return;
		}
		
		popOverStatus = PS_None;
		
		
		if(buttonIndex == -1){ // click elsewhere to dismiss this actionsheet
			return;
		}
		
		// if not send later, show loading in the background
		if (buttonIndex!= 1) {
			[[LoadingView sharedLoadingView] performSelectorInBackground:@selector(addInView:) withObject:self.view];
		}
		
		
		
		// 这里可以放在点击的时候生成，节省时间。
		UIImage *img = [self getEmailImage:card.setting.coverEnable inside:card.setting.insideEnable];
		NSString *shareTo = @"Unknown";
		
		if (buttonIndex == 0) {  // email
			NSData *contentData = UIImageJPEGRepresentation(img ,0.8);
			NSString *emailText1 = NSLocalizedString(@"emailText1", nil);
			NSString *emailText2 = NSLocalizedString(@"emailText2", nil);
			
			NSString *emailBody = [NSString stringWithFormat:@"%@<a href=\"%@\">My eCard</a>%@",emailText1,kApplink,emailText2];
			
			
			NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:emailBody,@"emailBody",
								  [NSArray arrayWithObjects:contentData,@"image/jpeg",@"eCard.jpg", nil], @"attachment",nil];
			
			[[ExportController sharedInstance] sendEmail:info];
			
			shareTo = @"email";
		}
		else if(buttonIndex == 1) { //send later

			[self openDateVC];
			
			
		
		}
		else if(buttonIndex == 2) {  //save
			[[ExportController sharedInstance]saveImageInAlbum:img];
			
			shareTo = @"Save ";
		}
		else if(buttonIndex == 3) { //facebook
			
			
			[[FBViewController sharedInstance] sendImage:img delegate:self];
			
			shareTo = @"Facebook";
			
		}
		else if(buttonIndex == 4) { //twitter

			[[ExportController sharedInstance]sendTweetWithText:nil image:img];
			
			shareTo = @"Twitter";
		}
		
		NSString *coverName = card.coverImgName;
		if (ISEMPTY(coverName)) {
			coverName = @"Unknown";
		}
	
		NSLog(@"coverName # %@",coverName);
		
		NSDictionary *dict = @{
		
		@"ShareTo": shareTo,
		@"CoverName":coverName,
		};
		
		
		[Flurry logEvent:@"Share Card" withParameters:dict];
		
	}
	else if(actionSheet == cameraSheet){
		//0: camera, 1: photo, -1 dissmiss
	}
	
}


#pragma mark - Notification


- (void)handleNotificationOpenTextViewController: (NSNotification*)notification{
	L();
	NSArray *object = [notification object];
	
	if (ISEMPTY(object)) {
		return;
	}
	
	UIView *piece = object[0];
	
	if ([piece isKindOfClass:[CardEditView class]]) {


		//convert TextLabel->TextWidget
		[self popText:[[TextWidget alloc]initWithTextLabel:piece]];
	}
	else if([ piece isKindOfClass:[TextWidget class]]){
		[self popText:piece];
	}
	
}


- (void)handleNotificationResignActive: (NSNotification*)notification{
	L();

	
	[self saveCard];
	[[Controller sharedController]save];
	

}

- (void)handleDidBecomeActive:(NSNotification*)notification{
	L();
	
	///send request
	
	[self checkUpdate];
	
}



- (IBAction)popText:(TextWidget*)widget{
	
	L();
	
	if (!widget) {
		return;
	}
	
	
	self.textLabelVC.textWidget = widget;
	

	[self popViewController:self.textLabelVC withStatus:PS_TextLabel sender:nil];
}

#pragma mark - PopOverVC

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
	//	[popoverController.contentViewController release];
	L();
	UIViewController *vc = [[UIViewController alloc] init];
	popoverController.contentViewController = vc;
	
	textLabelVC.mode = 0;
	textLabelVC.text = @"";
	
	if (card.setting.coverEnable + card.setting.insideEnable == 0) {
		card.setting.coverEnable = YES;
		card.setting.insideEnable = YES;
	}
	
	popOverStatus = PS_None;
}


- (void)popViewController:(UIViewController*)vc withStatus:(PopOverStatus)_status sender:(id)sender{
	
	
	if (popOverStatus == _status) {
		popOverStatus = PS_None;
		return;
		
	}
	
	popOverStatus = _status;
	
	UIViewController *nav;
	CGFloat popHeight;
	CGFloat popWidth;
	if (![vc isKindOfClass:[UINavigationController class]]) {
		nav = [[UINavigationController alloc] initWithRootViewController:vc];
		popHeight = vc.view.frame.size.height + 44;
		popWidth  = vc.view.frame.size.width;
	}
	else { // 如果是imagepicker，默认是320x500
		nav = vc;
		popHeight = 500;
		popWidth = 320;
	}


	if (isPad) {

		popVC.contentViewController = nav;
		popVC.popoverContentSize = CGSizeMake(popWidth , popHeight);	


		if (sender) {
			[popVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		}
		else {

			CGSize size = self.view.bounds.size;

			[popVC presentPopoverFromRect:CGRectMake(size.width/2, 400, 20, 20) inView:self.view permittedArrowDirections:0 animated:YES];
		}
						
	}
	else{
		
		[self presentModalViewController:nav animated:YES];
	}


	
}

//should evaluate, if set popoverStatus to None
- (void)willDismissPopOverViewController{

	// dismiss actionsheet
	
	if (actionActionSheet.visible) {
		[actionActionSheet dismissWithClickedButtonIndex:-2 animated:NO];
	}
	
	// dismiss popVC
	if (isPad) {
		[popVC dismissPopoverAnimated:NO];

	}
	else{

		[self dismissModalViewControllerAnimated:YES];
	}
	
	// set menu unvisiable
	
	[[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];

	popOverStatus = PS_None;

}


#pragma mark - Cover 



- (void)openCoverBGPhoto{
	
	photoSource = RPSCover;
	[self popViewController:imgPicker withStatus:PS_OneImage sender:coverPhotoBB];

}


#pragma mark - DateVC
- (void)addDate:(NSDate*)date{
	L();

	NSString *remindme = LString(@"remindTitle");
	NSString *dateStr = [Controller dateFormatWithDate:date];
	[[LoadingView sharedLoadingView]addTitle:[NSString stringWithFormat:@"%@: %@",remindme,dateStr] inView:self.view];

	
	// get datum from date, set: 8:00
	
	NSCalendar *gregorian = [[NSCalendar alloc]
							 
							 initWithCalendarIdentifier:NSGregorianCalendar];
	
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
	
	
	NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];

	[comps setHour:8];
	
	[comps setMinute:0];
		
	NSDate *enddate = [gregorian dateFromComponents:comps];

//	just for test, show notification in 10 seconds
//		enddate = [NSDate dateWithTimeIntervalSinceNow:20];
	
	UILocalNotification *localNotif = [[UILocalNotification alloc] init];
	
	localNotif.fireDate = enddate;

    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	localNotif.alertBody = @"notify body";
	
	localNotif.alertAction = NSLocalizedString(@"Send", nil);
    localNotif.soundName = UILocalNotificationDefaultSoundName;
	
    localNotif.applicationIconBadgeNumber = 1;
	
	NSDictionary *infoDict = [NSDictionary dictionaryWithObject:card.cardName forKey:@"cardkey"];
	
	
    localNotif.userInfo = infoDict;

	card.notification = localNotif;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];

}

- (void)handleRemindNotification:(UILocalNotification*)notification{
	L();
	
	
	NSString *cardName = [notification.userInfo objectForKey:@"cardkey"];
	
	// custom method
	
	NSLog(@"show item:%@",cardName);
	
	Card *c = [[Controller sharedController]cardWithName:cardName];
	
	if (c) {
		self.card = c;
//		[Controller sharedController].card = c;
		card.notification = nil;
	}

}
#pragma mark - Intern


- (void)pickProfile{
    L();
    [self willDismissPopOverViewController];
    
	
	self.photoSource = RPSProfile;
	
    
	if (isPad) {
		popVC.contentViewController = imgPicker;
		popVC.popoverContentSize = CGSizeMake(PopPhotoWidth, PopPhotoHeight);
		
		[popVC presentPopoverFromRect:CGRectMake(800, 50, 165, 165) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		
	}
	else{
		[self presentModalViewController:imgPicker animated:YES];
	}
}



- (UIImage*)getEmailImage:(BOOL)coverEnabled inside:(BOOL)insideEnabled{
	L();
	UIImage *img;
	int faktor = kUniversalFaktor;
	
	// before screenshot, 图片不应该是圆角的

	
	if (coverEnabled&&!insideEnabled) { //only cover

		img = [UIImage imageWithView:coverVC.view faktor:faktor];
	}
	else if(!coverEnabled && insideEnabled){ // only inside
//		img = [self getContentImage];
		img = [UIImage imageWithView:contentVC.view faktor:faktor];
	}
	else { // cover +inside

		CGSize newSize = CGSizeMake(960,1280);
		
		UIGraphicsBeginImageContext(newSize);
		CGContextRef imageContext = UIGraphicsGetCurrentContext();
		CGContextScaleCTM(imageContext, faktor, faktor);
		[coverVC.view.layer renderInContext: imageContext];
		
		// 如果是ipad，把坐标原点换到0，640
		// 如果是iphone， 坐标换到0，320. 因为scale是x2的，所以坐标都要÷faktor
		CGContextTranslateCTM(imageContext, 0.0, 640.0/faktor);
		[contentVC.view.layer renderInContext:imageContext];

		img= UIGraphicsGetImageFromCurrentImageContext();
		
		UIGraphicsEndImageContext();
		
		
	}
	
	//after screenshot, make it

	return img;

}

// return ipad: 240x320 
- (UIImage*)getPreviewImage{
	
	UIImage *img;

	float deviceFaktor = kUniversalFaktor; // pad:1 ; iphone:2
	
	// image size: 480x480
	CGFloat width = 480;
	CGSize newSize = CGSizeMake(width,width);
	
	// ipad:0.375, 480->1280 iphone: 0.7 :480->640 
	// 
	CGFloat faktor = deviceFaktor*width/1280;

	
	UIGraphicsBeginImageContext(newSize);
	CGContextRef imageContext = UIGraphicsGetCurrentContext();
	
	CGContextTranslateCTM(imageContext, 60, 0);
	CGContextScaleCTM(imageContext, faktor, faktor);
	[coverVC.view.layer renderInContext: imageContext];
	
	// 如果是ipad，把坐标原点换到0，640
	
	CGContextTranslateCTM(imageContext, 0, 640.0/deviceFaktor);
	[contentVC.view.layer renderInContext:imageContext];
	
	img= UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return img;
}


- (void)setTBItems:(RootMode)mode{

	if (mode == RootModeChoose) { //choose cover

		toolbar.hidden = YES;
	}
	else if(mode == RootModeCover){ //cover
		toolbar.hidden = NO;
		toolbar.items = coverItems;
	}
	else if(mode == RootModeContent){
		toolbar.hidden = NO;
		toolbar.items = contentItems;
	}
	
    [[Controller sharedController]setRootMode:mode];
}



// called from MailDelegate, waiting AlertDelegate to handle it
- (void)showRateAlert{
	
	SpriteManager *sprite = [SpriteManager sharedInstance];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:sprite.rateTitle message:sprite.rateMsg delegate:self 
											  cancelButtonTitle:LString(@"rateno") otherButtonTitles:LString(@"ratenow"),LString(@"ratelater"),nil];
	[alertView show];
	popOverStatus = RootVCStatusRateAlert;

	
}

// 1. resign active
// 2. toCards
- (void)saveCard{
	
	NSArray *contentSubViews = [contentVC valueForKeyPath:@"controllView.subviews"];
	
	UIImage *preview = [self getPreviewImage];
	
	NSArray *coverMaskPhotos = [coverVC valueForKeyPath:@"_maskControlView.subviews"];
	
	NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:contentSubViews,@"contentSubviews",
						  coverVC.controllView.subviews,@"coverSubviews", 
						  preview,@"preview",
						  coverMaskPhotos,@"coverMaskPhotos",
						  nil];
	
	
	[card saveWithInformation:info];
}


- (void)showTipAlert{
	
	
		if (!coverTipAlert) {
			
			
			coverTipAlert = [[UIAlertView alloc]initWithTitle:LString(@"Tip") message:LString(@"Long press the photo to lock/unlock, and then add texts") delegate:self cancelButtonTitle:LString(@"Don't show again") otherButtonTitles:@"OK", nil];
			
		}
		  
		[coverTipAlert show];
		
	
	
	
}
#pragma mark - IAP


- (void)IAPDidFinished:(NSString*)identifier{
	
	//ads
	L();
	
	[[SpriteManager sharedInstance]setupCoverImgNames];
	[coverFlowVC setup];
	
	[self initBanner];

	
}
- (void)IAPDidRestored{
	[[SpriteManager sharedInstance]setupCoverImgNames];
	[coverFlowVC setup];
	[self initBanner];
	
	self.card = [[Controller sharedController]firstCard];
	
}


#pragma mark -  ADBanner


- (void)initBanner{
	
	if (isPaid() || isIAPFullVersion) {
		[_adContainer removeFromSuperview];
		_adContainer.delegate = nil;
		_adContainer = nil;
	}
	else{
	
		_adContainer = [[AdView alloc]initWithFrame:CGRectMake(0, h, w, _hAdBanner)];
		_adContainer.delegate = self;
		
		
		RootMode mode = [[Controller sharedController]rootMode];
		if (instrumentVC.view.superview) {
			[self.view insertSubview:_adContainer belowSubview:instrumentVC.view];
		}
	    else if((mode == RootModeCover || mode == RootModeContent) && isPhone){ // iphone
			
		}
		else{
			[self.view addSubview:_adContainer];
		}

	}
	
}

- (void)layoutBanner:(BOOL)loaded{
	
	[UIView animateWithDuration:0.25 animations:^{
		
		if (loaded) { // 从不显示到显示banner
			container.frame = containerWithBannerRect;
			toolbar.frame = toolbarWithBannerRect;
			_adContainer.frame = bannerRect;
		}
		else{
			container.frame = containerRect;
			toolbar.frame = toolbarRect;
			_adContainer.frame = bannerOutRect;
		}
		
    }];

}


#pragma mark - UpdateAlert
- (void)checkUpdate{
	updateRequest = [NetworkManager requestUpdateMsg:self];
}

#pragma mark - Request


- (void)requestFinished:(ASIHTTPRequest *)request
{

	
	if (request == updateRequest) {
		NSString *response = [request responseString];

		NSLog(@"request finished # %@",response);

		
///  通过ios5之后的原生JSON处理机制进行处理
//		NSData *responseData = [request responseData];
//    id responseObj = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
		
	
		/// 如果JSON解析不成功，错误处理
		if (!([[response JSONValue] isKindOfClass:[NSArray class]] || [[response JSONValue] isKindOfClass:[NSDictionary class]])) {
			return;
		}
		
		NSDictionary* responseObj = [response JSONValue];
		
		NSLog(@"responseDict #%@, # %@",NSStringFromClass([responseObj class]),responseObj);

		float updateVersion = [responseObj[@"version"] floatValue];
		NSLog(@"thisversion # %f, updateversion # %f",thisVersion,updateVersion);
	
		
		if (updateVersion > thisVersion) {
			updateAlert =   [[UIAlertView alloc] initWithTitle:@"Update available"
															message:@"An update is available. Would you like to update now?"
														   delegate:self
												  cancelButtonTitle:@"Cancel"
												  otherButtonTitles:@"Update",nil];
			[updateAlert show];
			

		}
	}
	
	

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
	NSLog(@"request error # %@",[error localizedDescription]);
}


#pragma mark -

- (void)test{

//	[self testUpdateAlert];
//	[self testLocalHost];
	
//	[self performSelector:@selector(toCover:) withObject:(id) 1 afterDelay:3];
//	[self perfor]

//	[UIDevice instanceMethodSignatureForSelector:nil];
}

- (void)testUpdateAlert{
	[NetworkManager requestUpdateMsg:self];

}

- (void)testLocalHost{
	NSString *str=[@"http://localhost/xappsoft/testMoreApp.php" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [NSURL URLWithString :str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	
	[request startAsynchronous];
	
	NSLog(@"test request id # %@",request.requestID);
}
@end
