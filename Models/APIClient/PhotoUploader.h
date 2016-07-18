//
//  PhotoUploader.h
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
// PhotoUploader Class;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
@interface PhotoUploader : AFHTTPRequestOperationManager
#else
@interface PhotoUploader : AFHTTPSessionManager
#endif

// Shared Functions;
+ (void)uploadPhoto:(UIImage *)photo timeStamp:(NSString *)timeStamp name:(NSString *)name completion:(void (^)(BOOL successed, NSURL *url))completion;

@end
