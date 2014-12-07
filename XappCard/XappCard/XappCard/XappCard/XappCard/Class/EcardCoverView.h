//
//  EcardCoverView.h
//  MyeCard
//
//  Created by AppDevelopper on 10.01.13.
//
//

#import "TKCoverflowCoverView.h"

@interface EcardCoverView : TKCoverflowCoverView{
	UIImageView *lockView;
    
}

- (void)showLock;
- (void)hideLock;

@end
