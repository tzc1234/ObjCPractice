//
//  URLSessionHTTPClient.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"

extern NSString * _Nonnull const URLSessionHTTPClientDomain;
extern NSInteger const UnexpectedRepresentationErrorCode;

@interface URLSessionHTTPClient : NSObject <HTTPClient>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithSession:(nonnull NSURLSession *)session;

@end
