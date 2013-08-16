//
//  ContentViewController.m
//  XappCard
//
//  Created by  on 30.11.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "ContentViewController.h"
#import "PortfolioView.h"
#import "PictureWithFrameView.h"
#import "EditableDelegate.h"
#import "CardTextView.h"
#import "ArchivedImageView.h"
#import "CodingText.h"
#import "TextWidget.h"


@implementation ContentViewController

@synthesize portfolioView, step2IV, step3IV;



- (int)picNum{
	int picNum=0;
	NSArray *array = controllView.subviews;
	
	for (UIView *v in array) {
		if ([v isKindOfClass:[PictureWithFrameView class]]) {
			picNum++;
		}
	}
	
	return picNum;
}
#pragma mark - View lifecycle


- (void)loadView{


	[super loadView];
	
	step2IV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 195, 375, 50)];
	step2IV.autoresizingMask = AUTORESIZINGMASK;
	step3IV = [[UIImageView alloc] initWithFrame:CGRectMake(530, 195, 375, 50)];
	step3IV.autoresizingMask = AUTORESIZINGMASK;
	


	step2IV.image = [[SpriteManager sharedInstance] stepImageWithIndex:2];
	step3IV.image = [[SpriteManager sharedInstance] stepImageWithIndex:3];
	
	portfolioView = [[PortfolioView alloc] initWithFrame:isPad?CGRectMake(780, 20, 160, 160):CGRectMake(400, 10, 70, 70)];


	[self.view addSubview:step2IV];
	[self.view addSubview:step3IV];
	[self.view addSubview:portfolioView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotificationAddPicture:)
												 name:NotifiAddPicture object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotificationAddZettel:)
												 name:NotifiContentAddZettel object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotificationLoadEditView:)
												 name:NotifiContentLoadEditView object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleProfileEnable:)
												 name:NotifiPictureSetProfileEnabled object:nil];

	
	[self setup];
	
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    L();
    // Release any cached data, images, etc that aren't in use.

}


