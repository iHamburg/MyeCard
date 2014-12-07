//
//  LRootViewController.m
//  iCamAlbum
//
//  Created by AppDevelopper on 13-10-11.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "LRootViewController.h"

@interface LRootViewController ()

@end

@implementation LRootViewController
- (void)loadView{
    L();
    [super loadView];
    
    _r = [UIScreen mainScreen].bounds;
    
    if (!isIOS8) { // iOS8 之前的版本都要转一下
        _r = CGRectApplyAffineTransform(_r, CGAffineTransformMakeRotation(90 * M_PI / 180.0));
    }
    

	_r.origin = CGPointZero;
	self.view = [[UIView alloc]initWithFrame:_r];
    
    _w = _r.size.width;
    _h = _r.size.height;
    
	_containerRect = _r;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (NSUInteger)supportedInterfaceOrientations{
    
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}


@end
