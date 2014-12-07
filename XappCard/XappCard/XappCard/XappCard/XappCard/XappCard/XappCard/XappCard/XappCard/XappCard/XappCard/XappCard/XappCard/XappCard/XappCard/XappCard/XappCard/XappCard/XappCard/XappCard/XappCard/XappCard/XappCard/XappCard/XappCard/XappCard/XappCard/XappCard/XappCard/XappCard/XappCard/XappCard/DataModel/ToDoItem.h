//
//  ToDoItem.h
//  XappCard
//
//  Created by  on 20.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject<NSCoding>

@property (nonatomic) int day;
@property (nonatomic) int month;
@property (nonatomic) int year;
@property (nonatomic) int minute;
@property (nonatomic) int hour;
@property (nonatomic, strong) NSDate *sendDate;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventKey;

- (id)initWithName:(NSString*)name key:(NSString*)key;
@end
