//
//  Region.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Foundation/Foundation.h>

// --- Defines ---;
// Region Class;
@interface Region : NSObject

// Properties;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, strong) NSNumber *regionId;
@property (nonatomic, strong) NSString *region;

// Functions;
- (id)initWithAttributes:(NSString *)attributes;

@end
