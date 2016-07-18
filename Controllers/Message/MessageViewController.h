//
//  MessageViewController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// MessageViewController Class;
@interface MessageViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *viewMessages;
    IBOutlet UIButton *btnDelete;
    IBOutlet UIView *viewAvatar;
}

@end
