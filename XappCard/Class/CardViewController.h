//
//  CardViewController.h
//  XappCard
//
//  Created by  on 01.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"
#import "MyView.h"
#import "CardEditView.h"



@interface CardViewController : UIViewController<AlbumLoaderDelegate, GestureDelegate>{
	
	Card *card;
	UIImageView *bgV;
	RootViewController __unsafe_unretained *rootVC;
	MyView *controllView;
	
	CGFloat w,h;
	
}

@property (nonatomic, strong) Card *card;
@property (nonatomic, unsafe_unretained) RootViewController *rootVC;
@property (nonatomic, strong) MyView *controllView;

- (void)setup;

- (id)initWithCard:(Card*)card;


- (void)newCardVC;

- (void)changeBG:(UIImage*)image;

- (void)loadBG:(NSURL*)url;

- (void)loadElements:(NSMutableArray*)array;

- (void)addElement:(UIView*)v center:(CGPoint)center style:(int)style;
- (BOOL)containElement:(id)element;
@end
