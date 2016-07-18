//
//  MoreCell.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "MoreCell.h"

// --- Defines ---;
// MoreCell Class;
@implementation MoreCell

// Functions;
#pragma mark - Animating
- (void)startAnimating
{
    [activityIndicator startAnimating];
}

- (void)stopAnimating
{
    [activityIndicator stopAnimating];
}

@end
