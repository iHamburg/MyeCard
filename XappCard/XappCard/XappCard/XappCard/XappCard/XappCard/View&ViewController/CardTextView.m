//
//  CardTextView.m
//  XappCard
//
//  Created by  on 16.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardTextView.h"

@implementation CardTextView

@synthesize text,fontName,color,textView,fontSize;


- (void)initialize{

	L();

	
	fontSize = isPad?32:16;
	textView = [[UITextView alloc] initWithFrame:self.bounds];
	fontName = @"Chalkboard SE";
	color = [@"855b27" colorFromHex]; 
	
	textView.backgroundColor = [UIColor clearColor];
	textView.font = [UIFont fontWithName:fontName size:fontSize];
	textView.userInteractionEnabled = NO;
	
	[self addSubview:textView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self initialize];
		
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame text:(NSString*)_text{
	if(self = [self initWithFrame:frame]){
		text = _text; 
		[self setFontName:fontName color:color text:text];
		
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{

	if (self = [super initWithCoder:aDecoder]) {
		
		self.text = [aDecoder decodeObjectForKey:@"text"];
		self.fontName = [aDecoder decodeObjectForKey:@"fontName"];
		self.color = [aDecoder decodeObjectForKey:@"color"];
		self.textView = [aDecoder decodeObjectForKey:@"textView"];
		self.layer.anchorPoint = [aDecoder decodeCGPointForKey:@"archorPoint"];
		self.locked = [aDecoder decodeBoolForKey:@"locked"];
		fontSize = [aDecoder decodeFloatForKey:@"fontSize"];

		
		[self setFontName:fontName color:color text:text];
		
	}
//	NSLog(@"initWithCoder Text:%@,anchor:%@,subviews:%@",self,NSStringFromCGPoint(self.layer.anchorPoint),self.subviews);
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{

	[super encodeWithCoder:coder];
	
	[coder encodeObject:self.text forKey:@"text"];
	[coder encodeObject:self.fontName forKey:@"fontName"];
	[coder encodeObject:self.color forKey:@"color"];
	[coder encodeObject:self.textView forKey:@"textView"];
	[coder encodeCGPoint:self.layer.anchorPoint forKey:@"archorPoint"];
	[coder encodeBool:self.locked forKey:@"locked"];
	[coder encodeFloat:fontSize forKey:@"fontSize"];
	
	//	NSLog(@"encode transform:%@, origin:%@",NSStringFromCGAffineTransform(imgTransform), NSStringFromCGPoint(imgOrigal));

//	NSLog(@"encode Text:%@,anchor:%@,subviews:%@",self,NSStringFromCGPoint(self.layer.anchorPoint),self.subviews);
}



- (void)setFontName:(NSString*)_fontName color:(UIColor*)_color text:(NSString*)_text{
	
//	L();
	
	//	NSLog(@"textView:%@, color:%@,text:%@",textView,_color,_text);
	
	
	self.textView.font = [UIFont fontWithName:_fontName size:fontSize];
	self.textView.textColor = _color;
	self.textView.text = _text;
	
	self.fontName = _fontName;
	self.color = _color;
	self.text = _text;
	
}

- (void)heightAnpassen{
	L();
//	NSLog(@"before:%@",self);
	CGSize size = CGSizeMake(textView.bounds.size.width, 10000.0f);
	
	CGPoint origin = self.frame.origin;
	size = [textView sizeThatFits:size];
//	NSLog(@"size:%@",NSStringFromCGSize(size));
	
	[self setSize:size];
	[self setOrigin:origin];
//	NSLog(@"after:%@",self);
	[self.textView setSize:size];
	[self.textView setOrigin:CGPointMake(0, 0)];
}

- (void)setFontName:(NSString*)fontName color:(UIColor*)color{
	
}


- (NSArray*)menuArray{
//	L();
	NSArray *array;
//	NSLog(@"lock:%@,unlock:%@",lockItem,unlockItem);
	if (self.locked) {
		array = [NSArray arrayWithObjects:unlockItem, nil];
	}
	else{
		array = [NSArray arrayWithObjects:lockItem, nil];
	}
	
	return array;
}
@end
