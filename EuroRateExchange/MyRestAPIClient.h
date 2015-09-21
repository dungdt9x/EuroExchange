//
//  NMRestAPIClient.h
//  Sync Shot
//  EuroRateExchange
//
//  Created by Do Trung Dung on 9/21/15.
//  Copyright (c) 2015 dungdtiosdeveloper. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "ServicesAPI.h"

@interface MyRestAPIClient : AFHTTPRequestOperationManager//AFHTTPSessionManager just for iOS 7
+ (MyRestAPIClient *)sharedAPIClient;

-  (void)getRequestWithURL:(NSString *)url param:(NSDictionary*)dict response:(void(^)(id response,NSError *error))block;

@end
