//
//  TextLabelViewController.m
//  XappCard
//
//  Created by  on 09.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "TextLabelViewController.h"
#import "TextLabelView.h"
#import "CoverTextLabelView.h"


@implementation TextLabelViewController

@synthesize text,mode, textWidget;

#pragma mark - View lifecycle

- (void)setTextWidget:(TextWidget *)_textWidget{
	textWidget = _textWidget;
	
	textView.text = textWidget.text;
	textView.textColor = textWidget.textColor;
//	NSString *name = textWidget.font.fontName;
	textView.font = [UIFont fontWithName:textWidget.fontName size:displayedFontSize];
	
	NSLog(@"textwidget # %@,textview.font # %@",textWidget,textView.font);
	
	textView.textAlignment = textWidget.textAlignment;

	selectedFontName = textWidget.fontName;
	int nameInt = [fontNames indexOfObject:textWidget.fontName];
	
	fontV.selectedIndex = nameInt;
	
	strokeSwitch.on = textWidget.strokeColor?YES:NO;
	
	if (textWidget.textAlignment == NSTextAlignmentLeft) {
		textAlignSeg.selectedSegmentIndex = 0;
	}
	else if(textWidget.textAlignment == NSTextAlignmentCenter){
		textAlignSeg.selectedSegmentIndex = 1;
	}
	else if(textWidget.textAlignment == NSTextAlignmentRight){
		textAlignSeg.selectedSegmentIndex = 2;
	}
	
}


- (void)loadView
{

	CGRect rect = CGRectMake(0, 0, 480, 288);
	CGRect containerRect = CGRectMake(0, 0, 480, 288);
	if(isPhoneRetina4){
		rect = CGRectMake(0, 0, 568, 288);
		containerRect = CGRectMake(44, 0, 480, 320);
	}
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.backgroundColor = [UIColor blackColor];
	self.title = NSLocalizedString(@"TextLabelTitel", nil);
	displayedFontSize = 16;

	
	NSArray *array = [UIFont familyNames];
	
	NSString *familyName ;
	
	fontNames = [NSMutableArray array];
	for(familyName in array)
	{
		
		[fontNames addObject:familyName];
	}
	
	[fontNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	UIView *container = [[UIView alloc]initWithFrame:containerRect];

	
	self.view.backgroundColor = [UIColor blackColor];
	
	// Navi
	if (!isPad) {  // iphone
		textDoneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textDone:)];
		addDoneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(done:)];
		self.navigationItem.rightBarButtonItem = nil;
	}
	
	// Subview
	settingTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 230, 90) style:UITableViewStyleGrouped];
	settingTV.delegate = self;
	settingTV.dataSource = self;
	settingTV.backgroundColor = [UIColor clearColor];
	settingTV.backgroundView = nil;
	settingTV.scrollEnabled = NO;
	
	tableKeys = @[@"Text",@"Font outline"];
	
	NSArray *imgNames = @[@"icon_alignLeft.png",@"icon_alignCenter.png",@"icon_alignRight.png"];
	
	NSMutableArray *imgs = [NSMutableArray array];
	for (NSString *imgName in imgNames) {
		UIImage *img = [UIImage imageNamed:imgName];

		[imgs addObject:img];
		
	}
	textAlignSeg= [[UISegmentedControl alloc]initWithItems:imgs];
	textAlignSeg.frame = CGRectMake(0, 0, 120, 30);
	[textAlignSeg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
	
	
	strokeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];

	
	colorPlatteV = [[MyColorPlatteView alloc] initWithFrame:CGRectMake(10, 100, 215, 188)];
	colorPlatteV.delegate = self;
	
	textView = [[UITextView alloc] initWithFrame:CGRectMake(250, 10, 220, 100)];
	textView.backgroundColor = [UIColor whiteColor];
	textView.layer.cornerRadius = 5;
	textView.layer.masksToBounds = YES;
	[textView setAutocorrectionType:UITextAutocorrectionTypeNo];
	textView.delegate = self;
	
	fontV = [[FontScrollView alloc]initWithFrame:CGRectMake(240, 120, 240, 170)];
	fontV.delegate = self;
	fontV.fontNames = fontNames;
	[fontV setup];
	
	[container addSubview:settingTV];
	[container addSubview:colorPlatteV];
	[container addSubview:textView];
	[container addSubview:fontV];
	
	[self.view addSubview:container];


	[self restoreFontInformation];
	
	

}


