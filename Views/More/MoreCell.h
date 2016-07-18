//
//  MoreCell.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// MoreCell Class;
@interface MoreCell : UICollectionViewCell
{
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

// Functions;
- (void)startAnimating;
- (void)stopAnimating;

@end
