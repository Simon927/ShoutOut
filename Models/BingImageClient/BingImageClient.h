//
//  BingImageClient.h
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

// --- Defines ---;
// BingImageClient Class;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
@interface BingImageClient : AFHTTPRequestOperationManager
#else
@interface BingImageClient : AFHTTPSessionManager
#endif

// Functions;
+ (void)searchImagesWithKeyword:(NSString *)keyword skip:(NSInteger)skip completion:(void (^)(NSArray *mediaUrls, BOOL more))completion;

@end
