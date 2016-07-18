//
//  LoginViewController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// LoginViewController Class;
@interface LoginViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIView *viewContent;
    IBOutlet NSLayoutConstraint *height;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UIButton *btnRemember;
    IBOutlet UIButton *btnDone;
}

@end
