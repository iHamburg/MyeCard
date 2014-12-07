//
//  CardEditView.m
//  XappCard
//
//  Created by  on 19.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardEditView.h"

@interface CardEditView()
// for initwithframe and initwithcoder(if cardText use archivedtext, it won't be userful)
- (void)initCardEditView;
@end

@implementation CardEditView

@synthesize  menuArray,locked;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

		[self initCardEditView];
    }
    return self;
}



- (id)initWithCoder:(NSCoder *)aDecoder{
	
	if (self = [super initWithCoder:aDecoder]) {
		[self initCardEditView];
	}
	return self;
}

- (void)initCardEditView{
//	L();
	lockItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Lock", nil) action:@selector(lockPiece:)];
	unlockItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Unlock", nil) action:@selector(unlockPiece:)];
	bgMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"As Background", nil) action:@selector(setBackground:)];
	editItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Edit", nil) action:@selector(edit:)];
	
}

- (void)dealloc{

	
	L();
	lockItem = nil;
	unlockItem = nil;
	editItem = nil;
	bgMenuItem = nil;
}
#pragma mark - SaveLoadDelegate
- (id)save{
	
	return self;
}


@end
