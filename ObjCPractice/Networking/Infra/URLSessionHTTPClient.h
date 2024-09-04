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

- (nonnull instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nonnull instancetype)initWithSession:(nonnull NSURLSession *)session;

@end