- (void)viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];
	[textView becomeFirstResponder];
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	
    return [tableKeys count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//	int section = [indexPath section];
	int row = [indexPath row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	cell.textLabel.text = [tableKeys objectAtIndex:row];
	
	if (row == 0) {
		cell.accessoryView = textAlignSeg;
	}
	else if(row == 1){
		cell.accessoryView = strokeSwitch;
	}
	
	return cell;
	
}





#pragma mark - TextView
- (void)textViewDidBeginEditing:(UITextView *)_textView{
	L();

//	_textView.textColor = selectedColor;
	if (!isPad) {
		self.navigationItem.rightBarButtonItem = textDoneBB;

	}
}

#pragma mark - ColorPlatte
- (void)colorPlatte:(MyColorPlatteView *)v didTapColor:(UIColor *)color{
	selectedColor = color;
	textView.textColor = color;
}

#pragma mark - FontScrollView

- (void)fontScrollViewDidSelectedIndexOfFont:(int)index{
	NSLog(@"index:%d",index);
	
	UIFont *font;
	
	selectedFontName = [fontNames objectAtIndex:index];
	
	
    font = [UIFont fontWithName:selectedFontName size:isPad?20:20];
	
	//  [rootVC setFont:font];
	textView.font = font;
}

#pragma mark - Segment
- (IBAction)segmentValueChanged:(UISegmentedControl*)sender{
	
	int index = sender.selectedSegmentIndex;
	if (sender == textAlignSeg) {
		if (index == 0) {
			textView.textAlignment = NSTextAlignmentLeft;
		}
		else if(index == 1){
			textView.textAlignment = NSTextAlignmentCenter;
		}
		else if (index == 2){
			textView.textAlignment = NSTextAlignmentRight;
		}

	}
}

#pragma mark - Navi
- (void)cancel:(id)sender{
	[super cancel:nil];
	self.mode = 0;
	self.text = @"";
}

- (void)done:(id)sender{
	
	CGFloat originalFontSize = textWidget.font.pointSize;
	
	textWidget.text = textView.text;
	textWidget.textColor = textView.textColor;
	textWidget.font = [UIFont fontWithName:textView.font.fontName size:displayedFontSize];
	textWidget.textAlignment = textView.textAlignment;
    textWidget.fontName = selectedFontName;
	
	if (strokeSwitch.on) {
		textWidget.strokeColor = [UIColor whiteColor];
	}
	else{
		textWidget.strokeColor = nil;
	}
	
	//  现在fontsize 30的时候确定textwidget的bounds和faktor，然后扩大font和bounds！
	//
	CGSize sizeWith30 = [textWidget sizeThatFits:CGSizeMake(textView.bounds.size.width, 100000)];
	
	textWidget.fontSizeFaktor = displayedFontSize/sizeWith30.width;
	
	CGFloat enhanceFaktor = originalFontSize/displayedFontSize;
	
	textWidget.bounds = CGRectMake(0, 0, sizeWith30.width*enhanceFaktor, sizeWith30.height*enhanceFaktor);
	
	textWidget.font = [UIFont fontWithName:textView.font.fontName size:originalFontSize];
	

	
	if ([[Controller sharedController]rootMode] == RootModeCover) {
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:NotifiCoverAddZettel object:[NSArray arrayWithObject:textWidget]];
	}
	else if([[Controller sharedController]rootMode] == RootModeContent){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:NotifiContentAddZettel object:[NSArray arrayWithObject:textWidget]];

	}


	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiRootDismiss object:nil];
}

- (IBAction)textDone:(id)sender{
	
	[textView resignFirstResponder];
	self.navigationItem.rightBarButtonItem = addDoneBB;
	
}


- (void)saveFontInformation{
	
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:selectedColor];
	[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TextLabelColor"];
	[[NSUserDefaults standardUserDefaults] setObject:selectedFontName forKey:@"TextLabelFontName"];
	
}

- (void)restoreFontInformation{
	
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"TextLabelColor"];
	if (ISEMPTY(data)) {
		selectedColor = [UIColor colorWithHEXString:@"855b27"];
		selectedFontName = @"Chalkboard SE";
	}
	else{
		selectedColor = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		selectedFontName = [[NSUserDefaults standardUserDefaults] objectForKey:@"TextLabelFontName"];

	}
}

- (void)editTextLabelView:(TextLabelView*)_textLabelView{

	
	text = _textLabelView.text;
	selectedFontName = _textLabelView.fontName;
	selectedColor = _textLabelView.color;
	textLabelView = _textLabelView;
	mode = 1;
	
}
@end
