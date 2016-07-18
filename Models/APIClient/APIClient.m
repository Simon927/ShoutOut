//
//  APIClient.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#include <ifaddrs.h>
#include <arpa/inet.h>

#import "APIClient.h"

#import "Account.h"
#import "User.h"
#import "City.h"
#import "Region.h"

// --- Defines ---;
// APIBase URL;
static NSString * const kAPIBaseURLString = @"http://shoutout.mylol.com/WCF/service.svc";

// APIClient Class;
@implementation APIClient

// Functions;
#pragma mark - Shared Client
+ (instancetype)sharedClient
{
    static APIClient *_sharedClient;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        
        // Request;
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // Response;
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedClient;
}

+ (NSString *)getIPAddress
{
    NSString *address = @"127.0.0.1";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        temp_addr = interfaces;
        
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)convertDictionaryToString:(NSDictionary *)dictionary
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma mark - APIClient
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

- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(id responseObject, NSError *error))completion
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    [self POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
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
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
#endif
}

#pragma mark - Check
+ (void)EmailChecker:(NSString *)email completion:(void (^)(BOOL successed))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"email"] = email;
    
    // GET;
    [[self sharedClient] GET:@"emailchecker" parameters:params completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        if (completion) {
            completion(!error);
        }
    }];
}

+ (void)LoginChecker:(NSString *)login completion:(void (^)(BOOL successed))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"login"] = login;
    
    // GET;
    [[self sharedClient] GET:@"loginchecker" parameters:params completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        if (completion) {
            completion(!error);
        }
    }];
}

+ (void)SearchCities:(NSString *)keyword completion:(void (^)(NSArray *cities))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"keyword"] = keyword;
    params[@"top"] = @10;
    
    // GET;
    [[self sharedClient] GET:@"searchcities" parameters:params completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        NSMutableArray *cities = [NSMutableArray array];
        NSArray *attributes = responseObject[@"d"];
        
        for (NSString *attribute in attributes) {
            City *city = [[City alloc] initWithAttributes:attribute];
            
            // Add;
            [cities addObject:city];
        }
        
        if (completion) {
            completion(cities);
        }
    }];
}

+ (void)SearchRegions:(City *)city completion:(void (^)(NSArray *regions))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"city_id"] = city.cityID;
    
    // GET;
    [[self sharedClient] GET:@"searchregions" parameters:params completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        NSMutableArray *regions = [NSMutableArray array];
        NSArray *attributes = responseObject[@"d"];
        
        for (NSString *attribute in attributes) {
            Region *region = [[Region alloc] initWithAttributes:attribute];
            
            // Add;
            [regions addObject:region];
        }
        
        if (completion) {
            completion(regions);
        }
    }];
}

#pragma mark - Login
+ (void)ProfileRegister:(NSString *)email login:(NSString *)login password:(NSString *)password birhday:(NSString *)birthday gender:(NSInteger)gender city:(City *)city region:(Region *)region facebookId:(NSString *)facebookId completion:(void (^)(BOOL successed))completion
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    info[@"email"] = email;
    info[@"login"] = login;
    info[@"pass"] = password;
    info[@"region"] = region.regionId;
    info[@"city"] = city.city;
    info[@"city_id"] = city.cityID;
    info[@"dob_day"] = @"4";
    info[@"dob_month"] = @"9";
    info[@"dob_year"] = @"1993";
    info[@"gender"] = @0;
    info[@"fb_id"] = facebookId;
    info[@"tw_id"] = @"";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_ip"] = [self getIPAddress];
    params[@"register"] = [self convertDictionaryToString:info];
    
    // GET;
    [[self sharedClient] GET:@"profileregister" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (!errCode) {
                NSString *userId = result[@"user_id"];
                NSString *userLoginKey = result[@"user_login_key"];
                NSString *userPassKey = result[@"user_pass_key"];
                
                NSLog(@"User ID : %@", userId);
                NSLog(@"User Login Key : %@", userLoginKey);
                NSLog(@"User Pass Key : %@", userPassKey);
            }
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(!error);
            }
        }
    }];
    
}

