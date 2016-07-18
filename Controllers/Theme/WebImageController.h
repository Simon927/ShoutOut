//
//  WebImageController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// WebImageController Class;
@interface WebImageController : UIViewController <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UIView *viewSearch;
    IBOutlet UITextField *txtSearch;
    
    IBOutlet UICollectionView *viewImages;
}

@end
