//
//  AvatarViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "AvatarViewController.h"

#import "PhotoCropView.h"

// --- Defines ---;
// AvatarViewController Class;
@interface AvatarViewController ()
{
    PhotoCropView *cropView;
}

@end

@implementation AvatarViewController

// Functions;
#pragma mark - AvatarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation Bar;
    self.navigationItem.hidesBackButton = YES;
    
    // Photo View;
    viewPhoto.layer.cornerRadius = 6.0f;
    
    // Crop View;
    cropView = [[PhotoCropView alloc] initWithFrame:viewPhoto.bounds];
    cropView.overlayImage = [UIImage imageNamed:@"avatar_background"];
    
    [viewPhoto addSubview:cropView];
    
    // Tap;
    if (0) {
        UIImage *image = [UIImage imageNamed:@"tap_avatar_boy"];
        [btnTap setImage:image forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"tap_avatar_girl"];
        [btnTap setImage:image forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *viewController = [[UIImagePickerController alloc] init];
                viewController.delegate = self;
                viewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:viewController animated:YES completion:NULL];
            }
            break;
        }
            
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *viewController = [[UIImagePickerController alloc] init];
                viewController.delegate = self;
                viewController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:viewController animated:YES completion:NULL];
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController class] == [UIImagePickerController class]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Crop View;
    cropView.sourceImage = image;
    
    // Tap;
    [btnTap setImage:nil forState:UIControlStateNormal];
    
    // Dismiss;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Events
- (IBAction)onBtnTap:(id)sender
{
    [[[UIActionSheet alloc] initWithTitle:@"Set profile picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose existing photo", @"Take new photo", nil] showInView:self.view];
}

- (IBAction)onSliderChange:(id)sender
{
    [cropView setScale:sliderScale.value];
}

@end
