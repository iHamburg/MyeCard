//
//  LoveViewController.h
//  XappCard
//
//  Created by  on 03.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//


#import "PopoverContentViewController.h"
@interface LoveViewController : PopoverContentViewController{
	
	NSMutableArray *zettelVs; //V
	UIScrollView *scrollView;
}

- (void)loadData;

@end