+ (void)ProfileRegister:(NSString *)email login:(NSString *)login password:(NSString *)password birhday:(NSString *)birthday gender:(NSInteger)gender city:(City *)city region:(Region *)region twitterId:(NSString *)twitterId completion:(void (^)(BOOL successed))completion
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    info[@"email"] = email;
    info[@"login"] = login;
    info[@"pass"] = password;
    info[@"region"] = region.regionId;
    info[@"city"] = city.city;
    info[@"city_id"] = city.cityID;
    info[@"dob_day"] = @"4";
    info[@"dob_month"] = @"9";
    info[@"dob_year"] = @"1993";
    info[@"gender"] = @0;
    info[@"fb_id"] = @"";
    info[@"tw_id"] = twitterId;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_ip"] = [self getIPAddress];
    params[@"register"] = [self convertDictionaryToString:info];
    
    // GET;
    [[self sharedClient] GET:@"profileregister" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (!errCode) {
                NSString *userId = result[@"user_id"];
                NSString *userLoginKey = result[@"user_login_key"];
                NSString *userPassKey = result[@"user_pass_key"];
                
                NSLog(@"User ID : %@", userId);
                NSLog(@"User Login Key : %@", userLoginKey);
                NSLog(@"User Pass Key : %@", userPassKey);
            }
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(!error);
            }
        }
    }];
}

+ (void)ProfileRegister:(NSString *)email login:(NSString *)login password:(NSString *)password birhday:(NSString *)birthday gender:(NSInteger)gender city:(City *)city region:(Region *)region completion:(void (^)(BOOL successed))completion
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    info[@"email"] = email;
    info[@"login"] = login;
    info[@"pass"] = password;
    info[@"region"] = region.regionId;
    info[@"city"] = city.city;
    info[@"city_id"] = city.cityID;
    info[@"dob_day"] = @"4";
    info[@"dob_month"] = @"9";
    info[@"dob_year"] = @"1993";
    info[@"gender"] = @0;
    info[@"fb_id"] = @"0";
    info[@"tw_id"] = @"0";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_ip"] = [self getIPAddress];
    params[@"register"] = [self convertDictionaryToString:info];
    
    // GET;
    [[self sharedClient] GET:@"profileregister" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (!errCode) {
                NSString *userId = result[@"user_id"];
                NSString *userLoginKey = result[@"user_login_key"];
                NSString *userPassKey = result[@"user_pass_key"];
                
                NSLog(@"User ID : %@", userId);
                NSLog(@"User Login Key : %@", userLoginKey);
                NSLog(@"User Pass Key : %@", userPassKey);
            }
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(!error);
            }
        }
    }];
}

+ (void)ProfileLoginWithFacebook:(NSString *)identifier email:(NSString *)email completion:(void (^)(BOOL successed))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ip"] = [self getIPAddress];
    params[@"method"] = @"";
    params[@"custom_login"] = @"";
    params[@"custom_pass"] = @"";
    
    // GET;
    [[self sharedClient] GET:@"profilelogin" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (!errCode) {
                NSString *identifier = result[@"user_id"];
                NSString *login = result[@"user_login_key"];
                NSString *password = result[@"user_pass_key"];
                
                // Set;
                [Account me].identifier = identifier;
                [Account me].login = login;
                [Account me].password = password;
            }
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(!error);
            }
        }
    }];

}

+ (void)ProfileLoginWithTwitter:(NSString *)identifier login:(NSString *)login completion:(void (^)(BOOL successed))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ip"] = [self getIPAddress];
    params[@"method"] = @"";
    params[@"custom_login"] = @"";
    params[@"custom_pass"] = @"";
    
    // GET;
    [[self sharedClient] GET:@"profilelogin" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (!errCode) {
                NSString *identifier = result[@"user_id"];
                NSString *login = result[@"user_login_key"];
                NSString *password = result[@"user_pass_key"];
                
                // Set;
                [Account me].identifier = identifier;
                [Account me].login = login;
                [Account me].password = password;
            }
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(!error);
            }
        }
    }];
}

