//
//  CoverViewController.h
//  XappCard
//
//  Created by  on 01.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//


#import "CardViewController.h"
#import "PictureWithFrameView.h"

#define kCoverMaskPhotoKey @"coverMaskPhoto"

typedef enum{
	ControlModeText,
	ControlModeMaskPhoto
}ControlMode;

@interface CoverViewController : CardViewController{

	PictureWithFrameView *maskPhotoV; //photoWidget

	MyView *_maskControlView;
}

@property (nonatomic, assign) ControlMode controlMode; // 0: text , 1: mask photo

- (void)applyMask:(UIImage*)maskImage;
- (void)applyMaskPhoto:(PictureWithFrameView*)maskPhotoV;


@end
