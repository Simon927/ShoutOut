//
//  AppDelegate.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <FacebookSDK/FacebookSDK.h>

#import "AppDelegate.h"

#import "Account.h"

#import "OBDragDrop.h"

// --- Defines ---;
// AppDelegate Class;
@implementation AppDelegate

// Functions;
#pragma mark - Shared Functions;
+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Status Bar;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    // Navigation Bar;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0f/255.0f green:60.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:17.0f]} forState:UIControlStateNormal];

    // DragDrop Manager;
    OBDragDropManager *manager = [OBDragDropManager sharedManager];
    [manager prepareOverlayWindowUsingMainWindow:self.window];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    static BOOL first = YES;
    
    if (first) {
        if (![[Account me] isAuthenticated]) {
            UINavigationController *navigationController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"SignNavigationController"];
            [self.window.rootViewController presentViewController:navigationController animated:NO completion:nil];
        }
        
        // Set;
        first = NO;
    }
    // Facebook;
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:[FBSession activeSession]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Facebook;
    [[FBSession activeSession] close];
}

- (BOOL)application:(UIApplication *) application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // Facebook;
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[FBSession activeSession]];
}

@end
