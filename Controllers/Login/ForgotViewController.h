//
//  ForgotViewController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// ForgotViewController Class;
@interface ForgotViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *txtEmail;
}

@end
