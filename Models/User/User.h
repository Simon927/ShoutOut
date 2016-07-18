//
//  User.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Foundation/Foundation.h>

// --- Defines ---;
// User Class;
@interface User : NSObject

// Properties;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *web;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *show;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *regIdentifier;

// Functions;
- (id)initWithAttributes:(NSDictionary *)attributes;

@end
