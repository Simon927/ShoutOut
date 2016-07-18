//
//  SearchRegionController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "SearchRegionController.h"

#import "RegionCell.h"

#import "APIClient.h"
#import "Region.h"

// --- Defines ---;
// SearchRegionController Class;
@interface SearchRegionController ()

// Properties;
@property (nonatomic, strong) NSMutableArray *regions;

@end

@implementation SearchRegionController

// Functions;
#pragma mark - SearchRegionController
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
    
    // Load;
    [self loadRegions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.regions count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RegionCell";
    RegionCell *cell = [viewRegions dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Region *region = self.regions[indexPath.row];
    cell.region = region;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Region *region = self.regions[indexPath.row];
    
    // Perform;
    if ([self.delegate respondsToSelector:@selector(didSelectRegion:)]) {
        [self.delegate performSelector:@selector(didSelectRegion:) withObject:region];
    }
    
    // Pop;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Load
- (void)loadRegions
{
    if (self.city) {
        [APIClient SearchRegions:self.city completion:^(NSArray *regions) {
            // Regions;
            self.regions = [NSMutableArray arrayWithArray:regions];
            
            // Reload;
            [viewRegions reloadData];
        }];
    }
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
