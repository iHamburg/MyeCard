//
//  MEInstructionViewController.m
//  MyeCard
//
//  Created by AppDevelopper on 13-10-9.
//
//

#import "MEInstructionViewController.h"

@implementation MEInstructionViewController

- (void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    
    numOfPages = 6;
    
    for (int i = 0; i<6; i++) {
        UIImage *img = [[SpriteManager sharedInstance] instructionImageWithIndex:i];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(_w * i, 0, _w, _h)];
        imgV.image = img;
        [scrollView addSubview:imgV];
        [scrollView setContentSize:CGSizeMake(CGRectGetMaxX(imgV.frame), 0)];
    }
    
    pageControl.numberOfPages = 6;
}

@end
