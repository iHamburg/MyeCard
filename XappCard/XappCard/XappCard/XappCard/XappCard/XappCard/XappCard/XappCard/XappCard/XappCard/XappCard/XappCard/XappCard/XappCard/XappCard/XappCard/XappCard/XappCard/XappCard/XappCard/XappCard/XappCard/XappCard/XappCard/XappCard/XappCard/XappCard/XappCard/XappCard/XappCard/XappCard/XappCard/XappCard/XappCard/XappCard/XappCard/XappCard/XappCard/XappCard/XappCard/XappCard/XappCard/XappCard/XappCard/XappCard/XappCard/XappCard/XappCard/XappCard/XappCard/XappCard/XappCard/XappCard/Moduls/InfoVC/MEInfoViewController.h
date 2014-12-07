//
//  MEInfoViewController.h
//  MyeCard
//
//  Created by AppDevelopper on 13-10-9.
//
//

#import "InfoViewController.h"

@interface MEInfoViewController : InfoViewController{
  	
	UIButton *aboutB,*recommendB,*supportB,*facebookB,*twitterB, *downloadB, *instructionB;
	UIButton *myecardB,*tinyKitchenB,*ncsB, *firstAppB;
	UIImageView *binder, *ribbon,*featureV;
	UIScrollView *scrollView;
	UILabel *otherAppL;
	UITextView *textV;
    
	CGFloat width,height;

}

@end
