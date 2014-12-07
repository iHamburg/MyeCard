//
//  ZettelViewController.h
//  XappCard
//
//  Created by  on 16.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "PopoverContentViewController.h"



@interface ZettelViewController : PopoverContentViewController{

	NSMutableArray *zettelVs;
	UIScrollView *scrollView;
}

- (void)loadData;

@end
