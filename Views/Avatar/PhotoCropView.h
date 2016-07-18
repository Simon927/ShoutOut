//
//  PhotoCropView.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// PhotoCropView Class;
@interface PhotoCropView : UIView

// Properties;
@property (nonatomic, assign) CGSize cropSize;
@property (nonatomic, strong) UIImage * overlayImage;
@property (nonatomic, strong) UIImage * sourceImage;
@property (nonatomic, assign) CGFloat maximumZoomScale;

// Functions;
- (void)setScale:(CGFloat)scale;
- (UIImage *)croppedImage;

@end
