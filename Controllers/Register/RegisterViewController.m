//
//  RegisterViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>

#import "RegisterViewController.h"
#import "SearchCityController.h"
#import "SearchRegionController.h"
#import "AvatarViewController.h"

#import "TwitterNavigationController.h"

#import "APIClient.h"

#import "City.h"
#import "Region.h"

#import "MBProgressHUD.h"

// --- Defines ---;
@interface RegisterViewController () <TwitterNavigationControllerDelegate, SearchCityControllerDelegate, SearchRegionControllerDelegate>

// Properties;
@property (nonatomic, strong) NSString *facebookId;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) City *selectedCity;
@property (nonatomic, strong) Region *selectedRegion;

@end
// RegisterViewController Class;
@implementation RegisterViewController

// Functions;
#pragma mark - RegisterViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Picker;
    space.constant = - viewPicker.frame.size.height;
    navigationBar.barTintColor = [UIColor whiteColor];
    navigationBar.tintColor = [UIColor blackColor];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0f]};
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Notifications;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtBirthday) {
        datePicker.hidden = NO;
        genderPicker.hidden = YES;

        if (space.constant) {
            // Animation;
            [UIView animateWithDuration:0.25 animations:^{
                space.constant = 0;
                [self.view layoutIfNeeded];
            }];
        }
        
        return NO;
    } else if (textField == txtGender) {
        datePicker.hidden = YES;
        genderPicker.hidden = NO;

        if (space.constant) {
            // Animation;
            [UIView animateWithDuration:0.25 animations:^{
                space.constant = 0;
                [self.view layoutIfNeeded];
            }];
        }
        
        return NO;
    } else if (textField == txtCity) {
        SearchCityController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchCityController"];
        viewController.delegate = self;
        [self.navigationController pushViewController:viewController animated:NO];
        return NO;
    } else if (textField == txtArea) {
        SearchRegionController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchRegionController"];
        viewController.delegate = self;
        viewController.city = self.selectedCity;
        [self.navigationController pushViewController:viewController animated:NO];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtNickname) {
        [txtPassword becomeFirstResponder];
    } else if (textField == txtPassword) {
        [txtEmail becomeFirstResponder];
    } else if (textField == txtEmail) {
        [txtEmail resignFirstResponder];
    } else if (textField == txtBirthday) {
        [txtGender resignFirstResponder];
    } else if (textField == txtGender) {
        [txtCity becomeFirstResponder];
    } else if (textField == txtCity) {
        [txtArea becomeFirstResponder];
    } else if (textField == txtArea) {
        [txtArea resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (pickerView == genderPicker) {
        return 3;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == genderPicker) {
        switch (row) {
            case 0:
                return @"I am";
                
            case 1:
                return @"Man";
                
            case 2:
                return @"Woman";
                
            default:
                break;
        }
    }
    
    return nil;
}

#pragma mark - SearchCityControllerDelegate
- (void)didSelectCity:(City *)city
{
    // Set;
    self.selectedCity = city;
    
    // UI;
    txtCity.text = [NSString stringWithFormat:@"%@, %@", self.selectedCity.city, self.selectedCity.province];
}

#pragma mark - SearchRegionControllerDelegate
- (void)didSelectRegion:(Region *)region
{
    // Set;
    self.selectedRegion = region;
    
    // UI;
    txtArea.text = self.selectedRegion.region;
}

#pragma mark - Notification
- (void)willShowKeyBoard:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval duration;
    UIViewAnimationCurve curve;
    CGRect keyboardFrame;
    
    // Keyboard;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    // Animation;
    [UIView animateWithDuration:duration animations:^{
        height.constant = keyboardFrame.size.height;
    }];
}

- (void)willHideKeyBoard:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval duration;
    UIViewAnimationCurve curve;
    CGRect keyboardFrame;
    
    // Keyboard;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    // Animation;
    [UIView animateWithDuration:duration animations:^{
        height.constant = 0;
    }];
}

#pragma mark - Alert Tips
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

#pragma mark - Check
- (BOOL)checkBlankField
{
    NSArray *fields = @[txtNickname, txtPassword, txtBirthday, txtGender, txtCity, txtArea];
//  NSArray *titles = @[@"Nickname", @"Password", @"Birthday", @"Gender", @"City", @"Area"];
    
    for (NSInteger i = 0; i < [fields count]; i++) {
        UITextField *field = fields[i];
//      NSString *title = [titles objectAtIndex:i];
        
        if ([field.text isEqualToString:@""]) {
            [self showAlertWithTitle:nil message:@"Please fill in all the details."];
            return NO;
        }
    }
    
    return YES;
}

