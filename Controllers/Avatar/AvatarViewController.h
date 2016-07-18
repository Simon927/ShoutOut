//
//  AvatarViewController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// AvatarViewController Class;
@interface AvatarViewController : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIButton *btnTap;
    IBOutlet UIView *viewPhoto;
    IBOutlet UISlider *sliderScale;
}

@end
