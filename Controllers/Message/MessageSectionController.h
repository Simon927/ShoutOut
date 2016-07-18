//
//  MessageSectionController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// MessageSectionController Class;
@interface MessageSectionController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>
{
    IBOutlet NSLayoutConstraint *constraint;
    IBOutlet UICollectionView *viewMessages;
    IBOutlet UITextField *txtMessage;
}

@end
