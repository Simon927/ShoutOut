//
//  PhoneImageController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <AssetsLibrary/AssetsLibrary.h>

#import "PhoneImageController.h"
#import "ThemeCell.h"

// --- Defines ---;
// PhoneImageController Class;
@interface PhoneImageController ()

// Properties;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation PhoneImageController

// Functions;
#pragma mark - Properties
- (ALAssetsLibrary *)assetsLibrary
{
    static ALAssetsLibrary *library = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    
    return library;
}

#pragma mark - PhoneImageController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load;
    [self loadPhotos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ThemeCell";
    ThemeCell *cell = [viewGallery dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setImage:self.photos[indexPath.row]];
    return cell;
}

#pragma mark - Load
- (void)loadPhotos
{
    // Init;
    self.photos = [NSMutableArray array];
    
    // Get;
    [[self assetsLibrary] enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsFilter *filter = [ALAssetsFilter allPhotos];
        
        [group setAssetsFilter:filter];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                CGImageRef imageRef = [result.defaultRepresentation fullResolutionImage];
                if (imageRef) {
                    UIImage *image = [UIImage imageWithCGImage:imageRef];
                    [self.photos addObject:image];
                }
            }
        }];
        
        // Reload;
        [viewGallery reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
