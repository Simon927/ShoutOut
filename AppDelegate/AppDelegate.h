//
//  AppDelegate.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// AppDelegate Class;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

// Properties;
@property (strong, nonatomic) UIWindow *window;

// Shared Functions;
+ (AppDelegate *)sharedDelegate;

@end
