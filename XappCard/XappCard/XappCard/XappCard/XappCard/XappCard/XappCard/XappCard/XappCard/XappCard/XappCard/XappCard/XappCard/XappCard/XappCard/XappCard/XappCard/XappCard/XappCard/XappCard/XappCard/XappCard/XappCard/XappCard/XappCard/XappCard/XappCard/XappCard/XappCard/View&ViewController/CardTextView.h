//
//  CardTextView.h
//  XappCard
//
//  Created by  on 16.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardEditView.h"

@interface CardTextView : CardEditView{
	UITextView *textView;
	
	NSString *text;
	float fontSize;
	NSString *fontName;
	UIColor *color;

}

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) float fontSize;

- (void)initialize;
- (id)initWithFrame:(CGRect)frame text:(NSString*)text;
- (void)heightAnpassen;
- (void)setFontName:(NSString*)fontName color:(UIColor*)color text:(NSString*)text;


@end