- (void)dealloc{
	L();
	[[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)setup{

	
	NSArray *array = controllView.subviews;
	
	for (UIView *v in array) {
		if ([v isKindOfClass:[CardEditView class]] ||[v isKindOfClass:[TextWidget class]]) {
			[v removeFromSuperview];
		}
	}
	
	if (!ISEMPTY(card.contentBGURL)) {
		[self loadBG:card.contentBGURL];
	}
	else{
		
//		[self changeBG:[[SpriteManager sharedInstance] cardBGImageWithIndex:0]];
		[self changeBG:[UIImage imageNamed:@"contentBG.jpg"]];
	}
	
	
	[self loadElements:card.elements];
	
	[self setProfileEnable:card.setting.profileEnable];
}

#pragma mark - Gesture

- (void)handleLongPress:(UIGestureRecognizer*)gesture{
	L();

	 if (gesture.state == UIGestureRecognizerStateBegan && card.contentBGURL!=nil) {
		UIMenuController *menuController = [UIMenuController sharedMenuController];
		UIMenuItem *bgMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Default Background", nil) action:@selector(changeDefaultBG)];
		
		CGPoint location = [gesture locationInView:[gesture view]];
		
		[menuController setMenuItems:[NSArray arrayWithObjects:bgMenuItem,nil]];
		[menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gesture view]];
		[menuController setMenuVisible:YES animated:YES];

	
	 }
}

#pragma mark - Notification
- (void)handleNotificationAddPicture: (NSNotification*)notification{
	L();
	NSArray *imgs = [notification object];
	
	for (UIView *imgV in imgs) {

		if (!isPad) {
			imgV.transform = CGAffineTransformScale(TRANSFORM(arc4random()%360), 0.5, 0.5);
		}
		else{
			imgV.transform = CGAffineTransformScale(TRANSFORM(arc4random()%360), 1, 1);
		}

		
		[self addElement:imgV center:isPad?CGPointMake(250, 350):CGPointMake(120, 140) style:0];
	}

	
}


- (void)handleNotificationAddZettel: (NSNotification*)notification{
	L();
	NSArray *zettels = [notification object];

	// add pictureVs to rightTextV;
	for (int i = 0; i<[zettels count]; i++) {
   
		UIView *v = zettels[i];
		if ([v isKindOfClass:[CodingText class]]) {
//			NSLog(@"add CodingText ");
			v = [(CodingText*)v decodedObject];
			
			[controllView addGestureRecognizersToPiece:v];
			[controllView addSubview:v];
		}
		else if ([v isKindOfClass:[TextWidget class]]) {
			if (![self containElement:v]) {
				[controllView addGestureRecognizersToPiece:v];
				[controllView addSubview:v];
				
			}
			
		}
		else{ // 如果是deprecated的CardEditView
			[controllView addGestureRecognizersToPiece:v];
			[controllView addSubview:v];
		}

	}

	
	
	
}



- (void)handleNotificationLoadEditView: (NSNotification*)notification{
//	L();
	NSArray *imgs = [notification object];
		
	// add pictureVs to rightTextV;
	for (int i = 0; i<[imgs count]; i++) {
        
        UIView *v = [imgs objectAtIndex:i];
		
		if ([v isKindOfClass:[CodingText class]]) {
//			NSLog(@"add CodingText ");
			v = [(CodingText*)v decodedObject];
		}
		
		[controllView addGestureRecognizersToPiece:v];
		[controllView addSubview:v];
    }
	
	step3IV.hidden = YES;
	step2IV.hidden = YES;
}

- (void)handleProfileEnable:(NSNotification*)notification{
	L();
	BOOL enabled = [[notification object] boolValue];
	
	[self setProfileEnable:enabled];
}
#pragma mark - AlbumLoader

- (void)didLoadAsset:(ALAsset *)asset withKey:(NSString *)key{
	L();
	
	ALAssetRepresentation *rep = [asset defaultRepresentation];

	NSURL *url = rep.url;
	
	if ([key isEqualToString:@"contentElements"]) {

		CGImageRef iref = [rep fullScreenImage];
		
		UIImage *largeimage = [UIImage imageWithCGImage:iref];

		
		for (PictureWithFrameView *v in picArr) {
			
			if ([v.url isEqual:url]) {
				CGSize newSize = [UIView sizeForImage:largeimage withMinSide:320];
				
				largeimage = [largeimage imageByScalingAndCroppingForSize:CGSizeMake(newSize.width, newSize.height)];
				
				[v setImage:largeimage];
			}
		}

		
	}
	else if([key isEqualToString:@"loadBG"]){
		CGImageRef iref = [rep fullScreenImage];
		
		UIImage *largeimage = [UIImage imageWithCGImage:iref];
//		CGFloat width = 960;
//		CGFloat height = 640;

		largeimage = [largeimage imageByScalingAndCroppingForSize:CGSizeMake(w, h)];
		
//		NSLog(@"bgImage:%@",NSStringFromCGSize(largeimage.size));
		[self changeBG:largeimage];
		card.contentBGURL = url;
		
	}
}

#pragma mark - GestureController
- (void)willPanPiece:(UIPanGestureRecognizer *)gestureRecognizer inView:(MyView *)myView{
//	L();
	UIView *piece = [gestureRecognizer view];
	
	CGPoint point = [gestureRecognizer locationInView:myView];
	CGRect innenRect = isPad?CGRectMake(10,10,940,620):CGRectMake(5, 5, 470, 310);
	
	
	if (!CGRectContainsPoint(innenRect, point)) {
		[piece removeGestureRecognizer:gestureRecognizer];
		[piece removeFromSuperview];
		return;
	}

}


- (void)handleMenuAction:(MenuAction)menuAction withPiece:(CardEditView *)piece{
	L();
	switch (menuAction) {
		case MA_Lock:
			piece.locked = YES;
			break;
		case MA_Unlock:
			piece.locked = NO;
			break;
		case MA_SetBG:

			[self loadBG:[(PictureWithFrameView*)piece url]];
			break;
			
		case MA_Edit:

			[[NSNotificationCenter defaultCenter]
			 postNotificationName:NotifiRootOpenTextLabelVC object:[NSArray arrayWithObject:piece]];
			break;
		default:
			break;
	}
}

#pragma mark - CardVC

- (void)loadElements:(NSMutableArray*)array{
	
	[super loadElements:array];
	
	AlbumLoader *albumLoader = [[AlbumLoader alloc] init];
	albumLoader.delegate = self;
	picArr = [NSMutableArray array];
	
	NSMutableArray *urls = [NSMutableArray array];
	
	for(int i = 0; i<[array count];i++) {
		
		UIView *v = [array objectAtIndex:i];
		if ([v isKindOfClass:[ArchivedImageView class]]) {
			
			NSURL *url = [(ArchivedImageView*)v url];
			if (ISEMPTY(url)) {
				break;
			}
			PictureWithFrameView *pic = [[PictureWithFrameView alloc] initWithArchivedView:v];
			[picArr addObject:pic];
			[array replaceObjectAtIndex:i withObject:pic];
			if ([urls indexOfObject:url]==NSNotFound) {
				
				[urls addObject:url];
			}
		}
	
	}
	
	[albumLoader loadUrls:urls withKey:@"contentElements"];

	
	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiContentLoadEditView object:array];
}



#pragma mark - Extern

- (void)hideStep:(int)step{
	if (step == 2) {
		self.step2IV.hidden = YES;
	}
	else if(step == 3){
		self.step3IV.hidden = YES;
	}
}



- (void)setProfile:(UIImage*)img{
    L();
	portfolioView.portfolioPhoho.image = img;
}

- (void)setProfileEnable:(BOOL)enabled{
	if (enabled) {
		portfolioView.hidden = NO;
	}
	else{
		portfolioView.hidden = YES;
	}
}
#pragma mark - Intern



- (void)changeDefaultBG{
	

//	bgV.image = [[SpriteManager sharedInstance] cardBGImageWithIndex:0];
	
	bgV.image = [UIImage imageNamed:@"contentBG.jpg"];
	rootVC.card.contentBGURL = nil;
}



- (void)newCardVC{
	[super newCardVC];
	[self changeDefaultBG];
	
	step2IV.hidden = NO;
	step3IV.hidden = NO;
}

@end
