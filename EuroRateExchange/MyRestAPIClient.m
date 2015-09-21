//
//  NMRestAPIClient.m
//  EuroRateExchange
//
//  Created by Do Trung Dung on 9/21/15.
//  Copyright (c) 2015 dungdtiosdeveloper. All rights reserved.
//

#import "MyRestAPIClient.h"
#define SHARED_API_CLIENT [MyRestAPIClient sharedAPIClient]

@implementation MyRestAPIClient


+ (MyRestAPIClient*)sharedAPIClient {
    
    static MyRestAPIClient* _defaultClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultClient = [[MyRestAPIClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE]];
    });
    
    return _defaultClient;
}


+ (AFHTTPResponseSerializer <AFURLResponseSerialization> *)sharedJSONResponseSerializer {
    
    static AFJSONResponseSerializer* _defaultSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _defaultSerializer;
}

+ (AFHTTPResponseSerializer <AFURLResponseSerialization> *)sharedXMLResponseSerializer {
    
    static AFHTTPResponseSerializer* _defaultSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _defaultSerializer;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
       
    }
    return self;
}

//********************************************

-(void)getRequestWithURL:(NSString *)url param:(NSDictionary *)dict response:(void (^)(id, NSError *))block{
    [url UTF8String];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet *contentTypes = [manager.responseSerializer.acceptableContentTypes mutableCopy];
    [contentTypes addObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = [contentTypes copy];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"foo" password:@"bar"];

    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        NSLog(@"%@",operation.responseString);
        NSLog(@"Error: %@", error);
    }];
}


@end
