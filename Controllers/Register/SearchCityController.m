//
//  SearchCityController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "SearchCityController.h"

#import "CityCell.h"

#import "APIClient.h"

#import "City.h"

// --- Defines ---;
// SearchCityController Class;
@interface SearchCityController ()

// Properties;
@property (nonatomic, strong) NSMutableArray *cities;

@end

@implementation SearchCityController

// Functions;
#pragma mark - SearchCityController
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // City;
    [txtCity becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtCity) {
        // Load;
        [self loadCities];
    }
    
    return YES;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.cities count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CityCell";
    CityCell *cell = [viewCities dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    City *city = self.cities[indexPath.row];
    cell.city = city;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = self.cities[indexPath.row];
    
    // Perform;
    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        [self.delegate performSelector:@selector(didSelectCity:) withObject:city];
    }
    
    // Pop;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Load
- (void)loadCities
{
    if ([txtCity.text length] > 2) {
        [APIClient SearchCities:txtCity.text completion:^(NSArray *cities) {
            // Cities;
            self.cities = [NSMutableArray arrayWithArray:cities];
            
            // Reload;
            [viewCities reloadData];
        }];
    }
}

#pragma mark - Events
- (IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
