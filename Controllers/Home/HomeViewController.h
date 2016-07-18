//
//  HomeViewController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// HomeViewController Class;
@interface HomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIImageView *imgLogo;
    IBOutlet UICollectionView *viewMessages;
}

@end
