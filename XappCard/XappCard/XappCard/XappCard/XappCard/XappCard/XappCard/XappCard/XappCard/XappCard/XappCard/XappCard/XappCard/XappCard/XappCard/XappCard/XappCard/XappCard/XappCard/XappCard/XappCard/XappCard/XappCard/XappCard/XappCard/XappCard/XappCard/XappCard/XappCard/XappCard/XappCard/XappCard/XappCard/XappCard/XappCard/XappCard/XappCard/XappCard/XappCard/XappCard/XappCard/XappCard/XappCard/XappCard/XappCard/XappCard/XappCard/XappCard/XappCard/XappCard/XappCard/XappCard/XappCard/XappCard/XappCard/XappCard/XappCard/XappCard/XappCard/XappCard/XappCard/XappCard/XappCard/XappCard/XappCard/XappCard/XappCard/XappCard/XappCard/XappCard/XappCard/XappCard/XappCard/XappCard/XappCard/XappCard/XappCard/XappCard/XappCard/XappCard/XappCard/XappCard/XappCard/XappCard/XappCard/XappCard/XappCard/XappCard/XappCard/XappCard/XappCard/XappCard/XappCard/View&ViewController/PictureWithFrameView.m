//
//  PictureWithFrameView.m
//  XappCard
//
//  Created by  on 29.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "PictureWithFrameView.h"

#import "ArchivedImageView.h"


@implementation PictureWithFrameView

@synthesize url;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleNotificationChangeFrameColor:)
													 name:NotifiPictureChangeFrameColor object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleNotificationSetFrameEnabled:)
													 name:NotifiPictureSetFrameEnabled object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleNotificationSetShadowEnabled:)
													 name:NotifiPictureSetShadowEnabled object:nil];
		
		picture = [[UIImageView alloc] initWithFrame:frame];
		picture.contentMode = UIViewContentModeScaleToFill;
		[self addSubview:picture];
		
		// antialiasing
		self.layer.shouldRasterize = YES; 
		self.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
		self.clipsToBounds = NO; 
		self.layer.masksToBounds = NO;
		
		
		cardPicture = [[ArchivedImageView alloc] initWithFrame:CGRectZero];
    }
    return self;
}


- (id)initWithArchivedView:(ArchivedImageView*)v{
	cardPicture = v;

	self = [self initWithFrame:v.bounds];
	
	self.layer.anchorPoint = v.archorPoint;
	self.transform = v.transform;
	self.center = v.center;

	self.locked = v.locked;
	self.url = v.url;

	[self setFrameEnabled:v.frameEnabled];
	[self setFrameColor:v.frameColor];
	[self setShadowEnabled:v.shadowEnabled];
	
	return self;
}


- (id)initWithImage:(UIImage*)image{

	
	CGSize newSize = [UIView sizeForImage:image withMinSide:320];
	CGRect frame = CGRectMake(0, 0, newSize.width, newSize.height);
	
//	CGFloat scale = kRetinaPadScale;
	
	image = [image imageByScalingAndCroppingForSize:CGSizeMake(newSize.width, newSize.height)];
	
	self = [self initWithFrame:frame];
	
	picture.image = image;
		
	return self;
}


- (id)initWithCoverMaskImage:(UIImage*)image url:(NSURL*)_url{
	url = _url;
	self = [self initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	picture.image = image;
	
	return self;
}

- (void)dealloc{
	L();
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	picture = nil;
	url = nil;
	cardPicture = nil;
	
}

- (NSArray*)menuArray{
	NSArray *array;
	if (self.locked) {
		array = [NSArray arrayWithObjects:unlockItem,bgMenuItem, nil];
	}
	else{
		array = [NSArray arrayWithObjects:lockItem,bgMenuItem, nil];
	}
	
	return array;
}

#pragma mark -

- (PictureWithFrameView*)copy{
	
	PictureWithFrameView *copy = [[PictureWithFrameView alloc] initWithImage:self.image];
	copy.url = self.url;
	[copy setFrameEnabled:cardPicture.frameEnabled];
	[copy setShadowEnabled:cardPicture.shadowEnabled];
	[copy setFrameColor:cardPicture.frameColor];
	
	return copy;
	
}


- (void)setFrameEnabled:(BOOL)enabled{
//	L();
	if (enabled) {

		self.layer.borderWidth = 10;
		
	}
	else{

		self.layer.borderWidth = 0;
	}
	cardPicture.frameEnabled = enabled;
}

- (void)setShadowEnabled:(BOOL)enabled{
	if (enabled) {
	
		self.layer.shadowOffset = CGSizeMake(0, 3);
		self.layer.shadowRadius = 5.0;
		self.layer.shadowColor = [UIColor blackColor].CGColor;
		self.layer.shadowOpacity = 0.8;
	
	}
	else{
		
		self.layer.shadowColor = [UIColor clearColor].CGColor;
		
	}

	cardPicture.shadowEnabled = enabled;
}

- (void)setFrameColor:(UIColor*)color{
	
	self.layer.borderColor = color.CGColor;
	
	cardPicture.frameColor = color;
//	NSLog(@"cardPicture.frameColor:%@",cardPicture.frameColor);
}
- (UIImage*)image{
	NSLog(@"picture:%@",picture);
	return picture.image;
}

- (void)setImage:(UIImage*)img{
	picture.image= img;
}

- (id)save{
	
	[cardPicture willSaveView:self];

	return cardPicture;
}

#pragma mark - Notification

- (void)handleNotificationChangeFrameColor:(NSNotification*)notifi{
	
//	L();
	UIColor *color = [notifi object];
	
//	self.layer.borderColor = color.CGColor;
	
	[self setFrameColor:color];
	
//	cardPicture.frameColor = color;
}

- (void)handleNotificationSetFrameEnabled:(NSNotification*)notifi{
//	L();
	BOOL frameEnabled = [notifi.object boolValue];
	
//	cardPicture.frameEnabled = frameEnabled;
	[self setFrameEnabled:frameEnabled];

}


- (void)handleNotificationSetShadowEnabled:(NSNotification*)notifi{
//	L();
	BOOL shadowEnabled = [notifi.object boolValue];
	

	[self setShadowEnabled:shadowEnabled];
	

}
@end
