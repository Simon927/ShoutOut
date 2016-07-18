//
//  MenuNavigationController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Classes ---;
@class REMenu;

// --- Defines ---;
// MenuNavigationController Class;
@interface MenuNavigationController : UINavigationController

// Properties;
@property (nonatomic, readonly, strong) REMenu *menu;

// Functions;
- (void)toggleMenu;

@end
