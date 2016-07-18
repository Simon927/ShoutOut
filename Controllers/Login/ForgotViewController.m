//
//  ForgotViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "ForgotViewController.h"

#import "APIClient.h"

#import "MBProgressHUD.h"

// --- Defines ---;
// ForgotViewController Class;
@interface ForgotViewController ()

@end

@implementation ForgotViewController

// Functions;
#pragma mark - ForgotViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtEmail) {
        [txtEmail resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Alert Tips
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBtnReset:(id)sender
{
    // Show;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Forgot;
    [APIClient Encryption:txtEmail.text completion:^(BOOL successed, NSString *encrypted) {
        if (successed) {
            [APIClient SendPassword:encrypted completion:^(BOOL successed) {
                if (successed) {
                    // Alert;
                    [self showAlertWithTitle:nil message:@"Sent!"];
                } else {
                    // Hide;
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    // Alert;
                    [self showAlertWithTitle:nil message:@"Internet Connection Error!"];
                }
            }];
        } else {
            // Hide;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // Alert;
            [self showAlertWithTitle:nil message:@"Internet Connection Error!"];
        }
    }];
}

@end