+ (void)ProfileLogin:(NSInteger)method login:(NSString *)login password:(NSString *)password completion:(void (^)(BOOL successed))completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ip"] = [self getIPAddress];
    params[@"method"] = [NSNumber numberWithInteger:method];
    params[@"custom_login"] = login;
    params[@"custom_pass"] = password;
    
    // GET;
    [[self sharedClient] GET:@"profilelogin" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (!errCode) {
                NSString *identifier = result[@"user_id"];
                NSString *login = result[@"user_login_key"];
                NSString *password = result[@"user_pass_key"];
                
                // Set;
                [Account me].identifier = identifier;
                [Account me].login = login;
                [Account me].password = password;
            }
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(!error);
            }
        }
    }];
}

+ (void)ProfileLogout:(void (^)(BOOL successed))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_id"] = @"";
    
    // GET;
    [[self sharedClient] GET:@"profilelogout" parameters:params completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        if (completion) {
            completion(!error);
        }
    }];
}

+ (void)ProfileMsgNbr:(void (^)(BOOL successed))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_id"] = @"";
    
    // GET;
    [[self sharedClient] GET:@"profilemsgbbr" parameters:params completion:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        
        if (completion) {
            completion(!error);
        }
    }];
}

+ (void)SendPassword:(NSString *)email completion:(void (^)(BOOL successed))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_email"] = email;
    
    // GET;
    [[self sharedClient] GET:@"sendpassword" parameters:params completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSString *responseString = responseObject[@"d"][0];
            NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSInteger errCode = [result[@"err_code"] integerValue];
            
            if (completion) {
                completion(!errCode);
            }
        } else {
            if (completion) {
                completion(NO);
            }
        }
    }];
}

+ (void)GetProfileInfo:(void (^)(BOOL successed, User *user))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_id"] = [Account me].identifier;
    
    // GET;
    [[self sharedClient] GET:@"getprofileinfos" parameters:params completion:^(id responseObject, NSError *error) {
        NSString *responseString = responseObject[@"d"][0];
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        User *user = [[User alloc] initWithAttributes:result];
        NSLog(@"%@", result);
        
        if (completion) {
            completion(!error, user);
        }
    }];
}

+ (void)GetContacts:(void (^)(BOOL successed, User *user))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pro_id"] = [Account me].identifier;
    params[@"top"] = @"1";
    params[@"skip"] = @"0";
    
    // GET;
    [[self sharedClient] GET:@"getcontact" parameters:params completion:^(id responseObject, NSError *error) {
        NSString *responseString = responseObject[@"d"][0];
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        User *user = [[User alloc] initWithAttributes:result];
        NSLog(@"%@", result);
        
        
        if (completion) {
            completion(!error, user);
        }
    }];
}

+ (void)Decryption:(NSString *)string completion:(void (^)(BOOL successed, NSString *encrypted))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"decrypt"] = string;
    
    // GET;
    [[self sharedClient] GET:@"SQ_Encryption" parameters:params completion:^(id responseObject, NSError *error) {
        NSString *responseString = responseObject[@"d"];
        NSLog(@"%@", responseString);
        
        if (completion) {
            completion(!error, responseString);
        }
    }];
}

+ (void)Encryption:(NSString *)string completion:(void (^)(BOOL successed, NSString *encrypted))completion
{
    // Params;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"encrypt"] = string;
    
    // GET;
    [[self sharedClient] GET:@"SQ_Encryption" parameters:params completion:^(id responseObject, NSError *error) {
        NSString *responseString = responseObject[@"d"];
        NSLog(@"%@", responseString);
        
        if (completion) {
            completion(!error, responseString);
        }
    }];
}

@end
