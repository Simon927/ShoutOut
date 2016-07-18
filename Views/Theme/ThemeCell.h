//
//  ThemeCell.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// ThemeCell Class;
@interface ThemeCell : UICollectionViewCell
{
    IBOutlet UIImageView *imgTheme;
}

// Functions;
- (void)setImageWithURL:(NSURL *)url;
- (void)setImage:(UIImage *)image;
@end
