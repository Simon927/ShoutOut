//
//  LoginViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>

#import "LoginViewController.h"
#import "TwitterNavigationController.h"

#import "APIClient.h"

#import "MBProgressHUD.h"

// --- Defines ---;
// Constants
static NSString * const kLoginRemember = @"login_remember";
static NSString * const kLoginEmail = @"login_email";
static NSString * const kLoginPassword = @"login_password";

// LoginViewController Class;
@interface LoginViewController () <TwitterNavigationControllerDelegate>

@end

@implementation LoginViewController

// Functions;
#pragma mark - LoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load;
    [self loadSavedLogin];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Notifications;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Notifications;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == txtEmail) {
        // Save;
        [[NSUserDefaults standardUserDefaults] setObject:txtEmail.text forKey:kLoginEmail];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else if (textField == txtPassword) {
        // Save;
        [[NSUserDefaults standardUserDefaults] setObject:txtPassword.text forKey:kLoginPassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtEmail) {
        [txtPassword becomeFirstResponder];
    } else if (textField == txtPassword) {
        [txtPassword resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Notification
- (void)didShowKeyBoard:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration;
    UIViewAnimationCurve curve;
    
    // Keyboard;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    // Animation;
    [UIView animateWithDuration:duration animations:^{
        height.constant = -172.0f;
    }];
}

- (void)willHideKeyBoard:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration;
    UIViewAnimationCurve curve;
    
    // Keyboard;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    // Animation;
    [UIView animateWithDuration:duration animations:^{
        height.constant = 0.0f;
    }];
}

#pragma mark - Alert Tips
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

#pragma mark - 
- (void)resignResponders
{
    if ([txtEmail isFirstResponder]) {
        [txtEmail resignFirstResponder];
    } else if ([txtPassword isFirstResponder]) {
        [txtPassword resignFirstResponder];
    }
}

#pragma mark - Facebook
- (void)loginWithFacebook
{
    // Show;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Session;
    if (![FBSession activeSession].isOpen) {
        if (![FBSession activeSession].state != FBSessionStateCreated) {
            FBSession *session = [[FBSession alloc] initWithPermissions:@[@"email"]];
            
            // Set;
            [FBSession setActiveSession:session];
        }
        
        // Login;
        [[FBSession activeSession] openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (!error) {
                [self fetchProfile];
            } else {
                // Hide;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    } else {
        [self fetchProfile];
    }
}

- (void)fetchProfile
{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            [APIClient ProfileLogin:1 login:@"" password:@"" completion:^(BOOL successed) {
                
            }];
        } else {
            // Hide;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

#pragma mark - Twitter
- (void)twitterController:(TwitterNavigationController *)controller didGetUserInfo:(NSDictionary *)userInfo
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)twitterControllerDidCancel:(TwitterNavigationController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginWithTwitter
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Show;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Request;
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        // Hide;
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        // Account;
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            if ([accounts count] > 0) {
                return;
            }
        }
        
        // Alert;
        [self showAlertWithTitle:nil message:@""];
    }];
}

#pragma mark - Load
- (void)loadSavedLogin
{
    BOOL remember = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginRemember];
    
    if (remember) {
        txtEmail.text = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginEmail];
        txtPassword.text = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginPassword];
        btnRemember.selected = YES;
    }
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBtnFacebook:(id)sender
{
    [self loginWithFacebook];
}

- (IBAction)onBtnTwitter:(id)sender
{
    TwitterNavigationController *twitterController = [self.storyboard instantiateViewControllerWithIdentifier:@"TwitterNavigationController"];
    twitterController.twitterDelegate = self;
    [self presentViewController:twitterController animated:YES completion:nil];
}

- (IBAction)onBtnRememberMe:(id)sender
{
    btnRemember.selected = !btnRemember.selected;
    
    // Save;
    [[NSUserDefaults standardUserDefaults] setBool:btnRemember.selected forKey:kLoginRemember];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)onBtnDone:(id)sender
{
    // Resign;
    [self resignResponders];
    
    // Show;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Login;
    [APIClient ProfileLogin:2 login:txtEmail.text password:txtPassword.text completion:^(BOOL successed) {
        // Hide;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (successed) {
            // Dismiss;
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self showAlertWithTitle:nil message:@"Internet connection Error!"];
        }
    }];
}

@end
