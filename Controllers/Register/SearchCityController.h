//
//  SearchCityController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Classes ---;
@class City;

// --- Defines ---;
// SearchCityControllerDelegate Protocal;
@protocol SearchCityControllerDelegate <NSObject>

@optional
- (void)didSelectCity:(City *) city;

@end

// SearchCityController Class;
@interface SearchCityController : UIViewController <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIView *viewContent;
    IBOutlet NSLayoutConstraint *constraint;
    IBOutlet UITextField *txtCity;
    IBOutlet UICollectionView *viewCities;
}

// Properties;
@property (nonatomic, assign) id<SearchCityControllerDelegate> delegate;

@end
