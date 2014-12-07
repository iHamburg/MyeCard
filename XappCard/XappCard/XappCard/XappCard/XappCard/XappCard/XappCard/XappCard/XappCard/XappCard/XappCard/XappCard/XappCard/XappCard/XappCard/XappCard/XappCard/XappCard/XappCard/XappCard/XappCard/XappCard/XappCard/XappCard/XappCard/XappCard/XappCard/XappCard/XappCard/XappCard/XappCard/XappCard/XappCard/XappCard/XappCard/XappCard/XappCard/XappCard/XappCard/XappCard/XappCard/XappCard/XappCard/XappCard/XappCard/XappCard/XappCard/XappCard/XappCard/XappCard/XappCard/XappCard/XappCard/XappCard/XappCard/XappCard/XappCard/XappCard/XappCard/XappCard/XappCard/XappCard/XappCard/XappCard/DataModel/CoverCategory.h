//
//  CoverCategory.h
//  MyeCard
//
//  Created by AppDevelopper on 09.01.13.
//
//

#import <Foundation/Foundation.h>

@interface CoverCategory : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *coverImgNames;
@property (nonatomic, strong) NSString *iapKey;
@property (nonatomic, assign) BOOL available;

-(NSString *)coverImgNameWithIndex:(int)index;

- (int)numOfCovers;

@end
