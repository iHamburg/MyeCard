//
//  ZettelTextView.h
//  XappCard
//
//  Created by  on 14.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToggleDelegate.h"
#import "Controller.h"

@interface ZettelTextView : UIView<ToggleDelegate>{
	
	UIView *overlayV;
	UIImageView *markIV;
	NSString *text;
	CGFloat fontSize;
	UIColor *color;
	NSString *fontName;		
	UITextView *textView;
}

@property (nonatomic, strong) UITextView *textView;

- (id)initWithFrame:(CGRect)frame text:(NSString*)text;
- (void)willAddContent;

- (void)initSubViews;

- (void)heightAnpassen;

- (NSString*)text;

- (void)setFontName:(NSString*)fontName color:(UIColor*)color fontSize:(CGFloat)fontSize;
@end


