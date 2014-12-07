//
//  Constant.h
//  My eCard
//
//  Created by AppDevelopper on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#pragma mark - Network

#ifdef DEBUG

#define kServerAddress @"http://localhost/xappsoft/testMoreApp.php"


#else

#endif

#pragma mark - IAP

#ifdef IAP  //Free


#define kApplink @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=540321553&mt=8"
#define kIAPAnniversary @"de.xappsoft.myecardfree.anniversary"
#define kIAPValentine @"de.xappsoft.myecardfree.valentine2013" 
#define kAppID @"540321553"

#else   //Pro

#define kApplink @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=495584349&mt=8"
#define kIAPAnniversary @"de.xappsoft.myecardpro.anniversary"

#define kIAPValentine @"de.xappsoft.myecardpro.valentine2013"
#define kAppID @"495584349"

#endif

#define kAppName @"My eCard"
#define kIAPFullVersion @"de.xappsoft.myecardfree.newfullversion"


#define dataFile @"data.plist"
#define kCardFileName @"card"
#define kAppSettingName @"AppSettingFile"

#define MAXPICKEDPHOTO  10


#pragma mark - ViewTag

#define kContentTextLabelTag 124


#define ROOTTOOLBARTAG 12

#pragma mark - Setting

#define kSettingFrameEnabled @"frameEnable"
#define kSettingShadowEnabled @"shadowEnable"
#define kSettingFrameColor @"frameColor"
#define kSettingCoverEnabled @"coverEnable"
#define kSettingInsideEnabled @"insideEnable"
#define kSettingProfileEnabled @"profileEnable"

#pragma mark - Notification

#define NotifiRootDismiss @"dismiss"
#define NotifiRootOpenTextLabelVC @"openTextLabel"  // object is string, font name, color?

#define NotifiRootPickProfile @"pickProfile"

#define NotifiCoverAddZettel @"addcoverZettel"  // object is array of uiview

#define NotifiAddPicture @"addPicture"        // object is array of image
#define NotifiContentAddZettel @"addZettel"  // object is array of uiview
#define NotifiContentLoadEditView @"loadEditView" //array of Picture

#define NotifiPictureChangeFrameColor @"changeFrameColor"  // object:color
#define NotifiPictureSetFrameEnabled @"setFrame" //object "0" or "1"
#define NotifiPictureSetShadowEnabled @"shadowEnabled" //object '0' or '1'
#define NotifiPictureSetProfileEnabled @"profileEnabled" //object '0' or '1'


#pragma mark - Universal UI

#define kUniversalFaktor isPad?1:2

#define kSize960 isPad?CGSizeMake(960,640):CGSizeMake(480,320)
#define kUIContainerFrame isPad?CGRectMake(0,0,960,640):CGRectMake(0,0,480,320)

#define ROOTZETTELFRAME isPad?CGRectMake(0,0,480,500):CGRectMake(0,0,480,276)
#define ROOTTEXTLABELFRAME CGRectMake(0,0,480,276)

#define PNGKARTEFRAME CGRectMake(0,0,960,1280)
#define PNGCOVERFRAME CGRectMake(0,0,960,640)
#define PNGCOVERSIZE  CGSizeMake(960,640)



#define CORNERRADIUS 20


#define PopPhotoWidth isPad?320:600
#define PopPhotoHeight isPad?500:500

#define POPCoverPhotoWidth isPad?320:600



#pragma mark - 

#define kVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define AUTORESIZINGMASK UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin

#define kKeyFirstOpen @"firstOpen"
#define kKeyUpdate    @"update"
#define kKeyBundleVersion @"bundleVersion"

#ifdef DEBUG


#define kHost @"http://dev.thebootic.com/cgi-bin/search/"
#define kPicHost @"http://dev.thebootic.com"
#define kAboutAddress @"http://dev.thebootic.com/_AboutUs"


#else

#define kHost @"http://dev.thebootic.com/cgi-bin/search/"
#define kPicHost @"http://dev.thebootic.com"

#endif


#pragma mark - Property




typedef enum{
    ST_Cover,
    ST_Content
    
} ScreenshotType;

typedef enum{
    RSCover,
    RSContent,
    RSPreview
}RootStatus;

typedef enum {
	RAF_None,
	RAF_Action,
	RAF_Image
}RootActionFlag;

typedef enum{
    RPSCover,
    RPSProfile,
    RPSContent
} RootPhotoSource;

typedef enum {
	MA_Lock,
	MA_Unlock,
	MA_SetBG,
	MA_Edit
} MenuAction;

typedef enum{
	RootModeChoose,
	RootModeCover,
	RootModeContent,
	RootModeCards,
	RootModeCardsDate
}RootMode;

typedef enum{
	AppVersionPaid,
	AppVersionIAP,
	AppVersionFree
}AppVersion;


typedef enum{
	PS_None,
	PS_Text,
	PS_TextLabel,
	PS_Image,
	PS_OneImage,
	PS_Zettel,
	PS_Sticker,
	PS_Love,
	PS_Setting,
	PS_Info,
	PS_Action,
	PS_Cards,
	PS_SendLater,
	RootVCStatusRateAlert,
	RootVCStatusNewCardAlert
} PopOverStatus;

typedef enum{
	ToolbarTagAdd,
	ToolbarTagSwitch,
	ToolbarTagCoverPhoto,
	ToolbarTagCoverText,
	ToolbarTagChooseCover,
	ToolbarTagInfo,
	ToolbarTagContentPhoto,
	ToolbarTagContentText,
	ToolbarTagZettel,
	ToolbarTagLove,
	ToolbarTagAction,
	ToolbarTagSetting,
	
}ToolbarTag;
