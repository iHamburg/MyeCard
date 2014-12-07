//
//  PortfolioView.h
//  XappCard
//
//  Created by  on 09.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface PortfolioView : UIView

@property (nonatomic, unsafe_unretained) IBOutlet ContentViewController *contentVC;

@property (nonatomic, strong) UIImageView *portfolioFrame; // 18pix
@property (nonatomic, strong) UIImageView *portfolioPhoho; // 124x124
@property (nonatomic, strong) UIImageView *portfolioTextImageV;

- (void)initialize;

- (IBAction)handleTap:(UIGestureRecognizer*)gesture;
@end
