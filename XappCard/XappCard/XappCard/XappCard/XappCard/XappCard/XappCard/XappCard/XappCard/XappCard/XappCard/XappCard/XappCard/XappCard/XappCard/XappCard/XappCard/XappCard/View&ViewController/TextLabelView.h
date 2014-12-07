//
//  TextLabelView.h
//  XappCard
//
//  Created by  on 16.01.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CardTextView.h"

@interface TextLabelView : CardTextView

- (void)setFontName:(NSString*)fontName color:(UIColor*)color;

- (void)heightAnpassenWithTransform;
@end
