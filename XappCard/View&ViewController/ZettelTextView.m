//
//  ZettelTextView.m
//  XappCard
//
//  Created by  on 14.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ZettelTextView.h"



@implementation ZettelTextView

@synthesize selected,textView;


- (id)initWithFrame:(CGRect)frame text:(NSString*)_text{
	if(self = [super initWithFrame:frame]){
		text = _text;
		fontSize = 16;
		fontName = @"Chalkboard SE";
		color = [@"855b27" colorFromHex]; 
		
		[self initSubViews];
		
		UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelect)];
		[self addGestureRecognizer:gesture];
		
	}
	return self;
}



- (void)initSubViews{
	
	textView = [[UITextView alloc] initWithFrame:self.bounds];
	textView.autoresizingMask = AUTORESIZINGMASK;
	textView.backgroundColor = [UIColor clearColor];
	textView.text = text;
	textView.textColor = color;
	textView.font = [UIFont fontWithName:fontName size:fontSize];
	textView.editable = NO;
	textView.userInteractionEnabled = NO;
	textView.textAlignment = NSTextAlignmentCenter;
	
	
	// 48x48
	overlayV = [[UIView alloc] initWithFrame:self.bounds];
	overlayV.autoresizingMask = AUTORESIZINGMASK;
	overlayV.backgroundColor = [UIColor lightGrayColor];
	overlayV.alpha = 0;
	
	
	markIV = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, self.bounds.size.height-50, 48, 48)];
	markIV.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	markIV.image = [UIImage imageNamed:@"icon_mark.png"];
	markIV.alpha = 0;
	
	[self addSubview:textView];
	[self addSubview:overlayV];
//	[self addSubview:markIV];
	
//    textView.backgroundColor = [UIColor redColor];
//    self.backgroundColor = [UIColor blueColor];
	
}

- (void)dealloc{
//	L();
	overlayV = nil;
	markIV = nil;
	text = nil;
	color = nil;
	fontName = nil;
	textView = nil;
}
#pragma mark -

- (void)toggleSelect{
	L();
	if (self.selected) {
		self.selected = NO;
		overlayV.alpha = 0;
		markIV.alpha = 0;
	}
	else{
		self.selected = YES;
		overlayV.alpha = 0.5;
		markIV.alpha = 1;
	}
}

- (void)willAddContent{

	
	CGSize size = CGSizeMake(textView.bounds.size.width, 10000.0f);
    
	size = [textView sizeThatFits:size];
	
	if (isPad) {
		textView.font = [UIFont fontWithName:fontName size:40];
		[self setSize:CGSizeMake(size.width*2,size.height*2)];
	}
	else{
		[self setSize:size];	
	}
	
	overlayV.alpha = 0;
	markIV.alpha = 0;
}


- (void)heightAnpassen{
	
	CGSize size = CGSizeMake(textView.bounds.size.width, 10000.0f);
	
	size = [textView sizeThatFits:size];
	//	NSLog(@"size:%@",NSStringFromCGSize(size));
	
	[self setSize:size];
//	[textView setSize:size];
	textView.frame = CGRectMake(0, 0, size.width, size.height);
}

- (NSString*)text{
	return textView.text;
}

- (void)setFontName:(NSString*)_fontName color:(UIColor*)_color fontSize:(CGFloat)_fontSize{
	
//	L();
	
	//	NSLog(@"textView:%@, color:%@,text:%@",textView,_color,_text);
	
	
	textView.font = [UIFont fontWithName:_fontName size:_fontSize];
	textView.textColor = _color;
	
	
//	self.fontName = _fontName;
//	self.color = _color;
//	self.text = _text;
//	
	//	[self heightAnpassen];
}

@end
