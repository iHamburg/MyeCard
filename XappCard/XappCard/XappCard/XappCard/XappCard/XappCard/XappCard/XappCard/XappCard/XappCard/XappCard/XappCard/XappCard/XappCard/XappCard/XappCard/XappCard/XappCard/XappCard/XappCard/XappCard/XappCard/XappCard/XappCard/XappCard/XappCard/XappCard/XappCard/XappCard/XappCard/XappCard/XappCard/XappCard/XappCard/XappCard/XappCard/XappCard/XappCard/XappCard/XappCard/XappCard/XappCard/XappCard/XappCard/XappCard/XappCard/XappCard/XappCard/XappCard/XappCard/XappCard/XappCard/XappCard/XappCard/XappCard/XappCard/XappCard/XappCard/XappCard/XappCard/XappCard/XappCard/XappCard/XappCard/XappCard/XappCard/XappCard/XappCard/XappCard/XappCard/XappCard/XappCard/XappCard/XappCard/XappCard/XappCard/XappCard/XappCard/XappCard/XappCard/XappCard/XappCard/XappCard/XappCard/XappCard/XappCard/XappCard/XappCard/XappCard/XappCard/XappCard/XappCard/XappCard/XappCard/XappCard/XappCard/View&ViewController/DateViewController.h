//
//  DateViewController.h
//  MyeCard
//
//  Created by  on 28.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "PopoverContentViewController.h"
#import "CardsViewController.h"

@interface DateViewController : PopoverContentViewController{
	UIDatePicker *datePicker;

}

@property (nonatomic, unsafe_unretained) CardsViewController *cardsVC;
@property (nonatomic, strong) NSDate *date;
- (void)setLinkBarButtonTitle:(NSString*)title;

@end
