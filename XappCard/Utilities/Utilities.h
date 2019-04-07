

#import "AppDelegate.h"

#import "Constant.h"
#import "Macros.h"

#import "UtilityViews.h"
#import "Manager.h"
#import "Category.h"

#import "Strings.h"
#import "Protocols.h"

#import "FBViewController.h" //Facebook
//#import "Flurry.h"  //Flurry

extern CGFloat _h,_w;
extern CGRect _r,_containerRect;

void saveArchived(id, NSString*);
id loadArchived(NSString*);

BOOL isPaid(void);


NSArray* getAllFontNames(void);

