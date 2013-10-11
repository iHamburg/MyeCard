

#import "CoverflowViewController.h"
#import "CoverCategoryScrollView.h"
#import "CoverPackageViewController.h"
#import "EcardCoverView.h"


@implementation CoverflowViewController
@synthesize coverVC, coverflow, initialIndex, coverImgName;

- (void)setCoverImgName:(NSString *)acoverImgName{
	coverImgName = acoverImgName;
	
	NSIndexPath *indexPath = [[SpriteManager sharedInstance]indexPathOfImageName:coverImgName];
	int categoryIndex = indexPath.section;
	int coverIndex = indexPath.row;
	
	categoryScrollView.selectedIndex = categoryIndex;
	coverCategory = [[SpriteManager sharedInstance]coverCategorys][categoryIndex];
	
	
	[coverflow setNumberOfCovers:[coverCategory.coverImgNames count]];
	[coverflow bringCoverAtIndexToFront:coverIndex animated:NO];

	
	
}

- (void)setInitialIndex:(int)_initialIndex{
	initialIndex = _initialIndex;

	categoryScrollView.selectedIndex = 2;
	coverCategory = [[SpriteManager sharedInstance]coverCategorys][2];

	
	[coverflow setNumberOfCovers:[coverCategory.coverImgNames count]];
	[coverflow bringCoverAtIndexToFront:initialIndex animated:NO];

	
}




- (void) loadView{
	L();
	
	rootVC = [RootViewController sharedInstance];
	
	CGRect r = [UIScreen mainScreen].bounds;
	r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
	r.origin = CGPointZero;
	self.view = [[UIView alloc] initWithFrame:r];
	self.view.backgroundColor = [UIColor blackColor];
	w = r.size.width;
	h = r.size.height;


	UIImageView *step1V = [[UIImageView alloc] initWithFrame:isPad?CGRectMake(112,20,500,60):CGRectMake(56, 40, 250, 30)];
	step1V.center = CGPointMake(self.view.center.x, isPad?45:20);
	
	step1V.image = [[SpriteManager sharedInstance] stepImageWithIndex:1];

	CGRect coverFlowRect = CGRectMake(0, 65, w, 255);
	coverflow = [[TKCoverflowView alloc] initWithFrame:isPad?self.view.bounds:coverFlowRect];

    coverflow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
    coverflow.coverSize = isPad?CGSizeMake(480, 320):CGSizeMake(240, 160);
	coverflow.coverSpacing = isPad?200:100; // cover 间 horizontal的间距

	CGFloat hScrollV = isPad?60:30;
	CGFloat hScrollMargin = isPad?85:36;
	categoryScrollView = [[CoverCategoryScrollView alloc] initWithFrame:CGRectMake(0, hScrollMargin, w, hScrollV) parent:self];

	
	/**
	 还需要修改 setup 的 availableCoverNum
	 */
	
	[self.view addSubview:coverflow];
	[self.view addSubview:step1V];
	[self.view addSubview:categoryScrollView];


	
	
	coverCategory = [[SpriteManager sharedInstance]coverCategorys][0];
	[coverflow setNumberOfCovers:[coverCategory.coverImgNames count]];
	[coverflow bringCoverAtIndexToFront:0 animated:NO];

}


// 每次setup都是回到all！
- (void)setup{
	L();
	
	coverCategory = [[SpriteManager sharedInstance]coverCategorys][0];
	[coverflow setNumberOfCovers:[coverCategory.coverImgNames count]];
	[coverflow bringCoverAtIndexToFront:0 animated:NO];
	categoryScrollView.selectedIndex = 0;

}

- (void) viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];
	self.view.frame = rootVC.r;

    [self layoutADBanner:[AdView sharedInstance]];
}


- (void) didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    L();
	
	[super didReceiveMemoryWarning];
	
//	self.covers = nil;
	// Release any cached data, images, etc that aren't in use.
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notification

- (void)registerNotifications
{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAdviewNotification:) name:NotificationAdChanged object:nil];
  
}

- (void)handleAdviewNotification:(NSNotification*)notification{
    [self layoutADBanner:notification.object];
    
}



#pragma mark -  ADView


- (void)layoutADBanner:(AdView *)banner{
    
    L();
    [UIView animateWithDuration:0.25 animations:^{
		
		if (banner.isAdDisplaying) { // 从不显示到显示banner
            
			[banner setOrigin:CGPointMake(0, _h - banner.height)];
			
			[[[RootViewController sharedInstance] view] addSubview:banner];
		}
		else{
			[banner setOrigin:CGPointMake(0, _h)];

		}
		
    }];
    
}


#pragma mark - IBAction


- (IBAction)handleTap:(UITapGestureRecognizer*)gesture{
	
	int index = [[gesture view]tag]-1;
	categoryScrollView.selectedIndex = index;
	coverCategory = [[SpriteManager sharedInstance]coverCategorys][index];
	[coverflow setNumberOfCovers:[coverCategory.coverImgNames count]];
	[coverflow bringCoverAtIndexToFront:0 animated:NO];

}

#pragma mark - CoverFlow

// place
- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{
	
	EcardCoverView *cover = (EcardCoverView*)[coverflowView dequeueReusableCoverView];

	
	if(cover == nil){

		CGRect rect = CGRectMake(0, 30, coverflow.coverSize.width, coverflow.coverSize.height);
		cover = [[EcardCoverView alloc] initWithFrame:rect]; 
		cover.baseline = isPad?324:144; // 
		
		if (coverCategory.available) {
			[cover hideLock];
		}
		else{
			[cover showLock];
		}

	}

	
	NSString *acoverImgName = [coverCategory coverImgNameWithIndex:index];
	
	UIImage *img = [UIImage imageWithContentsOfFileUniversal:acoverImgName];
//	NSLog(@"imgName # %@, img # %@",acoverImgName,img);
	cover.image = [img imageByScalingAndCroppingForWidth:cover.width];
		
	return cover;
	
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{


}

- (void) coverflowView:(TKCoverflowView *)coverflowView coverAtIndexWasTapped:(int)index{
    L();

	if (coverCategory.available) { // to cover

		NSString *acoverImgName = [coverCategory coverImgNameWithIndex:index];


		Card *card = rootVC.card;

		card.coverImgName = acoverImgName;

		card.coverBgUrl = nil;

		if (card.coverMaskFlag) {

			[rootVC.coverVC applyMask:[UIImage imageWithContentsOfFileUniversal:acoverImgName]];
			[rootVC toCoverWithMask];
		}
		else{

			[rootVC.coverVC changeBG:[UIImage imageWithContentsOfFileUniversal:acoverImgName]];
			[rootVC toCover:NO];
		}

	}
	else{ // show iap alert
		

		[[MyStoreObserver sharedInstance]showFullVersionAlert];
	}
}

#pragma mark - IAP

- (UIView*)viewForLoading{
	return self.view;
}
@end