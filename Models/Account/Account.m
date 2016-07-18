//
//  Account.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "Account.h"

// --- Defines ---;
// Constants;
static NSString * const kAccountIdentifier = @"account_identifier";
static NSString * const kAccountLogin = @"account_login_key";
static NSString * const kAccountPassword = @"account_password_key";

// Account Class;
@implementation Account

+ (instancetype)me
{
    static Account *_me;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _me = [[Account alloc] init];
    });
    
    return _me;
}

#pragma mark - Authenticate
- (BOOL)isAuthenticated
{
    return self.identifier != nil;
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccountIdentifier];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccountLogin];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccountPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Set
- (void)setObject:(NSObject *)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIdentifier:(NSString *)identifier
{
    [self setObject:identifier forKey:kAccountIdentifier];
}

- (void)setLogin:(NSString *)login
{
    [self setObject:login forKey:kAccountLogin];
}

- (void)setPassword:(NSString *)password
{
    [self setObject:password forKey:kAccountPassword];
}

#pragma mark - Get
- (NSString *)identifier
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAccountIdentifier];
}

- (NSString *)login
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAccountLogin];
}

- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAccountPassword];
}

@end
