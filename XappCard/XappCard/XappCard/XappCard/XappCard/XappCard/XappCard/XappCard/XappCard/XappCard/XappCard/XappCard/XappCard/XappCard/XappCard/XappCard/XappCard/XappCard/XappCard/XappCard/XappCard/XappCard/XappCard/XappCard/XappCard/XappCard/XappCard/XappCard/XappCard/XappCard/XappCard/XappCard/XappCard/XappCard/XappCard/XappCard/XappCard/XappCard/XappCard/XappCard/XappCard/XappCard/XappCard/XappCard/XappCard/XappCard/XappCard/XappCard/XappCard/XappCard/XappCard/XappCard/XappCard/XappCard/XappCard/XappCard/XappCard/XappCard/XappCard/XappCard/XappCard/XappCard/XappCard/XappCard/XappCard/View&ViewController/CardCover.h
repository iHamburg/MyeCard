//
//  CardCover.h
//  MyeCard
//
//  Created by  on 01.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "TKCoverflowCoverView.h"
#import "Utilities.h"

#define kTagCoverDeleteCard 123
#define kTagCoverCalendar   124

@interface CardCover : TKCoverflowCoverView{
	
}

@property (nonatomic, strong) UIButton *deleteB;
@property (nonatomic, strong) UIButton *calendarB;



@end
