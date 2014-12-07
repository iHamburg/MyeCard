//
//  TextLabelViewController.h
//  XappCard
//
//  Created by  on 09.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//


#import "PopoverContentViewController.h"
#import "FontScrollView.h"
#import "TextWidget.h"

@class TextLabelView;

@interface TextLabelViewController : PopoverContentViewController<UITextViewDelegate, UITableViewDataSource,UITableViewDelegate,MyColorPlatteDelegate,FontScrollViewDelegate>{
	
	NSMutableArray *fontNames;
	NSString *text;
	NSString *selectedFontName;
	UIColor *selectedColor;
	
	UITextView *textView;
	MyColorPlatteView *colorPlatteV;
	UISegmentedControl *textAlignSeg;
	UISwitch *strokeSwitch;
	UITableView *settingTV;
	UIBarButtonItem *textDoneBB, *addDoneBB;
	
	TextLabelView *textLabelView;
	FontScrollView *fontV;
	
	NSArray *tableKeys;
	
	float displayedFontSize;
	int mode; // 0: create, 1: edit , 2:cover
	
}

@property (nonatomic, assign) int mode;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) TextWidget *textWidget;

- (IBAction)textDone:(id)sender;

- (void)saveFontInformation;
- (void)restoreFontInformation;

- (void)editTextLabelView:(UIView*)textLabelView;



@end
