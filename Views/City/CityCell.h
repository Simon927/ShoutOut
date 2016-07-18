//
//  CityCell.h
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
// CityCell Class;
@interface CityCell : UICollectionViewCell
{
    IBOutlet UILabel *lblCity;
}

// Properties;
@property (nonatomic, assign) City *city;

@end
