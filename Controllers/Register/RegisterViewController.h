//
//  RegisterViewController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// RegisterViewController Class;
@interface RegisterViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet NSLayoutConstraint *height;
    IBOutlet UITextField *txtNickname;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtBirthday;
    IBOutlet UITextField *txtGender;
    IBOutlet UITextField *txtCity;
    IBOutlet UITextField *txtArea;
    
    IBOutlet UIView *viewPicker;
    IBOutlet NSLayoutConstraint *space;
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIPickerView *genderPicker;
}

@end
