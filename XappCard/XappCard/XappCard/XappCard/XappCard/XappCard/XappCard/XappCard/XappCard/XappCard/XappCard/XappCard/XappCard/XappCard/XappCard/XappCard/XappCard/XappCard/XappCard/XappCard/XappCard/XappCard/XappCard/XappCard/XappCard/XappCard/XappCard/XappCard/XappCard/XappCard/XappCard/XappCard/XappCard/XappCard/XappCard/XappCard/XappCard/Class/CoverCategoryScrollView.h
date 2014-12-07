//
//  CoverCategoryScrollView.h
//  MyeCard
//
//  Created by AppDevelopper on 08.01.13.
//
//

#import <UIKit/UIKit.h>
#import "CoverflowViewController.h"

@interface CoverCategoryScrollView : UIScrollView{
	UIView *bgV;
	
	NSArray *coverCategorys;
	
	CGFloat w,h;
	
	CAGradientLayer *greenGradientLayer;
	int selectedIndex;
	
}


@property (nonatomic, unsafe_unretained) CoverflowViewController *parent;

@property (nonatomic, assign) int selectedIndex;

- (id)initWithFrame:(CGRect)frame parent:(id)parent;


@end
