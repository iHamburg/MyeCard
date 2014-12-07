//
//  LoveViewController.m
//  XappCard
//
//  Created by  on 03.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "LoveViewController.h"

#import "ZettelTextView.h"
#import "ELCAsset.h"
#import "ZettelCardTextView.h"

@implementation LoveViewController



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
	
		
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
//	L();
	self.view = [[UIView alloc] initWithFrame:ROOTZETTELFRAME];   
	self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	
	[self initSubViews];
	[self loadData];
	
	self.title = NSLocalizedString(@"Love", nil);
	
}




- (void)viewWillAppear:(BOOL)animated{
//	L();
	[super viewWillAppear:animated];
	
//	NSLog(@"love.view:%@",self.view);

	for (ZettelTextView *v in zettelVs) {
		if (v.selected) {
			[v toggleSelect];
		}
	}
	
}
- (void)initSubViews{
	
	// 480x500 or 480x276
	CGFloat padding = 10;
	
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(padding, 0, self.view.bounds.size.width-2*padding, self.view.bounds.size.height)];
	
    scrollView.autoresizingMask = AUTORESIZINGMASK;
    scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
  
	
	[self.view addSubview:scrollView];
}



#pragma mark -
- (void)loadData{
	NSArray *texts = [NSArray arrayWithObjects:@"Love",@"Liebe",@"爱",@"L'amour",@"Amor",@"Rakkaus",@"प्यार",@"Tình yêu",@"Aşk",
					  @"愛",@"사랑",@"Αγάπη",@"ความรัก",@"Amore",@"любовь",@"Liefde",@"Kjærlighet", nil];
	zettelVs = [NSMutableArray array];

	
	CGFloat height = 0;
	for (int i = 0; i< [texts count]; i++) {

		
		ZettelTextView *zettelV = [[ZettelTextView alloc] initWithFrame:CGRectMake(i%2*220, 10+height, 200, 50) text:[texts objectAtIndex:i]];
		[zettelV setFontName:@"Chalkboard SE" color:[@"DBAF29" colorFromHex] fontSize:32];
		[zettelV heightAnpassen];
		[zettelVs addObject:zettelV];
		[scrollView addSubview:zettelV];
		height+=50;	
	}
	
	scrollView.contentSize = CGSizeMake(0, height+100);
}

#pragma mark - Navigation


- (void)done:(id)sender{
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    for (int i = 0; i<[zettelVs count]; i++) {
		
        ZettelTextView *v = [zettelVs objectAtIndex:i];
        if (v.selected) {
			
			// initwithframe:text + heighanpassen
			ZettelCardTextView *cardTextV = [[ZettelCardTextView alloc] initWithFrame:CGRectMake(0, 0, 300, 60) text:v.text];
//			[cardTextV setf]
			cardTextV.fontSize = isPad?50:25;
			cardTextV.textView.font = [UIFont fontWithName:cardTextV.fontName size:cardTextV.fontSize];
			[cardTextV heightAnpassen];
			
			[array addObject:cardTextV];
        }
    }
    DLog(@"selected:%@",array);
	
    
	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiContentAddZettel object:array];
	
	[self cancel:nil];
}
@end
