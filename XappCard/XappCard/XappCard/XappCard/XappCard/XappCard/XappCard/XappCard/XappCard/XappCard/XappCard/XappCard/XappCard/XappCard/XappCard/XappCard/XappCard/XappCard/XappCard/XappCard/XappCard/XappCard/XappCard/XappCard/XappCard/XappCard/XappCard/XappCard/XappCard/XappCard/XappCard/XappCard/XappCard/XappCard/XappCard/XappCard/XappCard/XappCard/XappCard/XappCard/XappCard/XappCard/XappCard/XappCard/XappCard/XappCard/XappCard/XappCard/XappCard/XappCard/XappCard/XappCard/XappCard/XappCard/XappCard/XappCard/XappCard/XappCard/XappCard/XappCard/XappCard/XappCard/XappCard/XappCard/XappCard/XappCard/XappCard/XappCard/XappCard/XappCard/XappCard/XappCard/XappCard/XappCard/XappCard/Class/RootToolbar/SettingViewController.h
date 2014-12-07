//
//  SettingViewController.h
//  XappCard
//
//  Created by  on 27.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "PopoverContentViewController.h"
#import "ColorChooseViewController.h"

@class DateViewController;
@interface SettingViewController : PopoverContentViewController<UITableViewDelegate, UITableViewDataSource>{
	UITableView *tableView;
	
	NSArray *sectionKeys;
	NSArray *settingSectionKeys;
	NSArray *sectionHeaders;
	
	CardSetting *setting;
	ColorChooseViewController *colorChooseVC;
	DateViewController *dateVC;
}

@property (nonatomic, strong) UITableView *tableView;

@end
