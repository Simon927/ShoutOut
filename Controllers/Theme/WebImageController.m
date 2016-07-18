//
//  WebImageController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "WebImageController.h"
#import "ThemeCell.h"
#import "MoreCell.h"

#import "BingImageClient.h"

// --- Defines ---;
// WebImageController Class;
@interface WebImageController ()

// Properties;
@property (nonatomic, strong) NSMutableArray *mediaUrls;
@property (nonatomic, assign) BOOL more;

@end

@implementation WebImageController

// Functions;
#pragma mark - WebImageController
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
    if (textField == txtSearch) {
        [txtSearch resignFirstResponder];
    }
    return YES;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.more) {
        return [self.mediaUrls count] + 1;
    } else {
        return [self.mediaUrls count];
    }
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.more && indexPath.row == [self.mediaUrls count]) {
        return CGSizeMake(viewImages.bounds.size.width, 64.0f);
    } else {
        return CGSizeMake(viewImages.bounds.size.width, 112.0f);
    }
    
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.more && indexPath.row == [self.mediaUrls count]) {
        //self.moreMore;
        static NSString *cellIdentifier = @"MoreCell";
        MoreCell *cell = [viewImages dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell startAnimating];
        
        // Load;
        [self loadMore];
        
        return cell;
    } else {
        static NSString *cellIdentifier = @"ThemeCell";
        ThemeCell *cell = [viewImages dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setImageWithURL:self.mediaUrls[indexPath.row]];
        return cell;
    }
    
    return nil;
}

#pragma mark - Load
- (void)loadImages
{
    [BingImageClient searchImagesWithKeyword:txtSearch.text skip:0 completion:^(NSArray *mediaUrls, BOOL more) {
        // Set;
        self.mediaUrls = [NSMutableArray arrayWithArray:mediaUrls];
        self.more = more;
        
        // Reload;
        [viewImages reloadData];
    }];
}

- (void)loadMore
{
    [BingImageClient searchImagesWithKeyword:txtSearch.text skip:[self.mediaUrls count] completion:^(NSArray *mediaUrls, BOOL more) {
        // Add;
        [self.mediaUrls addObjectsFromArray:mediaUrls];
        self.more = more;
        
        // Reload;
        [viewImages reloadData];
    }];
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBtnSearch:(id)sender
{
    // Resign;
    if ([txtSearch isFirstResponder]) {
        [txtSearch resignFirstResponder];
    }
    
    // Search;
    [self loadImages];
}

@end
