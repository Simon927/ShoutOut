//
//  TwitterNavigationController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Classes ---;
@class TwitterNavigationController;

// --- Defines ---;
// TwitterNavigationControllerDelegate Protocol;
@protocol TwitterNavigationControllerDelegate <NSObject>

@optional
- (void)twitterController:(TwitterNavigationController *)controller didGetUserInfo:(NSDictionary *)userInfo;
- (void)twitterControllerDidCancel:(TwitterNavigationController *)controller;

@end

// TwitterNavigationController Class;
@interface TwitterNavigationController : UINavigationController

// Properties;
@property (nonatomic, assign) id<TwitterNavigationControllerDelegate> twitterDelegate;

@end
