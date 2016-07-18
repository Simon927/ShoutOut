//
//  CityCell.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "CityCell.h"

#import "City.h"

// --- Defines ---;
// CityCell Class;
@implementation CityCell

// Functions;
#pragma mark - CityCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setCity:(City *)city
{
    // Set;
    _city = city;
    
    // UI;
    lblCity.text = [NSString stringWithFormat:@"%@, %@", _city.city, _city.province];
}

@end
