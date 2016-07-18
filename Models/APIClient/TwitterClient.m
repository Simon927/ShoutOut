//
//  TwitterClient.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "TwitterClient.h"

#import "STTwitter.h"

// --- Defines ---;
// Constants;
static NSString * const kTwitterConsumerKey = @"Fnhl1JVD5lJDksweQs3Q";
static NSString * const kTwitterConsumerSecret = @"pgJ4nQ9JtyRaz8oL45PnP8irHETGqCgbOTcMK3tQ";
static NSString * const kTwitterRequestTokenURL = @"https://api.twitter.com/oauth/request_token";
static NSString * const kTwitterCallbackURL = @"http://www.mylol.net";

// TwitterClient Class;
@interface TwitterClient ()

// Properties;
@property (nonatomic, strong) STTwitterAPI *twitter;
@property (nonatomic, strong) NSString *screenName;

@end

@implementation TwitterClient

#pragma mark - Shared Client
+ (instancetype)sharedClient
{
    static TwitterClient *_sharedClient;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TwitterClient alloc] init];
        _sharedClient.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
    });
    
    return _sharedClient;
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)getAuthorizeURL:(void(^)(NSURL *url))success failed:(void(^)(NSError *error))failed
{
    [self.twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        if (success) {
            success(url);
        }
    } authenticateInsteadOfAuthorize:NO forceLogin:@(YES) screenName:nil oauthCallback:kTwitterCallbackURL errorBlock:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)getAccessTokenWithPin:(NSString *)pin success:(void(^)())success failed:(void(^)(NSError *error))failed
{
    [self.twitter postAccessTokenRequestWithPIN:pin successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        self.screenName = screenName;
        
        if (success) {
            success();
        }
    } errorBlock:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)getUserInfo:(void(^)(NSDictionary *user))success failed:(void(^)(NSError *error))failed
{
    [self.twitter getUserInformationFor:self.screenName successBlock:^(NSDictionary *user) {
        if (success) {
            success(user);
        }
    } errorBlock:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

@end
