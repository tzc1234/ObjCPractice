//
//  URLSessionHTTPClientTask.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "HTTPClient.h"

@interface URLSessionHTTPClientTask : NSObject <HTTPClientTask>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithTask:(nonnull NSURLSessionTask *)task;

@end
