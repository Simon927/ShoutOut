//
//  TwitterClient.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "TwitterClient.h"

#import "OAConsumer.h"
#import "OADataFetcher.h"
#import "OAMutableURLRequest.h"
#import "OAToken.h"

// --- Defines ---;
// Constants;
static NSString * const kTwitterConsumerKey = @"Fnhl1JVD5lJDksweQs3Q";
static NSString * const kTwitterConsumerSecret = @"pgJ4nQ9JtyRaz8oL45PnP8irHETGqCgbOTcMK3tQ";
static NSString * const kTwitterRequestTokenURL = @"https://api.twitter.com/oauth/request_token";
static NSString * const kTwitterAuthorizeURL = @"https://api.twitter.com/oauth/authorize";
static NSString * const kTwitterAccessTokenURL = @"https://api.twitter.com/oauth/access_token";
static NSString * const kTwitterCallbackURL = @"http://mylol.net/callback";

// TwitterClient Class;
@interface TwitterClient ()

// Properties;
@property (nonatomic, strong) OAConsumer *consumer;
@property (nonatomic, strong) OAToken *requestToken;
@property (nonatomic, strong) OAToken *accessToken;

@end

@implementation TwitterClient

// Functions;
#pragma mark - Shared Functions
+ (instancetype)sharedClient
{
    static TwitterClient *_sharedClient;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TwitterClient alloc] init];
    });
    
    return _sharedClient;
}

#pragma mark - TwitterClient
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark - Token Request
- (void)tokenRequest
{
    NSURL *url = [NSURL URLWithString:kTwitterRequestTokenURL];
   
    // Request;
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url consumer:self.consumer token:nil realm:nil signatureProvider:nil];
    [request setHTTPMethod:@"POST"];

    // Parameters;
    OARequestParameter *parameter = [[OARequestParameter alloc] initWithName:@"oauth_callback" value:kTwitterCallbackURL];
    [request setParameters:@[parameter]];
    
    // Fetcher;
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request delegate:self didFinishSelector:@selector(tokenRequestTicket:data:) didFailSelector:@selector(tokenRequestTicket:error:)];
}

#pragma mark - Token Request
- (void)tokenRequestTicket:(OAServiceTicket *)ticket data:(NSData *)data
{
    if (ticket.didSucceed) {
        NSString* httpBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // Request Token;
        self.requestToken = [[OAToken alloc] initWithHTTPResponseBody:httpBody];
        
        // Authorize;
        [self tokenAuthorize];
    } else {
        // Failed;
        [self tokenRequestTicket:ticket error:nil];
    }
}

- (void)tokenRequestTicket:(OAServiceTicket *)ticket error:(NSError *)error
{
    if ([self.delegate respondsToSelector:nil]) {
//      [self.delegate ];
    }
}

#pragma mark - Token Authorize
- (void)tokenAuthorize
{
    NSURL* url = [NSURL URLWithString:kTwitterAuthorizeURL];
    
    // Request;
    OAMutableURLRequest* request = [[OAMutableURLRequest alloc] initWithURL:url consumer:nil token:nil realm:nil signatureProvider:nil];
    
    // Parameters;
    OARequestParameter* parameter = [[OARequestParameter alloc] initWithName:@"oauth_token" value:self.requestToken.key];
    [request setParameters:@[parameter]];
    
    // 
}

#pragma mark - Token Access
- (void)tokenAccess
{
    NSURL* url = [NSURL URLWithString:kTwitterAccessTokenURL];
    
    // Request;
    OAMutableURLRequest* request = [[OAMutableURLRequest alloc] initWithURL:url consumer:self.consumer token:self.requestToken realm:nil signatureProvider:nil];
    [request setHTTPMethod:@"POST"];
    
    // Parameters;
//  OARequestParameter* parameter = [[OARequestParameter alloc] initWithName:@"oauth_verifier" value:verifier];
//  [request setParameters:@[parameter]];
    
    // Fetcher;
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request delegate:self didFinishSelector:@selector(tokenAccessTicket:data:) didFailSelector:@selector(tokenAccessTicket:error:)];
}

- (void)tokenAccessTicket:(OAServiceTicket *)ticket data:(NSData *)data
{
    if (ticket.didSucceed) {
        
    } else {
        // Failed;
        [self tokenRequestTicket:ticket error:nil];
    }
}

- (void)tokenAccessTicket:(OAServiceTicket *)ticket error:(NSError *)error
{

}

- (BOOL)handleOpenURL:(NSURL *)url
{
    NSRange textRange = [url.absoluteString rangeOfString:[kTwitterCallbackURL lowercaseString]];
    
    if (textRange.location != NSNotFound) {
        NSString *verifier = nil;
        NSArray *parameters = [url.query componentsSeparatedByString:@"&"];
        
        for (NSString* parameter in parameters) {
            NSArray* keys = [parameter componentsSeparatedByString:@"="];
            NSString* key = keys[0];
            
            if ([key isEqualToString:@"oauth_verifier"]) {
                verifier = keys[1];
                break;
            }
        }
        
        if (verifier) {
        }
        
        return NO;
    }
    
    return YES;
}

@end
