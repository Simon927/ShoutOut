//
//  APIClient.h
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
#import "AFHTTPRequestOperationManager.h"
#else
#import "AFHTTPSessionManager.h"
#endif

// --- Classes ---;
@class User;
@class City;
@class Region;

// --- Defines ---;
// APIClient Class;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
@interface APIClient : AFHTTPRequestOperationManager
#else
@interface APIClient : AFHTTPSessionManager
#endif

// Functions;
+ (void)EmailChecker:(NSString *)email completion:(void (^)(BOOL successed))completion;
+ (void)LoginChecker:(NSString *)login completion:(void (^)(BOOL successed))completion;
+ (void)SearchCities:(NSString *)keyword completion:(void (^)(NSArray *cities))completion;
+ (void)SearchRegions:(City *)city completion:(void (^)(NSArray *regions))completion;
+ (void)ProfileRegister:(NSString *)email login:(NSString *)login password:(NSString *)password birhday:(NSString *)birthday gender:(NSInteger)gender city:(City *)city region:(Region *)region facebookId:(NSString *)facebookId completion:(void (^)(BOOL successed))completion;
+ (void)ProfileRegister:(NSString *)email login:(NSString *)login password:(NSString *)password birhday:(NSString *)birthday gender:(NSInteger)gender city:(City *)city region:(Region *)region twitterId:(NSString *)twitterId completion:(void (^)(BOOL successed))completion;
+ (void)ProfileRegister:(NSString *)email login:(NSString *)login password:(NSString *)password birhday:(NSString *)birthday gender:(NSInteger)gender city:(City *)city region:(Region *)region completion:(void (^)(BOOL successed))completion;
+ (void)ProfileLoginWithFacebook:(NSString *)identifier email:(NSString *)email completion:(void (^)(BOOL successed))completion;
+ (void)ProfileLoginWithTwitter:(NSString *)identifier login:(NSString *)login completion:(void (^)(BOOL successed))completion;
+ (void)ProfileLogin:(NSInteger)method login:(NSString *)login password:(NSString *)password completion:(void (^)(BOOL successed))completion;
+ (void)ProfileLogout:(void (^)(BOOL successed))completion;

+ (void)ProfileMsgNbr:(void (^)(BOOL successed))completion;

+ (void)SendPassword:(NSString *)email completion:(void (^)(BOOL successed))completion;

+ (void)GetProfileInfo:(void (^)(BOOL successed, User *user))completion;

+ (void)GetContacts:(void (^)(BOOL successed, User *user))completion;

+ (void)Decryption:(NSString *)string completion:(void (^)(BOOL successed, NSString *encrypted))completion;
+ (void)Encryption:(NSString *)string completion:(void (^)(BOOL successed, NSString *encrypted))completion;

@end
