//
//  CoverPackageViewController.h
//  MyeCard
//
//  Created by AppDevelopper on 03.10.12.
//
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "CoverflowViewController.h"

//scrollview of preview images,最上面有一行价格的label
typedef enum {
	CoverPackageTypeHalloween,
	CoverPackageTypeThanksgiving,
	CoverPackageTypeAnniversary,
	CoverPackageTypeChristmas
}CoverPackageType;

@interface CoverPackageViewController : UIViewController<IAPDelegate>{
	UINavigationBar *naviBar;
	UILabel *headerL;
	UIButton *restoreB;
	UIImageView *imgV;
	UIScrollView *scrollView;
	UIBarButtonItem *backBB, *buyBB;
	
	NSString *iapIdentifier;
}

@property (nonatomic, unsafe_unretained) CoverflowViewController *vc;
@property (nonatomic, assign) CoverPackageType type;
@property (nonatomic, strong) NSArray *thumbImgVs;

- (void)setup;

- (void)cancel;
- (void)buyPackage;
- (void)restore;
@end
