//
//  MessageCell.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "MessageCell.h"

// --- Defines ---;
// MessageCell Class;
@implementation MessageCell

// Functions;
#pragma mark - MessageCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    // Set;
    [viewAvatar addGestureRecognizer:gestureRecognizer];
}

@end
