//
//  CoverCategoryScrollView.m
//  MyeCard
//
//  Created by AppDevelopper on 08.01.13.
//
//

#import "CoverCategoryScrollView.h"
#import "Utilities.h"
#import "SpriteManager.h"
//#import "FXLabel.h"

@implementation CoverCategoryScrollView

@synthesize parent, selectedIndex;

- (void)setSelectedIndex:(int)_selectedIndex{
	
	UILabel *oldL = (UILabel*)[self viewWithTag:selectedIndex+1];
	oldL.textColor = [UIColor whiteColor];
	
	selectedIndex = _selectedIndex;
	UILabel *l = (UILabel*)[self viewWithTag:selectedIndex+1];
	greenGradientLayer.frame = l.frame;
	[self.layer insertSublayer:greenGradientLayer atIndex:0];
	l.textColor = [[SpriteManager sharedInstance]yellowColor];
	
	[self setContentOffset:CGPointMake(CGRectGetMinX(l.frame)-(isPad?200:100), 0) animated:YES];
	
	
}


- (id)initWithFrame:(CGRect)frame parent:(id)_parent{
	parent = _parent;
	return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

		
		w = frame.size.width;
		h = frame.size.height;
		
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"darkBGPattern2.png"]];
		self.showsHorizontalScrollIndicator = NO;
	
		
		coverCategorys = [[SpriteManager sharedInstance]coverCategorys];
		
		CGFloat wLabel = isPad?500:200;
		
		for (int i = 0; i<[coverCategorys count]; i++) {
			
			CoverCategory *cat = coverCategorys[i];
			NSString *name = cat.name;
			UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(200+wLabel*i, 0, wLabel, h)];
			l.backgroundColor = [UIColor clearColor];
			l.textAlignment = NSTextAlignmentCenter;
			l.text = name;
			l.font = [[SpriteManager sharedInstance]coverCategoryFont];
			l.textColor = [UIColor whiteColor];
			l.userInteractionEnabled = YES;
			l.shadowColor = [UIColor blackColor];
			l.shadowOffset = CGSizeMake(0, isPad?2:1);
//			l.innerShadowColor = [UIColor colorWithWhite:1.0 alpha:0.8];
//			l.innerShadowOffset = CGSizeMake(0, isPad?2:1);
			[l addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:parent action:@selector(handleTap:)]];
			l.tag = i+1;
			[self addSubview:l];
			self.contentSize = CGSizeMake(CGRectGetMaxX(l.frame)+200, 0);
		}
		
		
		greenGradientLayer = [CAGradientLayer layer];
		greenGradientLayer.colors = @[(id)[[SpriteManager sharedInstance]lightGreenColor].CGColor,(id)[[SpriteManager sharedInstance]greenColor].CGColor];
		
		[self applyShadowBorder:kCALayerTopEdge withColor:[UIColor blackColor] indent:isPad?5:2];
		self.selectedIndex = 0;
    }
    return self;
}

- (void)handleTap:(id)sender{
	L();
}
@end
