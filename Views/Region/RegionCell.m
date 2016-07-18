//
//  RegionCell.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "RegionCell.h"

#import "Region.h"

// --- Defines ---;
// RegionCell Class;
@implementation RegionCell

// Functions;
#pragma mark - RegionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setRegion:(Region *)region
{
    // Set;
    _region = region;
    
    // UI;
    lblRegion.text = _region.region;
}

@end
