//
//  PhotoCropView.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "PhotoCropView.h"

// --- Defines ---;
// PhotoCropView Class;
@interface PhotoCropView () <UIScrollViewDelegate>

// Properties;
@property (nonatomic, strong) UIImageView * overlayView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation PhotoCropView

// Functions;
#pragma mark - PhotoCropView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.scrollView = ({
            UIScrollView * scrollView = [[UIScrollView alloc] init];
            scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            scrollView.delegate = self;
            scrollView.alwaysBounceVertical = YES;
            scrollView.alwaysBounceHorizontal = YES;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.decelerationRate = 0.0f;
            scrollView;
        });
        
        [self addSubview:self.scrollView];
        
        self.imageView = ({
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = nil;
            imageView;
        });
        [self.scrollView addSubview:self.imageView];
        
        self.overlayView = ({
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView;
        });
        [self addSubview:self.overlayView];
        
        self.cropSize = CGSizeMake(160.0f, 160.0f);
        
        self.maximumZoomScale = 5;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.overlayView.frame = self.bounds;
    
    if (self.sourceImage) {
        [self setupZoomScale];
    }
}

- (void)setupZoomScale
{
    [self.imageView setImage:self.sourceImage];
    [self.imageView sizeToFit];
    
    CGFloat offsetX = ceilf(self.scrollView.frame.size.width / 2 - self.cropSize.width / 2);
    CGFloat offsetY = ceilf(self.scrollView.frame.size.height / 2 - self.cropSize.height / 2);
    self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX);
    
    [self.scrollView setContentSize:self.sourceImage.size];
    
    CGFloat zoomScale = 1.0;
    
    if (self.imageView.frame.size.width < self.imageView.frame.size.height) {
        zoomScale = self.scrollView.frame.size.width / self.sourceImage.size.width;
    } else {
        zoomScale = self.scrollView.frame.size.height / self.sourceImage.size.height;
    }
    
    [self.scrollView setMinimumZoomScale:zoomScale];
    [self.scrollView setMaximumZoomScale:self.maximumZoomScale * zoomScale];
    [self.scrollView setZoomScale:zoomScale];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark - UIViewDelegate
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self.scrollView;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - Set
- (void)setOverlayImage:(UIImage *)overlayImage
{
    // Set;
    _overlayImage = overlayImage;
    
    // UI;
    self.overlayView.image = self.overlayImage;
    [self setNeedsLayout];
}

- (void)setSourceImage:(UIImage *)sourceImage
{
    // Set;
    _sourceImage = sourceImage;
    
    // UI;
    [self setNeedsLayout];
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale
{
    // Set;
    _maximumZoomScale = maximumZoomScale > 0 ? maximumZoomScale : 5;
    
    // UI;
    self.imageView.image = nil;
    [self setNeedsLayout];
}

- (void)setScale:(CGFloat)scale
{
    CGFloat zoomScale = 1.0f;
    if (self.sourceImage.size.width < self.sourceImage.size.height) {
        zoomScale = self.scrollView.frame.size.width / self.sourceImage.size.width;
    } else {
        zoomScale = self.scrollView.frame.size.height / self.sourceImage.size.height;
    }
    
    [self.scrollView setZoomScale:zoomScale * scale];
}

#pragma mark - Crop
- (UIImage *)croppedImage
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, YES, scale);
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    [self.scrollView.layer renderInContext:graphicsContext];
    UIImage *finalImage = nil;
    UIImage *sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    CGRect targetFrame = CGRectMake((self.scrollView.contentInset.left + self.scrollView.contentOffset.x) * scale, (self.scrollView.contentInset.top + self.scrollView.contentOffset.y) * scale, self.cropSize.width * scale, self.cropSize.height * scale);
    CGImageRef contextImage = CGImageCreateWithImageInRect([sourceImage CGImage], targetFrame);
    if (contextImage != NULL) {
        finalImage = [UIImage imageWithCGImage:contextImage scale:scale orientation:UIImageOrientationUp];
        CGImageRelease(contextImage);
    }
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

@end
