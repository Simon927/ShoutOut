//
//  TwitterClient.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Foundation/Foundation.h>

#import "TwitterViewController.h"

// --- Defines ---;
// TwitterClientDelegate Protocol;
@protocol TwitterClientDelegate <NSObject>

@optional

@end

// TwitterClient Class;
@interface TwitterClient : NSObject

// Properties;
@property (nonatomic, assign) id<TwitterClientDelegate> delegate;

// Shared Functions;
+ (instancetype)sharedClient;

// Functions;
- (void)tokenRequest;
- (void)tokenAuthorize;
- (void)tokenAccess;

@end
