//
//  GalleryImageController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// GalleryImageController Class;
@interface GalleryImageController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *viewGallery;
}

@end
