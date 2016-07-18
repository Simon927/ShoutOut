//
//  SearchRegionController.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Classes ---;
@class City;
@class Region;

// --- Defines ---;
// SearchRegionControllerDelegate Protocal;
@protocol SearchRegionControllerDelegate <NSObject>

@optional
- (void)didSelectRegion:(Region *) region;

@end

// SearchRegionController Class;
@interface SearchRegionController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UIView *viewContent;
    IBOutlet UICollectionView *viewRegions;
}

// Properties;
@property (nonatomic, assign) id<SearchRegionControllerDelegate> delegate;
@property (nonatomic, assign) City *city;

@end
