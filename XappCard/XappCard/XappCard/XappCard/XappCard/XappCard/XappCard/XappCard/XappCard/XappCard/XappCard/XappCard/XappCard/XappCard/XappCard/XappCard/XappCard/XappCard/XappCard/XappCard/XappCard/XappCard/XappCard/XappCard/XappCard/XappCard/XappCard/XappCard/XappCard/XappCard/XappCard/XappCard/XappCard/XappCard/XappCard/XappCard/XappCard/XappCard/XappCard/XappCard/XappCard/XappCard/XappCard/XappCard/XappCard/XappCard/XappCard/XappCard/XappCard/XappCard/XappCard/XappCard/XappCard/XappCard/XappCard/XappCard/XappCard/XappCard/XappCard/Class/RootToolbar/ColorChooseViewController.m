//
//  ColorChooseViewController.m
//  XappCard
//
//  Created by  on 27.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "ColorChooseViewController.h"


@implementation ColorChooseViewController

@synthesize setting;

NSString* colorPalette[6][4] = {
	
	@"000000",@"575757",@"b5b5b5",@"ffffff", //black and white
	@"c8ebb1",@"9bcc94",@"689864",@"405e0d", //green
	@"d14a89",@"ff6501",@"993303",@"673303", //red
	@"c7ddf5",@"91ceff",@"669acc",@"336799", //blue
	@"fff7ce",@"ffff66",@"ce9834",@"9a660d", //yellow
	@"8abcb9",@"fdc975",@"319ea1",@"ff945a", //other
	
};




#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 276)];
	
	self.contentSizeForViewInPopover = self.view.bounds.size;

	
	colorPlatteV = [[MyColorPlatteView alloc] initWithFrame:self.view.bounds];	
	colorPlatteV.delegate = self;
	colorPlatteV.autoresizingMask = kAutoResize;
	[self.view addSubview:colorPlatteV];

	
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - ColorPlatte
- (void)colorPlatte:(UIView *)v didTapColor:(UIColor *)color{
	L();
	[setting setValue:color forKey:kSettingFrameColor];
	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiPictureChangeFrameColor object:color];
	
	if (!isPad) { //iphone
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark -

- (void)handleTap:(UITapGestureRecognizer*)gesture{
	L();
	
	CGPoint point = [gesture locationInView:self.view];
	CGRect rect1 = CGRectMake(0, 0, 100, 100);
	CGRectContainsPoint(rect1, point);
	
	UIView *v = gesture.view;
	UIColor *color = v.backgroundColor;
	
	[setting setValue:color forKey:kSettingFrameColor];
	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiPictureChangeFrameColor object:color];
	
	if (!isPad) { //iphone
		[self.navigationController popViewControllerAnimated:YES];
	}
}
@end
