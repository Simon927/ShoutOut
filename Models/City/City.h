//
//  City.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Foundation/Foundation.h>

// --- Defines ---;
// City Class;
@interface City : NSObject

// Properties;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSNumber *provinceID;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSNumber *countryID;
@property (nonatomic, strong) NSString *country;

// Functions;
- (instancetype)initWithAttributes:(NSString *)attributes;

@end
