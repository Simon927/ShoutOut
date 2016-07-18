//
//  TwitterClient.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Foundation/Foundation.h>

// --- Defines ---;
// TwitterClient Class;
@interface TwitterClient : NSObject

// Shared Functions;
+ (instancetype)sharedClient;

// Functions;
- (void)getAuthorizeURL:(void(^)(NSURL *url))success failed:(void(^)(NSError *error))failed;
- (void)getAccessTokenWithPin:(NSString *)pin success:(void(^)())success failed:(void(^)(NSError *error))failed;
- (void)getUserInfo:(void(^)(NSDictionary *user))success failed:(void(^)(NSError *error))failed;

@end
