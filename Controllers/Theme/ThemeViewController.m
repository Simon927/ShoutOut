//
//  ThemeViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "ThemeViewController.h"

// --- Defines ---;
// ThemeViewController Class;
@implementation ThemeViewController

// Functions;
#pragma mark - ThemeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBtnSkip:(id)sender
{
    // Dismiss;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
