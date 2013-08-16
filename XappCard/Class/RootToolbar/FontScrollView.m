//
//  FontScrollView.m
//  MyeCard
//
//  Created by AppDevelopper on 02.11.12.
//
//

#import "FontScrollView.h"

@implementation FontScrollView

@synthesize fontNames ,delegate,selectedIndex;

- (void)setSelectedIndex:(int)_selectedIndex{
	selectedIndex = _selectedIndex;
	
	int page = selectedIndex/numLabelInPage;
	[scrollView setContentOffset:CGPointMake(w*page, 0)];
	pageControl.currentPage = page;
	
	UILabel *l = (UILabel*)[scrollView viewWithTag:selectedIndex+1];
	[selected setOrigin:CGPointMake(CGRectGetMaxX(l.frame)-15,CGRectGetMinY(l.frame) -5)];
	[scrollView addSubview:selected];
	
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		// 每一页25个label
		w = frame.size.width;
		h = frame.size.height-10;
		margin = 6;
		wLabel = (w-margin*(NumLabelInRow+1))/(NumLabelInRow);
		hLabel = (h-margin*(NumLabelInRow+1))/(NumLabelInRow);

		scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
		pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, h-3, w, 10)];
	
		scrollView.pagingEnabled = YES;
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.delegate = self;
		
		selected = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
		selected.image = [UIImage imageNamed:@"icon_selected.png"];
		self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		self.layer.cornerRadius = 5;
		
		[self addSubview:scrollView];
		[self addSubview:pageControl];
    }
    return self;
}

- (void)setup{
	//vordefiniert: fontNames
	
	numLabelInPage = NumLabelInRow *NumLabelInRow;
	numPages = [fontNames count]/numLabelInPage +1;
	pageControl.numberOfPages = numPages;
//	NSLog(@"num pages:%d",numPages);
	
	for (int i = 0; i<[fontNames count]; i++) {
		int page = i/numLabelInPage;
//		NSLog(@"i:%d,page:%d",i,page);
		int indexOfPage = i%numLabelInPage;
		UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(w*page + margin+(indexOfPage%NumLabelInRow)*(wLabel+margin), margin+(indexOfPage/NumLabelInRow)*(hLabel+margin), wLabel, hLabel)];
		l.backgroundColor = [UIColor whiteColor];
		l.userInteractionEnabled = YES;
		l.tag = i+1;
		l.text = FontDisplayString;
		l.font = [UIFont fontWithName:fontNames[i] size:hLabel/2.2];
		l.textAlignment = NSTextAlignmentCenter;
		l.textColor = [UIColor orangeColor];
		[l addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)]];
		l.layer.cornerRadius = 3;
		l.shadowColor = [UIColor colorWithWhite:0 alpha:0.44];
		l.shadowOffset = CGSizeMake(0, 1);

		
		[scrollView addSubview:l];
		
	}

	scrollView.contentSize = CGSizeMake(w*numPages, 0);

}

- (void)handleTap:(UITapGestureRecognizer*)tap{
	UILabel *l = (UILabel*)[tap view];
	int index = l.tag-1;
	[selected setOrigin:CGPointMake(CGRectGetMaxX(l.frame)-15,CGRectGetMinY(l.frame) -5)];
	[scrollView addSubview:selected];

	[delegate fontScrollViewDidSelectedIndexOfFont:index];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
	L();
	CGFloat xOffset = scrollView.contentOffset.x;
	int pageNum = xOffset/w;
//	NSLog(@"xOffset:%f",xOffset);
	pageControl.currentPage = pageNum;
}
@end
