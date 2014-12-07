//
//  TextLabelView.m
//  XappCard
//
//  Created by  on 16.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "TextLabelView.h"

@implementation TextLabelView



- (void)setFontName:(NSString*)_fontName color:(UIColor*)_color{
	textView.font = [UIFont fontWithName:_fontName size:fontSize];
	textView.textColor = _color;
	
	self.fontName = _fontName;
	self.color = _color;
}

- (void)heightAnpassenWithTransform{
	// save the transform info 
	CGAffineTransform transform = self.transform;

	float angle = atan2(transform.b, transform.a);
	// turn to 0
	self.transform = CGAffineTransformRotate(transform, -angle);
	

	// height anpassen
	CGSize size = CGSizeMake(textView.bounds.size.width, 10000.0f);
	
	CGPoint origin = self.frame.origin;
	size = [textView sizeThatFits:size];

	
	[self setSize:size];
	[self setOrigin:origin];

	[self.textView setSize:size];
	[self.textView setOrigin:CGPointMake(0, 0)];

	self.transform = transform;

}

- (NSArray*)menuArray{
//	L();
	NSMutableArray *array =[NSMutableArray arrayWithArray:[super menuArray]];
//	NSLog(@" before array:%@",array);
	[array addObject:editItem];
//	NSLog(@" after array:%@",array);
	return array;
}
@end
