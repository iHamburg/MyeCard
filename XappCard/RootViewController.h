//
//  ViewController.h
//  XappCard
//
//  Created by Xappsoft on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <QuartzCore/QuartzCore.h>
#import "Controller.h"
#import "Card.h"
#import "AdView.h"
#import "InfoViewController.h"
#import "InstructionViewController.h"

#define kFirstVersionKey @"firstVersionKey"
#define kLastVersionKey @"lastVersionKey"
#define kUnableTipAlertKey @"tipAlert"
#define kUpdateAlertKey @"updateAlert"


@class CoverViewController;
@class ContentViewController;
@class TextLabelViewController;
@class ZettelViewController;
@class LoveViewController;
@class SettingViewController;
@class CardsViewController;
@class DateViewController;
@class CoverflowViewController;


@class ASIHTTPRequest;
/**
 
 banner: 
 
 pad: cover, content
 
 */

@interface RootViewController : UIViewController<InstructionDelegate,InfoDelegate,UIPopoverControllerDelegate, UIImagePickerControllerDelegate,
UIActionSheetDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate>{

		
	UIActionSheet *actionActionSheet, *cameraSheet;
	UIAlertView *coverTipAlert;
	UIAlertView *updateAlert;
	
	IBOutlet UIBarButtonItem *photoBB;
	IBOutlet UIBarButtonItem *coverTextBB;
	IBOutlet UIBarButtonItem *contentTextBB;
	IBOutlet UIBarButtonItem *coverPhotoBB;

	UIBarButtonItem *coverCameraBB;
	
    UIToolbar *toolbar2;

	UIView *container;
	
	UIPopoverController *popVC;
	UIImagePickerController *imgPicker;

	CoverViewController *coverVC;
	ContentViewController *contentVC;
	TextLabelViewController *textLabelVC;

	ZettelViewController *zettelVC;
	LoveViewController *loveVC;
	SettingViewController *settingVC;
	CardsViewController *cardsVC;
	DateViewController *dateVC;
	CoverflowViewController *coverFlowVC;
    
	InfoViewController *infoVC;
	InstructionViewController *instructionVC;
	
	ASIHTTPRequest *updateRequest;
	

	
	NSArray *coverItems;
	NSArray *contentItems;
	
	CGRect containerRect,containerWithBannerRect;
	CGRect toolbarRect,toolbarWithBannerRect;
	CGRect bannerRect,bannerOutRect;
	CGSize containerSize;
	CGFloat w,h;
	
	
	
}


@property (nonatomic, strong) Card *card;  // root的card是所有其他vc的句柄
@property (nonatomic, strong) CoverViewController *coverVC;
@property (nonatomic, strong) ContentViewController *contentVC;
@property (nonatomic, strong) CardsViewController *cardsVC;

@property (nonatomic, strong) SettingViewController *settingVC;
@property (nonatomic, strong) LoveViewController *loveVC;
@property (nonatomic, strong) ZettelViewController *zettelVC;
@property (nonatomic, strong) TextLabelViewController *textLabelVC;
@property (nonatomic, strong) DateViewController *dateVC;
@property (nonatomic, strong) CoverflowViewController *coverFlowVC;
@property (nonatomic, strong) InfoViewController *infoVC;

@property (nonatomic, assign) RootPhotoSource photoSource;
@property (nonatomic, assign) PopOverStatus popOverStatus;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *photoBB;
@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;

@property (nonatomic, assign) CGRect r;
@property (nonatomic, assign) CGSize containerSize;

@property (nonatomic, assign) BOOL isFirstOpen,isUpdateOpen;
@property (nonatomic, assign) float firstVersion, lastVersion, thisVersion; // lastVersion 只用来判断是否update！


+(id)sharedInstance;

- (void)setup;

- (void)checkVersion; // first, last, this version
- (void)preLoad;

- (void)willDismissPopOverViewController;
- (void)popViewController:(UIViewController*)vc withStatus:(PopOverStatus)status sender:(id)sender;


- (IBAction)toolbarButtonClicked:(id)sender;

- (void)switchCoverAndContent:(id)sender;

- (void)toCoverflow;
- (void)toCover:(BOOL)animated;
- (void)toCoverWithMask;
- (void)toContent;
- (void)toCards:(int)cardIndex;
- (void)toInstruction;
- (void)openDateVC;
- (void)toInfo;
- (void)closeInfo;

- (void)openCoverBGPhoto;

- (IBAction)popText:(UIView*)widget;

- (void)addDate:(NSDate*)date;
- (void)handleRemindNotification:(UILocalNotification*)notification;

- (void)pickProfile;
- (void)setTBItems:(RootMode)mode;
- (void)showRateAlert;

- (void)saveCard;

- (UIImage*)getEmailImage:(BOOL)coverEnabled inside:(BOOL)insideEnabled;
- (UIImage*)getPreviewImage;

//- (void)initBanner;

- (void)IAPDidFinished:(NSString*)identifier;
- (void)IAPDidRestored;


- (void)showTipAlert;

- (void)test;

@end
