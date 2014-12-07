//
//  ArchivedImageView.h
//  XappCard
//
//  Created by  on 17.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArchivedImageView : UIView


@property (nonatomic, assign) CGPoint archorPoint;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL shadowEnabled;
@property (nonatomic, assign) BOOL frameEnabled;
@property (nonatomic, strong) UIColor *frameColor;




- (id)initWithPictureView:(UIView*)pictureV;

- (void)willSaveView:(UIView*)v;
@end
