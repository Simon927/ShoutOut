//
//  PhotoUploader.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "PhotoUploader.h"

#import "Account.h"

// --- Defines ---;
// APIBase URL;
static NSString * const kAPIBaseURLString = @"http://www.mylol.com/";

// PhotoUploader Class;
@implementation PhotoUploader

#pragma mark - Shared Functions
+ (instancetype)sharedUploader
{
    static PhotoUploader *_sharedUploader;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedUploader = [[PhotoUploader alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        
        // Request;
        _sharedUploader.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // Response;
        _sharedUploader.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedUploader;
}

+ (void)uploadPhoto:(UIImage *)photo timeStamp:(NSString *)timeStamp  name:(NSString *)name completion:(void (^)(BOOL successed, NSURL *url))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"timestamp"] = timeStamp;
    params[@"dom_name"] = name;
    
    // Post;
    [[self sharedUploader] POST:@"profil_pic_upload.aspx" parameters:params constructing:^(id<AFMultipartFormData> formData) {
        if (photo) {
            // Avatar;
            NSData *data = UIImageJPEGRepresentation(photo, 1.0f);
            
            // Append;
            [formData appendPartWithFileData:data name:@"upphoto" fileName:@"upphoto" mimeType:@"image/jpeg"];
        }
    } completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
    }];
}

#pragma mark - PhotoUploader
- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters constructing:(void (^)(id <AFMultipartFormData> formData))block completion:(void (^)(id responseObject, NSError *error))completion
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    [self POST:url parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
#else
    [self POST:url parameters:parameters constructingBodyWithBlock:block success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (completion) {
            completion(response, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
#endif
}

@end
