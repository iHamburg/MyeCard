//
//  FontScrollView.h
//  MyeCard
//
//  Created by AppDevelopper on 02.11.12.
//
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

#define FontDisplayString @"Xapp"
#define NumLabelInRow 4

@protocol FontScrollViewDelegate;

@interface FontScrollView : UIView<UIScrollViewDelegate>{
	UIScrollView *scrollView;
	UIPageControl *pageControl; //scrollview 带动pagecontrol
	UIImageView *selected;
	
	CGFloat w,h,margin,wLabel,hLabel;
	int numLabelInPage,numPages;
}

@property (nonatomic, unsafe_unretained) id<FontScrollViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *fontNames;
@property (nonatomic, assign) int selectedIndex;

- (void)setup;

@end

@protocol FontScrollViewDelegate <NSObject>

- (void)fontScrollViewDidSelectedIndexOfFont:(int)index;

@end