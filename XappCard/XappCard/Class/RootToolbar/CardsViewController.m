//
//  CardsViewController.m
//  MyeCard
//
//  Created by  on 27.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardsViewController.h"
#import "DateViewController.h"
#import "AdView.h"
@interface CardsViewController ()

@end

@implementation CardsViewController

@synthesize rootVC,selectedIndex;

- (void)loadView{
	
	
	CGRect rect = CGRectMake(0, 0, 480, 320);
	CGRect containerRect = CGRectMake(0, 0, 480, 320);
	if (isPad) {
		rect = CGRectMake(0, 0, 1024, 768);
		containerRect = CGRectMake(0, 0, 1024, 768);
	}
	else if(!isPhone4){
		rect = CGRectMake(0, 0, 568, 320);
		containerRect = CGRectMake(44, 0, 480, 320);
	}
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.backgroundColor = [UIColor blackColor];

	UIView *container = [[UIView alloc]initWithFrame:containerRect];
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:container.bounds];
	
    coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
    
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
		coverflow.coverSpacing = 200;
		
		coverflow.coverSize = isPad?CGSizeMake(480, 480):CGSizeMake(240, 240);
	}
	
	calendarL = [[UILabel alloc]initWithFrame:isPad?CGRectMake(335, 60, 360, 30):CGRectMake(0, 0, 480, 30)];
	calendarL.textAlignment = UITextAlignmentCenter;
	calendarL.backgroundColor = [UIColor clearColor];
	calendarL.textColor = [UIColor whiteColor];
	
	[container addSubview:coverflow];
	[container addSubview:calendarL];
	[self.view addSubview:container];



//	[self setup];
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	dateVC = [[DateViewController alloc]init];
	dateVC.cardsVC = self;
	[dateVC setLinkBarButtonTitle:LString(@"Remove")];
	
	dateVC.rootVC = rootVC;	
	nav = [[UINavigationController alloc]initWithRootViewController:dateVC];
	
	if (isPad) {
		popVC = [[UIPopoverController alloc]initWithContentViewController:nav];
	}

	
	deleteAlert = [[UIAlertView alloc]initWithTitle:LString(@"DeleteTitle") message:nil delegate:self cancelButtonTitle:LString(@"No") otherButtonTitles:LString(@"Yes"), nil];
	
	}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];

    [self layoutADBanner:[AdView sharedInstance]];

}

- (void)viewWillAppear:(BOOL)animated{
	L();
	[super viewWillAppear:animated];

	[self setup];

}



- (void)setup{
	
	cards = [Controller sharedController].cards;
//	NSLog(@"cards:%@",cards);
	int numberOfCovers = [cards count]+1;
	
	// !!!这里会调用 coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index，
	//所以如果cardIndex和selectedIndex是一个的话, selectedIndex会被清0
	[coverflow setNumberOfCovers:numberOfCovers];

	[coverflow bringCoverAtIndexToFront:selectedIndex animated:NO];
	

}

- (void)setSelectedIndex:(int)_cardIndex{
	
	selectedIndex = _cardIndex;

	[self setup];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notification

- (void)registerNotifications
{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAdviewNotification:) name:NotificationAdChanged object:nil];
    
}

- (void)handleAdviewNotification:(NSNotification*)notification{
    [self layoutADBanner:notification.object];
    
}



#pragma mark -  ADView


- (void)layoutADBanner:(AdView *)banner{
    
    L();
    [UIView animateWithDuration:0.25 animations:^{
		
		if (banner.isAdDisplaying) { // 从不显示到显示banner
            
			[banner setOrigin:CGPointMake(0, _h - banner.height)];
			
			[[[MERootViewController sharedInstance] view] addSubview:banner];
		}
		else{
			[banner setOrigin:CGPointMake(0, _h)];
            
		}
		
    }];
    
}



#pragma mark - CoverFlow

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
	//	NSLog(@"Front %d",index);



//	NSLog(@"index:%d,numberOFCover:%d",index,coverflowView.numberOfCovers);
	
	//这个是不可以的！！！
//	selectedIndex = index;
	
	if (index == 0||index == coverflowView.numberOfCovers-1) {
		CardCover *cover = (CardCover*)[coverflow coverAtIndex:index];
		cover.deleteB.hidden = YES;
	}
	else {
		CardCover *cover = (CardCover*)[coverflow coverAtIndex:index];
		cover.deleteB.hidden = NO;
	}

	if (index<[cards count]) {
		Card *card = [cards objectAtIndex:index];
		
		if (card.notification) {

			NSString *dateStr = [Controller dateFormatWithDate:card.notification.fireDate];
			calendarL.text = [NSString stringWithFormat:@"%@: %@",LString(@"remindTitle"),dateStr];
	
		}
		else {
			calendarL.text = @"";
		}

	}
	else { // add view
		calendarL.text = @"";
	}


}

- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	//    L();
	CardCover *cover = (CardCover*)[coverflowView dequeueReusableCoverView];
	UIImageView* lockView;
	if(cover == nil){
		
		CGRect rect = CGRectMake(0, 0, 480, 480);
		CGFloat lockWidth = isPad?60:30;
		cover = [[CardCover alloc]initWithFrame:rect];
		if (isPhone) {
			[cover setSize:CGSizeMake(240, 240)];
		}

		cover.delegate = self;


		CGSize coverSize = cover.bounds.size;
		
		lockView= [[UIImageView alloc]initWithFrame:CGRectMake(coverSize.width/2+lockWidth/10, coverSize.height/2-1.2*lockWidth, lockWidth, lockWidth)];

		lockView.image = [UIImage imageNamed:@"icon_lock.png"];
		lockView.tag = kTagCardsLock;
		lockView.hidden = YES;
		[cover addSubview:lockView]; //lock for "+"

	}
	else {
		lockView = (UIImageView*)[cover viewWithTag:kTagCardsLock];
	}

	UIImage *img;
	if (index < [cards count]) { // cards
		
		img = [[cards objectAtIndex:index] previewImg];
		
		NSLog(@"cards preview # %@",NSStringFromClass([img class]));
		
		Card *card = [cards objectAtIndex:index];
		
		if (card.notification) {

			cover.calendarB.hidden = NO;
		}
		else {
			cover.calendarB.hidden = YES;
		}

	}
	else { // letzte new card image
		img = [UIImage imageNamed:@"AddCard.png"];
		
		// new card image 也有delete？
		
//		NSLog(@"add card # %@",NSStringFromClass([img class]));
		
		cover.deleteB.hidden = YES;
		
		if (!isPaid()&&!isIAPFullVersion) {
			lockView.hidden = NO;

		}
		else {
			lockView.hidden = YES;

		}
		
	}
	
	cover.image = img;
	
	
	return cover;
	
}

- (void) coverflowView:(TKCoverflowView *)coverflowView coverAtIndexWasTapped:(int)index{
    L();

	AppVersion version = [[Controller sharedController]appversion];


	// to card
	if (version == AppVersionPaid || isIAPFullVersion ||index == 0) {
		if (index == [cards count]) {
			// add new card
			[self newCard];
		}
		else {
			[self selectCard:index];
			
		}
	}
	else if(version == AppVersionIAP){

		
		[[MyStoreObserver sharedInstance]showFullVersionAlert];
	}
    
}

#pragma mark - UIALertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	NSLog(@"button:%d",buttonIndex);
	if (alertView == deleteAlert ) {
		if (buttonIndex == 1) { //delete card
			
			[self deleteCard:cardIndex];
		}
	}

}


#pragma mark - Cover Delegate
- (void)cover:(TKCoverflowCoverView *)view buttonClicked:(int)tag{
	L();

	for (int i = 0; i<[coverflow numberOfCovers]; i++) {
		CardCover *cover = (CardCover*)[coverflow coverAtIndex:i];
		if (cover == view) {
			cardIndex = i;
			break;
		}
	}
	[coverflow bringCoverAtIndexToFront:cardIndex animated:YES];
	
	if (tag == kTagCoverDeleteCard) { // delete the card

		[deleteAlert show];
	}
	else if(tag == kTagCoverCalendar) { // show the remind time
		
		Card *c = [cards objectAtIndex:cardIndex];
		dateVC.date = c.notification.fireDate;

		if (isPad) {
						
			CGSize size = self.view.bounds.size;
		
			
//			NSLog(@"dataVC.size:%@,popSize:%@",NSStringFromCGSize(dateVC.view.frame.size),NSStringFromCGSize(popVC.popoverContentSize));
			[popVC presentPopoverFromRect:CGRectMake(size.width/2, 400, 20, 20) inView:self.view permittedArrowDirections:0 animated:YES];
			
			
		}
		else {
			[rootVC presentModalViewController:nav animated:YES];

		}
	}
	
}

#pragma mark - Card Control
- (void)deleteCard:(int)_cardIndex{
	// delete card
	[[Controller sharedController]deleteCard:[cards objectAtIndex:_cardIndex]];
	
	//coverflow setup
	
	[self setup];
	
}
- (void)newCard{

	L();
		//load new card
	rootVC.card = [[Controller sharedController] newCard];

	//remove self
	[rootVC toCoverflow];
	
	[self.view removeFromSuperview];
}
- (void)selectCard:(int)_cardIndex{
	
	// load card at index
	
//	NSLog(@"cards:%@",cards);
	
	rootVC.card = [cards objectAtIndex:_cardIndex];

	
	// remove self
	[self.view removeFromSuperview];
}

#pragma mark - DateVC
- (void)dismissDateVC:(BOOL)successful{
	L();
	Card *c = [cards objectAtIndex:cardIndex];
	
//	NSLog(@"cardIndex:%d,selectedIndex:%d",cardIndex,selectedIndex);
	if (!successful) {
		// cancel notification
		
		[[Controller sharedController]cancelNotificationWithCard:c];
		
		// hide the calendarL and symbol
		calendarL.text = @"";
		CardCover *cover = (CardCover*)[coverflow coverAtIndex:cardIndex];
		cover.calendarB.hidden = YES;
	}
	else {
		NSString *dateStr = [Controller dateFormatWithDate:c.notification.fireDate];
		calendarL.text = [NSString stringWithFormat:@"%@: %@",LString(@"remindTitle"),dateStr];
	}
	
	if (isPad) {
		[popVC dismissPopoverAnimated:YES];
	}
	else {
		[nav dismissModalViewControllerAnimated:YES];
	}
}

#pragma mark - IAP
//- (void)didCompleteIAPWithIdentifier:(NSString*)identifier{
//	L();
//
//	[[NSUserDefaults standardUserDefaults]setBool:YES forKey:identifier];
//	
//	[[NSUserDefaults standardUserDefaults]synchronize];
//	
//	if ([identifier isEqualToString:kIAPFullVersion]) { // buy, restore
//		[self newCard];
//	}
//	else if([identifier isEqualToString:kIAPHalloween]){// restore
//		[rootVC enableIAPCoverpackage];
//	}
//
//
//}

- (UIView*)viewForLoading{
	return self.view;
}
@end
