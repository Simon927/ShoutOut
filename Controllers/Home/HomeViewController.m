//
//  HomeViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "HomeViewController.h"
#import "MenuNavigationController.h"

#import "MessageSectionController.h"

#import "APIClient.h"
#import "PhotoUploader.h"

#import "User.h"

// --- Defines ---;
// HomeViewController Class;
@implementation HomeViewController

// Functions;
#pragma mark - HomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Navigation Bar;
    self.navigationItem.titleView = imgLogo;

    return;
    
    [APIClient GetProfileInfo:^(BOOL successed, User *user) {
        [APIClient Encryption:user.identifier completion:^(BOOL successed, NSString *identifier) {
            [APIClient Encryption:user.regIdentifier completion:^(BOOL successed, NSString *reg) {
                
                [PhotoUploader uploadPhoto:[UIImage imageNamed:@"tap_avatar_boy"] timeStamp:identifier name:reg completion:^(BOOL successed, NSURL *url) {
                    
                }];
            }];
        }];
    }];
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MessageCell";
    UICollectionViewCell *cell = [viewMessages dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageSectionController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageSectionController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Events
- (IBAction)onBtnHome:(id)sender
{
    [self.navigationController performSelector:@selector(toggleMenu) withObject:nil];
}

@end
