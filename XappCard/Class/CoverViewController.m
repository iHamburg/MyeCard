//
//  CoverViewController.m
//  XappCard
//
//  Created by  on 01.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "CoverViewController.h"
#import "CoverflowViewController.h"
#import "CardEditView.h"
#import "CodingText.h"

#import "ArchivedImageView.h"
#import "CardTextView.h"
#import "TextWidget.h"

@implementation CoverViewController

@synthesize controlMode = _controlMode;

#pragma mark - View lifecycle

- (void)setControlMode:(ControlMode)controlMode{
	_controlMode = controlMode;
	
	if (_controlMode == ControlModeText) { // text
		_maskControlView.userInteractionEnabled = NO;
		controllView.userInteractionEnabled = YES;

	}
	else if(_controlMode == ControlModeMaskPhoto){ // control mask photo
		_maskControlView.userInteractionEnabled = YES;
		controllView.userInteractionEnabled = NO;
	
	}
}

- (void)loadView{

	[super loadView];
	

	_maskControlView = [[MyView alloc]initWithFrame:self.view.bounds];
	_maskControlView.delegate = self;
	[self.view insertSubview:_maskControlView belowSubview:bgV];
	
	
	UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toContent)];
	swipe.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.view addGestureRecognizer:swipe];
	
	swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toContent)];
	swipe.direction = UISwipeGestureRecognizerDirectionUp;
	[self.view addGestureRecognizer:swipe];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleNotificationAddZettel:)
												 name:NotifiCoverAddZettel object:nil];
	
	[self setup];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

   
}

- (void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
}
/**
 
 换新的cover
 */

- (void)setup{
//	L();

	//remove all subview
	[controllView removeAllSubviews];
	[maskPhotoV removeFromSuperview];
	
	if (card.coverBgUrl) {
		[self loadBG:card.coverBgUrl];
	}
	else if(!ISEMPTY(card.coverImgName)){

		bgV.image = [UIImage imageWithContentsOfFileUniversal:card.coverImgName];
	}

	
	if (!ISEMPTY(card.coverMaskPhotos)) {
		for(int i = 0; i<[card.coverMaskPhotos count];i++) {
			
			UIView *v = [card.coverMaskPhotos objectAtIndex:i];
			if ([v isKindOfClass:[ArchivedImageView class]]) {
				
				maskPhotoV = [[PictureWithFrameView alloc] initWithArchivedView:v];
				
				AlbumLoader *albumLoader = [[AlbumLoader alloc] init];
			
				albumLoader.delegate = self;
				[albumLoader loadUrls:@[maskPhotoV.url] withKey:kCoverMaskPhotoKey];
				
				[self applyMaskPhoto:maskPhotoV];
				
			}
						
		}

	}
	
	[self loadElements:card.coverElements];
	
	if (!card.coverBgUrl && ISEMPTY(card.coverImgName)) { // if there's no coverBG, show coverFlowVC

		[rootVC toCoverflow];
	}
	
	
}

#pragma mark - Navigation
- (void)toContent{
	
	[rootVC switchCoverAndContent:nil];
}


#pragma mark - Gesture

- (void)willPanPiece:(UIPanGestureRecognizer *)gestureRecognizer inView:(MyView *)myView{
	
	UIView *piece = [gestureRecognizer view];
	
	// 如果是Picture(maskPhoto)就不删除
	if (![piece isKindOfClass:[PictureWithFrameView class]]) {
		
		CGPoint point = [gestureRecognizer locationInView:myView];
		CGRect innenRect = isPad?CGRectMake(10,10,940,620):CGRectMake(5, 5, 470, 310);
		
		
		if (!CGRectContainsPoint(innenRect, point)) {
			[piece removeGestureRecognizer:gestureRecognizer];
			[piece removeFromSuperview];
			return;
		}
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
		case MA_Edit:
			[[NSNotificationCenter defaultCenter]
			 postNotificationName:NotifiRootOpenTextLabelVC object:[NSArray arrayWithObject:piece]];
			break;
		default:
			break;
	}
}

