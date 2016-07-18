//
//  RegionCell.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Classes ---;
@class Region;

// --- Defines ---;
// RegionCell Class;
@interface RegionCell : UICollectionViewCell
{
    IBOutlet UILabel *lblRegion;
}

// Properties;
@property (nonatomic, assign) Region *region;

@end