- (void)checkNickname
{
    [APIClient LoginChecker:@"xinzhangzhe" completion:^(BOOL successed) {
        
    }];
}

- (BOOL)checkEmail
{
    BOOL filter = YES;
    NSString *filterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = filter ? filterString : laxString;
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailTest evaluateWithObject:txtNickname.text])
    {
        [self showAlertWithTitle:nil message:@"Input a valid Email address."];
        return NO;
    }
    
    return YES;
}

- (BOOL)checkPassword
{
    if ([txtPassword.text length] < 6) {
        [self showAlertWithTitle:nil message:@"Passwords must be at least 6 characters."];
        return NO;
    }
    
    return YES;
}

- (void)resignResponders
{
    if ([txtNickname isFirstResponder]) {
        [txtNickname resignFirstResponder];
    } else if ([txtPassword isFirstResponder]) {
        [txtPassword resignFirstResponder];
    } else if ([txtBirthday isFirstResponder]) {
        [txtBirthday resignFirstResponder];
    } else if ([txtGender isFirstResponder]) {
        [txtGender resignFirstResponder];
    } else if ([txtCity isFirstResponder]) {
        [txtCity resignFirstResponder];
    } else if ([txtArea isFirstResponder]) {
        [txtArea resignFirstResponder];
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
        // Hide;
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (!error) {
            self.facebookId = result[@"id"];
            self.twitterId = nil;
            txtEmail.text = result[@"email"];
        } else {
            
        }
    }];
}

#pragma mark - Twitter
- (void)twitterController:(TwitterNavigationController *)controller didGetUserInfo:(NSDictionary *)userInfo
{
    [controller dismissViewControllerAnimated:YES completion:^{
        [self loginWithTwitter:userInfo];
    }];
}

- (void)twitterControllerDidCancel:(TwitterNavigationController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginWithTwitter:(NSDictionary *)userInfo
{
    // Set;
    self.facebookId = nil;
    self.twitterId = userInfo[@"id"];
    txtNickname.text = userInfo[@"screen_name"];
}

#pragma mark - Set
- (void)setBirthday:(NSDate *)birthday
{
    // Set;
    _birthday = birthday;
    
    // UI;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    
    NSString *date = [formatter stringFromDate:_birthday];
    txtBirthday.text = date;
}

- (void)setGender:(NSInteger)gender
{
    // Set;
    _gender = gender;
    
    // UI;
    switch (_gender) {
        case 1:
        {
            txtGender.text = @"Man";
            break;
        }
            
        case 2:
        {
            txtGender.text = @"Woman";
            break;
        }
            
        default:
        {
            txtGender.text = @"I am";
            break;
        }
    }
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBtnDone:(id)sender
{
    if (!datePicker.hidden) {
        self.birthday = datePicker.date;
    } else if (!genderPicker.hidden) {
        self.gender = [genderPicker selectedRowInComponent:0];
    }
    
    // Animation;
    [UIView animateWithDuration:0.25 animations:^{
        space.constant = -viewPicker.frame.size.height;
        [self.view layoutIfNeeded];
    }];
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

- (IBAction)onBtnSingUp:(id)sender
{
    // Avatar Editing;
    AvatarViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AvatarViewController"];
    [self.navigationController pushViewController:viewController animated:YES];

    return;
    // Show;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    // Sign In ;
    void (^successed)(BOOL successed) = ^(BOOL successed) {
        // Hide;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (successed) {
        } else {
            [self showAlertWithTitle:nil message:@"Internet connection Error!"];
        }
    };

    // Register;
    if (self.facebookId) {
        [APIClient ProfileRegister:txtEmail.text login:txtNickname.text password:txtPassword.text birhday:txtBirthday.text gender:0 city:self.selectedCity region:self.selectedRegion facebookId:self.facebookId completion:successed];
    } else if (self.twitterId) {
        [APIClient ProfileRegister:txtEmail.text login:txtNickname.text password:txtPassword.text birhday:txtBirthday.text gender:0 city:self.selectedCity region:self.selectedRegion twitterId:self.twitterId completion:successed];
    } else {
        [APIClient ProfileRegister:txtEmail.text login:txtNickname.text password:txtPassword.text birhday:txtBirthday.text gender:0 city:self.selectedCity region:self.selectedRegion completion:successed];
    }
}
 
@end
