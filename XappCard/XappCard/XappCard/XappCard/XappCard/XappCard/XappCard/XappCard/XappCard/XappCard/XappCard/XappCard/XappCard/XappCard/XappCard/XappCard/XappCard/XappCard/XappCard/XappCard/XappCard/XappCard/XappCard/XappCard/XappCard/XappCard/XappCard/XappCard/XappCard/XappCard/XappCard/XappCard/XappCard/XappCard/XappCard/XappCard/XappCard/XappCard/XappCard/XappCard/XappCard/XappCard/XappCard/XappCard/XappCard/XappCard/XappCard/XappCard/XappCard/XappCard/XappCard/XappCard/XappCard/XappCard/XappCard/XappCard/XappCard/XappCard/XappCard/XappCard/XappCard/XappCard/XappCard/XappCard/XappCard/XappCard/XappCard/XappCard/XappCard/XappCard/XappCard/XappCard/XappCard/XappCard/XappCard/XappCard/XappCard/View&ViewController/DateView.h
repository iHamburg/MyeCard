//
//  DateView.h
//  MyeCard
//
//  Created by  on 28.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

@protocol DateViewDelegate;

@interface DateView : UIView{
	UINavigationBar *navBar;
	UIDatePicker *datePicker;
	UIBarButtonItem *cancelBB;
	UIBarButtonItem *doneBB;
}

@property (nonatomic, unsafe_unretained) id<DateViewDelegate> delegate;

@end

@protocol DateViewDelegate <NSObject>

- (void)dateViewDidSelectDate:(NSDate*)date;

@end