- (void)handleLongPress:(UIGestureRecognizer*)gesture{

	L();
	//如果不是mask，不用出现menu
	if (!card.coverMaskFlag) {
		return;
	}
	
	if (gesture.state == UIGestureRecognizerStateBegan  && card.coverMaskFlag ) {
		UIMenuController *menuController = [UIMenuController sharedMenuController];
	
		UIMenuItem *bgMenuItem;
		if (_controlMode == ControlModeMaskPhoto) {
			bgMenuItem = [[UIMenuItem alloc] initWithTitle:LString(@"lockCoverPhoto") action:@selector(lockCoverMaskPhoto)];
		}
		else{
			bgMenuItem = [[UIMenuItem alloc] initWithTitle:LString(@"unlockCoverPhoto") action:@selector(unlockCoverMaskPhoto)];
		}
		
		[self becomeFirstResponder];
		
		CGPoint location = [gesture locationInView:[gesture view]];
		
		[menuController setMenuItems:[NSArray arrayWithObjects:bgMenuItem,nil]];

		[menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gesture view]];

			
		[menuController setMenuVisible:YES animated:YES];
		
		
	}

}
//
//
//// UIMenuController requires that we can become first responder or it won't display
- (BOOL)canBecomeFirstResponder
{
	

    return YES;
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{

	
	//     NSLog(@"action:%@",NSStringFromSelector(action));
    if (action == @selector(menuLockPiece:) || action == @selector(menuUnlockPiece:)|| action == @selector(menuEditPiece:) ||
        action == @selector(menuCropPiece:) || action == @selector(lockCoverMaskPhoto)  || action == @selector(unlockCoverMaskPhoto))
		
        return YES;
	
	
    return [super canPerformAction:action withSender:sender];
	
}


#pragma mark - Notification
- (void)handleNotificationAddZettel: (NSNotification*)notification{
	L();
	NSArray *zettels = [notification object];
	
	// add pictureVs to rightTextV;
	for (int i = 0; i<[zettels count]; i++) {
        
        UIView *v = [zettels objectAtIndex:i];
		
		// 如果是CodingText
		if ([v isKindOfClass:[CodingText class]]) {

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


#pragma mark - Load


- (void)loadElements:(NSMutableArray*)array{
	[super loadElements:array];

	
	NSMutableArray *texts = [NSMutableArray array];

	for(int i = 0; i<[array count];i++) {
		
		UIView *v = [array objectAtIndex:i];
		if ([v isKindOfClass:[ArchivedImageView class]]) {
			
			NSURL *url = [(ArchivedImageView*)v url];
			if (ISEMPTY(url)) {
				break;
			}
			
			maskPhotoV = [[PictureWithFrameView alloc] initWithArchivedView:v];
			
			AlbumLoader *albumLoader = [[AlbumLoader alloc] init];
			albumLoader.delegate = self;
			[albumLoader loadUrls:@[maskPhotoV.url] withKey:kCoverMaskPhotoKey];

			[self applyMaskPhoto:maskPhotoV];
			

		}
		else if([v isKindOfClass:[CardEditView class]] ||[v isKindOfClass:[CodingText class]]){
			[texts addObject:v];
		}
		
	}
	
//	NSLog(@"texts # %@",texts);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiCoverAddZettel object:texts];
	
}

#pragma mark - AlbumLoader

- (void)didLoadAsset:(ALAsset *)asset withKey:(NSString *)key{
	ALAssetRepresentation *rep = [asset defaultRepresentation];
	CGImageRef iref = [rep fullScreenImage];
	UIImage *largeimage = [UIImage imageWithCGImage:iref];
	NSURL *url = rep.url;
	if([key isEqualToString:@"loadBG"]){

		largeimage = [largeimage imageByScalingAndCroppingForSize:CGSizeMake(w, h)];
		[self changeBG:largeimage];
		card.coverBgUrl = url;
//		card.coverBGIndex = -1;
	}
	else if([key isEqualToString:kCoverMaskPhotoKey]){

		maskPhotoV.image = largeimage;
	}
	
}

#pragma mark - Mask Widget

- (void)editMaskPhoto{
	L();
	
	self.controlMode = ControlModeMaskPhoto;
}

- (void)lockCoverMaskPhoto{
	self.controlMode = ControlModeText;
}

- (void)unlockCoverMaskPhoto{
	self.controlMode = ControlModeMaskPhoto;
}

// 没有mask
- (void)changeBG:(UIImage*)image{
	[super changeBG:image];
	[maskPhotoV removeFromSuperview];
}

- (void)applyMask:(UIImage*)maskImage{
	L();
	
	bgV.image = maskImage;
	
	self.controlMode = 1;
}

/**
 
 清除原本的photo，加上新的
 */
- (void)applyMaskPhoto:(PictureWithFrameView*)_maskPhotoV{
	[maskPhotoV removeFromSuperview];
	maskPhotoV = _maskPhotoV;
	
	if (maskPhotoV.frame.origin.x == 0 && maskPhotoV.frame.origin.y == 0) {
		maskPhotoV.center = CGPointMake(w/2, h/2);
	}
	
	
	[_maskControlView addGestureRecognizersToMaskPhoto:maskPhotoV];
	[_maskControlView addSubview:maskPhotoV];
	
	self.controlMode = ControlModeMaskPhoto;
}
@end
