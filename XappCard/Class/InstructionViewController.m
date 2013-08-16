//
//  InstructionViewController.m
//  XappCard
//
//  Created by  on 03.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "InstructionViewController.h"


@implementation InstructionViewController

@synthesize delegate;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
	L();
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{

	CGRect rect = CGRectMake(0, 0, 480, 320);
	CGRect containerRect = CGRectMake(0, 0, 480, 320);
	if (isPad) {
		rect = CGRectMake(0, 0, 1024, 768);
		containerRect = CGRectMake(0, 0, 1024, 768);
	}
	else if(isPhoneRetina4){
		rect = CGRectMake(0, 0, 568, 320);
		containerRect = CGRectMake(44, 0, 480, 320);
	}
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.backgroundColor = [UIColor blackColor];
	
	UIView *container = [[UIView alloc]initWithFrame:containerRect];

	
	pageNum = 6;
	width = containerRect.size.width;
	self.view.autoresizingMask = AUTORESIZINGMASK;

	CGFloat height = self.view.bounds.size.height;
	
	UIButton *quitB = [[UIButton alloc]initWithFrame:isPad?CGRectMake(50, 50, 50, 50):CGRectMake(25, 25, 25, 25)];
	[quitB setImage:[UIImage imageWithContentsOfFile:GetFullPath(@"pic/Instruction/Instruction_quit.png")] forState:UIControlStateNormal];
	[quitB addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchUpInside];

	
	UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:container.bounds];
	scrollView.autoresizingMask = AUTORESIZINGMASK;
	scrollView.backgroundColor = [UIColor blackColor];
	scrollView.alpha = 0.9;
	scrollView.pagingEnabled = YES;
	scrollView.contentSize = CGSizeMake(width*pageNum, 0);
	scrollView.delegate = self;
	for (int i = 0; i<6; i++) {
		
		UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(width*i, 0, width, height)];

		UIImage *img = [[SpriteManager sharedInstance] instructionImageWithIndex:i];
		
		imgV.image = img;
		[scrollView addSubview:imgV];

	}
	
	pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.height-30, self.view.width, 30)];
	pageControl.numberOfPages = 6;
	
	[self.view addSubview:container];
	
	[container addSubview:scrollView];
	[container addSubview:quitB];
	[container addSubview:rightV];
	[container addSubview:pageControl];

}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - IBAction

- (IBAction)quit:(id)sender{
	L();
	[self.view removeFromSuperview];
}

#pragma mark - ScrollView


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	CGFloat xOffset = scrollView.contentOffset.x;
	int page = xOffset/scrollView.width;
	pageControl.currentPage = page;
}
@end
