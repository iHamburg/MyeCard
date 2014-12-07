//
//  EcardCoverView.m
//  MyeCard
//
//  Created by AppDevelopper on 10.01.13.
//
//

#import "EcardCoverView.h"
#import "Utilities.h"

@implementation EcardCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		lockView= [[UIImageView alloc]initWithFrame:isPad?CGRectMake(410, 10, 60, 60):CGRectMake(200, 5, 30, 30)];
		lockView.userInteractionEnabled = YES;
		lockView.image = [UIImage imageNamed:@"icon_lock.png"];
		lockView.alpha = 0;
		[self addSubview:lockView];
    }
    return self;
}


- (void)showLock{
	lockView.alpha = 1;
}
- (void)hideLock{
	lockView.alpha = 0;
}

@end
