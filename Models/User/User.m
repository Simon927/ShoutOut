//
//  User.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "User.h"

// --- Defines ---;
// User Class;
@implementation User

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.identifier = attributes[@"p_id"];
        self.login = attributes[@"p_login"];
        self.birthday = attributes[@"p_dob"];
        self.gender = attributes[@"p_gender"];
        self.avatar = attributes[@"p_photo"];
        self.email = attributes[@"p_email"];
        self.banner = attributes[@"p_banner"];
        self.regIdentifier = attributes[@"p_reg_id"];
    }
    return self;
}

@end
