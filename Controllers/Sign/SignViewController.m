//
//  SignViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "SignViewController.h"

// --- Defines ---;
// SignViewController Class;
@implementation SignViewController

// Functions;
#pragma mark - SignViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation Bar;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Navigation Bar;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // Navigation Bar;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
