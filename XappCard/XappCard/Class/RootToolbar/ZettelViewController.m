//
//  ZettelViewController.m
//  XappCard
//
//  Created by  on 16.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "ZettelViewController.h"

#import "ELCAsset.h"
#import "ZettelTextView.h"
#import "ZettelCardTextView.h"

@implementation ZettelViewController




#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	
	self.view = [[UIView alloc] initWithFrame:ROOTZETTELFRAME];   
	self.view.backgroundColor = [UIColor whiteColor];

	self.title = NSLocalizedString(@"ZettelTitel", nil);
	
	// 480x500 or 480x276
	CGFloat padding = 10;
	
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(padding, 0, self.view.bounds.size.width-2*padding, self.view.bounds.size.height)];
    scrollView.autoresizingMask = AUTORESIZINGMASK;
    scrollView.backgroundColor = [UIColor whiteColor];

	
	[self loadData];
	
	[self.view addSubview:scrollView];
}




- (void)viewWillAppear:(BOOL)animated{
//    L();
	
	[super viewWillAppear:animated];
	for (ZettelTextView *v in zettelVs) {
		if (v.selected) {
			[v toggleSelect];
		}
	}
}


#pragma mark -
- (void)loadData{
//	L();
	zettelVs = [NSMutableArray array];
	NSArray *fullZettels = [[SpriteManager sharedInstance] fullZettels];
	NSDictionary *fullZettelCats = [[SpriteManager sharedInstance] fullZettelCats];
	
	NSString *cat;
	
	CGFloat height = 0;
	for (int i = 0; i< [fullZettels count]; i++) {
		NSDictionary *dict = [fullZettels objectAtIndex:i];
		int catID = [[dict objectForKey:@"Cat"] intValue];
		NSString *catIDStr = [NSString stringWithInt:catID];
		NSString *thisCat = [fullZettelCats objectForKey:catIDStr];
	
		if (![cat isEqualToString:thisCat]) {
			cat = thisCat;
			UILabel *catL = [[UILabel alloc] initWithFrame:CGRectMake(0, 10+height, 460, 50)];
			catL.text = cat;
			catL.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:30];
			catL.textAlignment = NSTextAlignmentCenter;
			catL.textColor = [UIColor darkGrayColor];
			[scrollView addSubview:catL];
			
			height+=60;
		}
		
		ZettelTextView *zettelV = [[ZettelTextView alloc] initWithFrame:CGRectMake(0, 10+height, 460, 100) text:[dict objectForKey:@"Text"]];
		[zettelV heightAnpassen];
        
        zettelV.center = CGPointMake(self.view.width/2, zettelV.center.y);
		
		height += zettelV.bounds.size.height+10;
		
		[zettelVs addObject:zettelV];
		[scrollView addSubview:zettelV];
	
//        NSLog(@"zettelV # %@",zettelV);
		
	}

	scrollView.contentSize = CGSizeMake(0, height);
}

#pragma mark - Navigation


- (void)done:(id)sender{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i<[zettelVs count]; i++) {
		
        ZettelTextView *v = [zettelVs objectAtIndex:i];
        if (v.selected) {

			// initwithframe:text + heighanpassen
			ZettelCardTextView *cardTextV = [[ZettelCardTextView alloc] initWithFrame:CGRectMake(0, 0, 460, 100) text:v.text];

			[cardTextV heightAnpassen];
											
			[array addObject:cardTextV];
        }
    }


    
	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiContentAddZettel object:array];
  
	[self cancel:nil];
}
@end
