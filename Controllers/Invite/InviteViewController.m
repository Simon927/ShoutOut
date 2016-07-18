//
//  InviteViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "InviteViewController.h"
#import "MenuNavigationController.h"

// --- Defines ---;
// InviteViewController Class;
@implementation InviteViewController

// Functions;
#pragma mark - InviteViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Events
- (IBAction)onBtnHome:(id)sender
{
    [self.navigationController performSelector:@selector(toggleMenu) withObject:nil];
}

@end
