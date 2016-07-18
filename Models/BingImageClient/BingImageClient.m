//
//  BingImageClient.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "BingImageClient.h"

// --- Defines ---;
// APIBase URL;
static NSString * const kAPIBaseURLString = @"https://api.datamarket.azure.com/";
static NSString * const kAPIURLPath = @"Bing/Search/Image?$format=json";
static NSString * const kAPIKey = @"3Cz+N0rxnywZByRQq98k/CM6/3FDO8J7Uf6M05+MWmc=";

// BingImageClient Class;
@implementation BingImageClient

// Functions;
#pragma mark - Shared Client
+ (instancetype)sharedClient
{
    static BingImageClient *_sharedClient;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BingImageClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        
        // Request;
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sharedClient.requestSerializer setAuthorizationHeaderFieldWithUsername:kAPIKey password:kAPIKey];
        
        // Response;
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedClient;
}

+ (void)searchImagesWithKeyword:(NSString *)keyword skip:(NSInteger)skip completion:(void (^)(NSArray *mediaUrls, BOOL more))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Query"] = [NSString stringWithFormat:@"'%@'", keyword];
    params[@"Adult"] = @"'Moderate'";
    params[@"ImageFilters"] = @"'Size:Medium'";
    params[@"$skip"] = [NSNumber numberWithInteger:skip];
    
    // POST;
    [[BingImageClient sharedClient] GET:kAPIURLPath parameters:params completion:^(id responseObject, NSError *error) {
        NSArray *objects = [responseObject valueForKeyPath:@"d.results"];
        NSMutableArray *mediaUrls = [NSMutableArray array];
        
        for (NSDictionary *object in objects) {
            NSURL *mediaUrl = [NSURL URLWithString:[object valueForKeyPath:@"MediaUrl"]];
            if (mediaUrl) {
                [mediaUrls addObject:mediaUrl];
            }
        }
        
        NSString *more = [responseObject valueForKeyPath:@"__next"];
        
        if (completion) {
            completion(mediaUrls, !more);
        }
    }];
}

#pragma mark - BingImageClient
- (void)GET:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(id responseObject, NSError *error))completion
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    [self GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        if (completion) {
            completion(response, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
#else
    [self GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
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
