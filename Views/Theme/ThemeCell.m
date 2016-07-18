//
//  ThemeCell.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "ThemeCell.h"

#import "UIImageView+WebCache.h"

// --- Defines ---;
// ThemeCell Class;
@implementation ThemeCell

// Functions;
#pragma mark - Set
- (void)setImageWithURL:(NSURL *)url
{
    [imgTheme sd_setImageWithURL:url placeholderImage:nil];
}

- (void)setImage:(UIImage *)image
{
    imgTheme.image = image;
}

@end
