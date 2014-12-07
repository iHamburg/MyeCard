//
//  PictureWithFrameView.h
//  XappCard
//
//  Created by  on 29.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CardEditView.h"

@class ArchivedImageView;
@interface PictureWithFrameView : CardEditView{
	UIImageView *picture;
	NSURL *url;
	ArchivedImageView *cardPicture;
}

@property (nonatomic, strong) NSURL *url;


- (id)initWithImage:(UIImage*)image;
- (id)initWithCoverMaskImage:(UIImage*)image url:(NSURL*)url;
- (id)initWithArchivedView:(UIView*)v;

- (void)setFrameEnabled:(BOOL)enabled;
- (void)setShadowEnabled:(BOOL)enabled;
- (void)setFrameColor:(UIColor*)color;
- (UIImage*)image;
- (void)setImage:(UIImage*)img;
- (PictureWithFrameView*)copy;

@end
