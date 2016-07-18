//
//  GalleryImageController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "GalleryImageController.h"
#import "ThemeCell.h"

// --- Defines ---;
// GalleryImageController Class;
@interface GalleryImageController ()

// Properties;
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation GalleryImageController

// Functions;
#pragma mark - GalleryImageController
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
    [self.photos addObject:[UIImage imageNamed:@"img_theme_template1"]];
    [self.photos addObject:[UIImage imageNamed:@"img_theme_template2"]];
    [self.photos addObject:[UIImage imageNamed:@"img_theme_template3"]];
    [self.photos addObject:[UIImage imageNamed:@"img_theme_template4"]];
    
    // Reload;
    [viewGallery reloadData];
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
