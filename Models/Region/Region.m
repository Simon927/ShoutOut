//
//  Region.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "Region.h"

// --- Defines ---;
// Region Class;
@implementation Region

// Functions
#pragma mark - Region
- (id)initWithAttributes:(NSString *)attributes
{
    self = [super init];
    if (self) {
        NSData *data = [attributes dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        self.errorCode = [dictionary[@"err_code"] integerValue];
        self.regionId = dictionary[@"region_id"];
        self.region = dictionary[@"region"];
    }
    return self;
}

@end
