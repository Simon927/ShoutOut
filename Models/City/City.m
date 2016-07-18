//
//  City.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "City.h"

// --- Defines ---;
// City Class;
@implementation City

// Functions
#pragma mark - City
- (id)initWithAttributes:(NSString *)attributes
{
    self = [super init];
    if (self) {
        NSData *data = [attributes dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        self.errorCode = [dictionary[@"err_code"] integerValue];
        self.cityID = dictionary[@"city_id"];
        self.city = dictionary[@"city"];
        self.provinceID = dictionary[@"province_id"];
        self.province = dictionary[@"province"];
        self.countryID = dictionary[@"country_id"];
        self.country = dictionary[@"country"];
    }
    return self;
}

@end
