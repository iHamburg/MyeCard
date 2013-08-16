//
//  PortfolioView.m
//  XappCard
//
//  Created by  on 09.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "PortfolioView.h"



@implementation PortfolioView

@synthesize contentVC;
@synthesize portfolioFrame,portfolioPhoho,portfolioTextImageV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}



- (void)awakeFromNib{

	 [self initialize];
}

- (void)initialize{

    portfolioFrame = [[UIImageView alloc] initWithFrame:self.bounds];
	portfolioFrame.autoresizingMask = AUTORESIZINGMASK;

	portfolioFrame.image = [[SpriteManager sharedInstance] portfolioImageWithIndex:1];
    [self addSubview:portfolioFrame];

    portfolioPhoho = [[UIImageView alloc] initWithFrame:isPad?CGRectMake(17, 14, 130, 130):CGRectMake(8, 6, 55, 55)];
//	portfolioPhoho.autoresizingMask = AUTORESIZINGMASK;
	portfolioPhoho.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:portfolioPhoho];
    
    portfolioTextImageV = [[UIImageView alloc] initWithFrame:isPad?CGRectMake(-80, -20, 174, 88):CGRectMake(-35, -8, 80, 40)];

    portfolioTextImageV.image = [[SpriteManager sharedInstance] portfolioImageWithIndex:2];
    [self addSubview:portfolioTextImageV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"avatarStatus"]==1) {
        // DLog(@"0 ->1");
        NSString *fileName = [NSString stringWithFormat:@"Documents/%@.png",@"profile"];
        NSString  *avatarPath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
        portfolioPhoho.image = [UIImage imageWithContentsOfFile:avatarPath];
        portfolioTextImageV.hidden = YES;
    }
    else{
		portfolioPhoho.image = [[SpriteManager sharedInstance] portfolioImageWithIndex:0];
    }
    
}


#pragma mark - 


- (IBAction)handleTap:(UIGestureRecognizer*)gesture{
    L();
    portfolioTextImageV.hidden = YES;

	[[RootViewController sharedInstance]pickProfile];

	
}

@end
