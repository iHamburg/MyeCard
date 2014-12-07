//
//  ContentViewController.h
//  XappCard
//
//  Created by  on 30.11.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//


#import "CardViewController.h"

@class PortfolioView;

@interface ContentViewController : CardViewController{

	NSMutableArray *picArr;	
	
}

@property (nonatomic, strong) IBOutlet PortfolioView *portfolioView;
@property (nonatomic, strong) IBOutlet UIImageView *step2IV;
@property (nonatomic, strong) IBOutlet UIImageView *step3IV;

- (void)setProfileEnable:(BOOL)enabled;
- (void)setProfile:(UIImage*)img;
- (void)changeDefaultBG;
- (void)hideStep:(int)step;
- (int) picNum;

@end


