//
//  MessageCell.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// MessageCell Class;
@interface MessageCell : UICollectionViewCell
{
    IBOutlet UIView *viewAvatar;
    IBOutlet UIImageView *imgAvatar;
}

// Functions;
- (void)setGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

@end
