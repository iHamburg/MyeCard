//
//  CardViewController.m
//  XappCard
//
//  Created by  on 01.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardViewController.h"



@implementation CardViewController

@synthesize card,rootVC,controllView;

#pragma mark - View lifecycle

- (id)initWithCard:(Card*)_card{
	if (self = [super init]) {
		card = _card;
	}
	return self;
}

- (void)loadView{
	
	
    
    if(isIOS8){

        self.view = [[UIView alloc] initWithFrame:isPad?CGRectMake(0, 0, 960, 640):CGRectMake(0, 0, 480, 320)];
        w = self.view.bounds.size.width;
        h = self.view.bounds.size.height;

    
    }
    else{
       
        self.view = [[UIView alloc] initWithFrame:isPad?CGRectMake(0, 0, 960, 640):CGRectMake(0, 0, 480, 320)];
        w = self.view.bounds.size.width;
        h = self.view.bounds.size.height;
    }

	
	self.view.backgroundColor = [UIColor blackColor];
	
	bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
	bgV.autoresizingMask = AUTORESIZINGMASK;
    
//    bgV.contentMode = UIViewContentModeScaleAspectFit;
	
	self.view.layer.cornerRadius = CORNERRADIUS;
	self.view.layer.masksToBounds = YES;
	
	controllView = [[MyView alloc] initWithFrame:self.view.bounds];
	controllView.autoresizingMask = AUTORESIZINGMASK;
	controllView.delegate = self;
	
	[self.view addSubview:bgV];
	[self.view addSubview:controllView];
	

	// 长按返回默认bg图片
	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
	[self.view addGestureRecognizer:longPressGesture];
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	
	
}

- (void)setCard:(Card *)_card{
	card = _card;
	[self setup];
}
- (void)setup{
	
}

#pragma mark -
- (void)changeBG:(UIImage*)image{

	bgV.image = image;
	[self.view insertSubview:bgV belowSubview:controllView];
	
}


- (void)addElement:(UIView*)v center:(CGPoint)center style:(int)style{
	
	L();
	
	v.center = center;
	[controllView addGestureRecognizersToPiece:v];
	[controllView addSubview:v];
}

- (BOOL)containElement:(id)element{
	
	for (UIView *v in controllView.subviews) {
		if (v == element) {
			return YES;
		}
	}
	return NO;
}

- (void)newCardVC{
	NSArray *array = controllView.subviews;
	for (UIView *v in array) {
		if ([v isKindOfClass:[CardEditView class]]) {
			[v removeFromSuperview];
		}
	}
}

#pragma mark - Load

- (void)loadBG:(NSURL*)url{
	
	if (ISEMPTY(url)) {
		return;
	}
	
	AlbumLoader *albumLoader =[[AlbumLoader alloc] init];
	albumLoader.delegate = self;
	
	[albumLoader loadUrls:[NSArray arrayWithObject:url] withKey:@"loadBG"];
}


- (void)loadElements:(NSMutableArray*)array{
	
	if (ISEMPTY(array)) {
		return;
	}

}

#pragma mark - AlbumLoader
- (void)didLoadAsset:(ALAsset*)asset withKey:(NSString *)key{

	
}

@end
