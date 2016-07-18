//
//  TwitterViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "TwitterNavigationController.h"
#import "TwitterViewController.h"

#import "TwitterClient.h"

// --- Defines ---;
// Constants;
static NSString * const kTwitterCallbackURL = @"http://www.mylol.net";

// TwitterViewController Class;
@interface TwitterViewController ()

@end

@implementation TwitterViewController

// Functions;
#pragma mark - TwitterViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load;
    [self getAuthorizeURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSRange range = [url.absoluteString rangeOfString:[kTwitterCallbackURL lowercaseString]];
    
    if (range.location != NSNotFound) {
        NSString *verifier = nil;
        NSArray *parameters = [url.query componentsSeparatedByString:@"&"];
        
        for (NSString *parameter in parameters) {
            NSArray *keys = [parameter componentsSeparatedByString:@"="];
            NSString *key = keys[0];
            
            if ([key isEqualToString:@"oauth_verifier"]) {
                verifier = keys[1];
                break;
            }
        }
        
        if (verifier) {
            [self getAccessToken:verifier];
        }
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - Get
- (void)getAuthorizeURL
{
    [[TwitterClient sharedClient] getAuthorizeURL:^(NSURL *url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // Load Request;
        [viewTwitter loadRequest:request];
    } failed:^(NSError *error) {
         [self didCancel];       
    }];
}

- (void)getAccessToken:(NSString *)verifier
{
    [[TwitterClient sharedClient] getAccessTokenWithPin:verifier success:^() {
        [self getUserInfo];
    } failed:^(NSError *error) {
        [self didCancel];
    }];
}

- (void)getUserInfo
{
    [[TwitterClient sharedClient] getUserInfo:^(NSDictionary *user) {
        [self didLogin:user];
    } failed:^(NSError *error) {
        [self didCancel];
    }];
}

#pragma mark - Result
- (void)didLogin:(NSDictionary *)userInfo
{
    TwitterNavigationController *controller = (TwitterNavigationController *)self.navigationController;
    
    // Cancel;
    if ([controller.twitterDelegate respondsToSelector:@selector(twitterController:didGetUserInfo:)]) {
        [controller.twitterDelegate twitterController:controller didGetUserInfo:userInfo];
    }
}

- (void)didCancel
{
    TwitterNavigationController *controller = (TwitterNavigationController *)self.navigationController;
    
    // Cancel;
    if ([controller.twitterDelegate respondsToSelector:@selector(twitterControllerDidCancel:)]) {
        [controller.twitterDelegate twitterControllerDidCancel:controller ];
    }
}

#pragma mark - Events
- (IBAction)onBtnCancel:(id)sender
{
    [self didCancel];
}

@end
