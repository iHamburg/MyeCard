//
//  SettingViewController.m
//  XappCard
//
//  Created by  on 27.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "SettingViewController.h"
#import "ContentViewController.h"
#import "CardSetting.h"
#import "DateViewController.h"

@implementation SettingViewController

@synthesize tableView;

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	L();
	
	sectionKeys = [NSArray arrayWithObjects:[NSArray arrayWithObjects:NSLocalizedString(@"Border", nil),NSLocalizedString(@"Border Color", nil),LString(@"Shadow"), nil], 
				   [NSArray arrayWithObjects:LString(@"Cover"),LString(@"Inside"),LString(@"Profile"), nil],
				   nil];
	settingSectionKeys = [NSArray arrayWithObjects:[NSArray arrayWithObjects:kSettingFrameEnabled,kSettingFrameColor,kSettingShadowEnabled, nil], 
						  [NSArray arrayWithObjects:kSettingCoverEnabled,kSettingInsideEnabled, kSettingProfileEnabled, nil],nil];
	
	setting = rootVC.card.setting;
	
	sectionHeaders = [NSArray arrayWithObjects:LString(@"Photo Properties"),LString(@"Card Properties"),nil];
	
	
	CGRect rect = CGRectMake(0, 0, 480, 320);

	if(!isPhone4 && isPhone){
		rect = CGRectMake(0, 0, 568, 320);

	}
	self.view = [[UIView alloc] initWithFrame:rect];

	
	tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

//    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	
	tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	tableView.dataSource = self;
	tableView.delegate = self;
	
	
	[self.view addSubview:tableView];

	
	self.contentSizeForViewInPopover = self.view.bounds.size;
	
	self.navigationItem.leftBarButtonItem = nil;

	self.title = NSLocalizedString(@"Settings", nil);
}




- (void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:animated];
	
	L();
	setting = rootVC.card.setting;
	
	colorChooseVC = [[ColorChooseViewController alloc] init];
	colorChooseVC.setting = setting;
	colorChooseVC.view.frame = self.view.frame;
	colorChooseVC.view.alpha = 1;
	
	[tableView reloadData];
	
	
}

- (void)viewDidAppear:(BOOL)animated{
    L();
    [super viewDidAppear:animated];
    
    NSLog(@"tableview # %@",tableView);
}

- (void)viewDidDisappear:(BOOL)animated{
	L();
	[super viewDidDisappear:animated];
	
	if (setting.coverEnable + setting.insideEnable == 0) {
		NSLog(@"cover and inside set to enable");
		setting.coverEnable = YES;
		setting.insideEnable = YES;
	}
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return [sectionKeys count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [sectionHeaders objectAtIndex:section];
//    return @"abc";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (kVersion >= 7.0) {
//        return 45.0;
//    }
//    else{
//        return []
//    }
    if (kVersion>=7.0) {
        return 0;
    }
    else
        return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSArray *keys = [sectionKeys objectAtIndex:section];
    return [keys count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	int section = [indexPath section];
	int row = [indexPath row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

	
	NSString *key = [[sectionKeys objectAtIndex:section] objectAtIndex:row];
	
	NSString *settingKey;
	if (section<2) {
		 settingKey = [[settingSectionKeys objectAtIndex:section] objectAtIndex:row];
	}

	
	cell.textLabel.text = key;
	
	//click doens't turn blue
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	
	if (row == 1 && section == 0) {
		UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
		[v addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
		
		v.backgroundColor = setting.frameColor;
		
		v.layer.cornerRadius = 5;
		v.layer.masksToBounds = YES;
		cell.accessoryView = v;
	}
	else if(section<2){
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		cell.accessoryView = switchView;
		
		BOOL switchValue = [[setting valueForKey:settingKey] boolValue];
		
		[switchView setOn:switchValue animated:NO];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[switchView setTag:section*10+row];
	}
	
	return cell;
	
}


#pragma mark -

- (void) switchChanged:(id)sender {
	
	UISwitch* switchControl = sender;
	NSString *string = [NSString stringWithInt:switchControl.on];
	NSLog(@"switch.tag:%d",switchControl.tag);
	
	switch (switchControl.tag) {
		case 0: // border
			
			[[NSNotificationCenter defaultCenter] postNotificationName:NotifiPictureSetFrameEnabled object:string];	
			//			[setting setObject:string forKey:kSettingFrameEnabled];
			setting.frameEnable = switchControl.on;
			break;
		case 2: // shadow
			
			//			[setting setObject:string forKey:kSettingShadowEnabled];
			setting.shadowEnable = switchControl.on;
			[[NSNotificationCenter defaultCenter] postNotificationName:NotifiPictureSetShadowEnabled object:string];
			break;
		case 10: //cover
			//			[setting setObject:string forKey:kSettingCoverEnabled];
			setting.coverEnable = switchControl.on;
			if (!setting.insideEnable && !setting.coverEnable) {
				setting.insideEnable = YES;
				[tableView reloadData];
			}
			break;
		case 11: //inside
			//			[setting setObject:string forKey:kSettingCoverEnabled];
			setting.insideEnable = switchControl.on;
			if (!setting.insideEnable && !setting.coverEnable) {
				setting.coverEnable = YES;
				[tableView reloadData];
			}
			
			break;
		case 12: //profile
			setting.profileEnable = switchControl.on;
			[[NSNotificationCenter defaultCenter] postNotificationName:NotifiPictureSetProfileEnabled object:string];
			break;
		case 20: // reminder me
			if (switchControl.on) { // open dateVC
				[self.navigationController pushViewController:dateVC animated:YES];
			}
			else { // close it
				rootVC.card.notification = nil;
				[tableView reloadData];
			}
		default:
			break;
	}
	
	
}


- (void)handleTap:(UITapGestureRecognizer*)gesture{
	//	L();

	[self.navigationController pushViewController:colorChooseVC animated:YES];

}

@end
