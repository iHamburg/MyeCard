//
//  TextLabelViewController.m
//  XappCard
//
//  Created by  on 09.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "TextLabelViewController.h"
//#import "TextLabelView.h"
#import "Category.h"


@implementation TextLabelViewController

@synthesize text,mode, textWidget;

#pragma mark - View lifecycle

- (void)setTextWidget:(TextWidget *)_textWidget{
	textWidget = _textWidget;
	
	textView.text = textWidget.text;
	textView.textColor = textWidget.textColor;
//	NSString *name = textWidget.font.fontName;
	textView.font = [UIFont fontWithName:textWidget.fontName size:displayedFontSize];
	
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


- (void)loadFontNames
{
    NSArray *array = [UIFont familyNames];
	
	NSString *familyName ;
	
	fontNames = [NSMutableArray array];
	for(familyName in array)
	{
		
		[fontNames addObject:familyName];
	}
	
	[fontNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)loadTextAlignSeg
{
    NSArray *imgNames = @[@"icon_alignLeft.png",@"icon_alignCenter.png",@"icon_alignRight.png"];
	
	NSMutableArray *imgs = [NSMutableArray array];
	for (NSString *imgName in imgNames) {
		UIImage *img = [UIImage imageNamed:imgName];
        
		[imgs addObject:img];
		
	}
	textAlignSeg= [[UISegmentedControl alloc]initWithItems:imgs];
	textAlignSeg.frame = CGRectMake(0, 0, 120, 30);
	[textAlignSeg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)loadView
{
    [self loadFontNames];

     CGFloat h = 320;
	CGRect rect = CGRectMake(0, 0, 480, h);
	CGRect containerRect = CGRectMake(0, 0, 480, h);
	
    if(isPhoneRetina4){
		rect = CGRectMake(0, 0, 568, h);
		containerRect = CGRectMake(44, 0, 480, h);
	}
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.backgroundColor = [UIColor blackColor];
	self.title = NSLocalizedString(@"TextLabelTitel", nil);
    
	displayedFontSize = 16;

	UIView *container = [[UIView alloc]initWithFrame:containerRect];
	
	// Navi
	if (!isPad) {  // iphone
		textDoneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textDone:)];
		addDoneBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(done:)];
		self.navigationItem.rightBarButtonItem = nil;
	}
	
	// Subview
    CGFloat hSettingTv = 90;

	settingTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 230, hSettingTv) style:UITableViewStyleGrouped];
	settingTV.delegate = self;
	settingTV.dataSource = self;
	settingTV.backgroundColor = [UIColor clearColor];
	settingTV.backgroundView = nil;
	settingTV.scrollEnabled = NO;
	
//	tableKeys = @[@"Text",@"Font outline"];
    colorPlatteV = [[MyColorPlatteView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(settingTV.frame)+5, 215, 188)];
	colorPlatteV.delegate = self;
    
    if (kVersion >= 7.0) {
        tableKeys = @[@"Text"];
    }
    else{
        tableKeys = @[@"Text",@"Font outline"];
    }
    
	[self loadTextAlignSeg];
	
	strokeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];

	
    CGFloat yTV = 10;

	textView = [[UITextView alloc] initWithFrame:CGRectMake(250, yTV, 220, 100)];
	textView.backgroundColor = [UIColor whiteColor];
	textView.layer.cornerRadius = 5;
	textView.layer.masksToBounds = YES;
	[textView setAutocorrectionType:UITextAutocorrectionTypeNo];
	textView.delegate = self;
	
	fontV = [[FontScrollView alloc]initWithFrame:CGRectMake(240, CGRectGetMaxY(textView.frame)+5, 240, 170)];
	fontV.delegate = self;
	fontV.fontNames = fontNames;
	[fontV setup];
	
	[container addSubview:settingTV];
	[container addSubview:colorPlatteV];
	[container addSubview:textView];
	[container addSubview:fontV];
	
	[self.view addSubview:container];


	[self restoreFontInformation];
	
    L();
    
    NSLog(@"textVC # %@, nav # %@",self.view,self.navigationController.view);
	

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (isPhone && (kVersion>=7.0)) {

        [colorPlatteV setOrigin:CGPointMake(10, CGRectGetMaxY(settingTV.frame)+5)];
        [textView setOrigin:CGPointMake(250, 42)];
        [fontV setOrigin:CGPointMake(240, CGRectGetMaxY(textView.frame)+5)];
    }
    
//    NSLog(@"fontV # %@",fontV);
    [textView becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];
	
    
}



#pragma mark -
#pragma mark Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
//    return 1;
    if (kVersion>=7.0) {
        return 1;
    }
    else
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

	
//	text = _textLabelView.text;
//	selectedFontName = _textLabelView.fontName;
//	selectedColor = _textLabelView.color;
	textLabelView = _textLabelView;
	mode = 1;
	
}
@end
