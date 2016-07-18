//
//  ContactViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "ContactViewController.h"
#import "MenuNavigationController.h"

#import "APIClient.h"

// --- Defines ---;
// ContactViewController Class;
@implementation ContactViewController

// Functions;
#pragma mark - ContactViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load;
//  [self loadContacts];
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
    static NSString *cellIdentifier = @"ContactCell";
    UICollectionViewCell *cell = [viewContacts dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Load
- (void)loadContacts
{
    [APIClient GetContacts:^(BOOL successed, User *user) {
        
    }];
}

#pragma mark - Events
- (IBAction)onBtnHome:(id)sender
{
    [self.navigationController performSelector:@selector(toggleMenu) withObject:nil];
}

- (IBAction)onBtnDelete:(id)sender
{
    btnDelete.selected = !btnDelete.selected;
}

@end
