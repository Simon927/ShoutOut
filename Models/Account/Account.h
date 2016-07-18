//
//  Account.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Foundation/Foundation.h>

// --- Defines ---;
// Account Class;
@interface Account : NSObject

// Properties;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;

// Shared Functions;
+ (instancetype)me;

// Functions;
- (BOOL)isAuthenticated;
- (void)logout;

@end
