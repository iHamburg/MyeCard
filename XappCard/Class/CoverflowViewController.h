
#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "CoverViewController.h"
#import "MyStoreObserver.h"
#import "Utilities.h"
#import "RootViewController.h"


#define kTagLock 111

@class CoverPackageViewController;
@class CoverCategoryScrollView;

@interface CoverflowViewController : UIViewController <UIPopoverControllerDelegate,TKCoverflowViewDelegate,TKCoverflowViewDataSource, IAPDelegate> {
	
	TKCoverflowView *coverflow; 

	
	CoverCategoryScrollView *categoryScrollView;

	CoverCategory *coverCategory;
	
	RootViewController *rootVC;
	
	int availableCoverNum;
	
	CGFloat w,h;

}
@property (nonatomic, strong) NSString *coverImgName;

@property (nonatomic, assign) int initialIndex; // called from RootVC to set initial Cover

@property (nonatomic, strong) TKCoverflowView *coverflow;
@property (unsafe_unretained, nonatomic) CoverViewController *coverVC; 


- (void)setup; // IAPDidfinished 会调用

@end

