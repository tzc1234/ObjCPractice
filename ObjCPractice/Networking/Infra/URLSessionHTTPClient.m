//
//  URLSessionHTTPClient.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "URLSessionHTTPClient.h"

// MARK: - URLSessionHTTPClientTask

@interface URLSessionHTTPClientTask : NSObject <HTTPClientTask>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithTask:(nonnull NSURLSessionTask *)task;

@end

@interface URLSessionHTTPClientTask ()

@property (nonnull, nonatomic, strong) NSURLSessionTask *task;

@end

@implementation URLSessionHTTPClientTask

@synthesize task;

- (nullable instancetype)initWithTask:(nonnull NSURLSessionTask *)task {
    self = [super init];
    if (self) {
        self.task = task;
    }
    return self;
}

- (void)cancel {
    [self.task cancel];
}

@end

// MARK: - URLSessionHTTPClient

NSString * _Nonnull const URLSessionHTTPClientDomain = @"ObjCPractice.URLSessionHTTPClient";
NSInteger const UnexpectedRepresentationErrorCode = 40;

@interface URLSessionHTTPClient ()

@property (strong, nonatomic, nonnull) NSURLSession *session;

@end

@implementation URLSessionHTTPClient

@synthesize session;

- (nullable instancetype)initWithSession:(nonnull NSURLSession *)session {
    self = [super init];
    if (self) {
        self.session = session;
    }
    return self;
}

- (id<HTTPClientTask>)getFromURL:(nonnull NSURL *)url completion:(nonnull HTTPClientCompletion)completion {
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url
                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && [response isMemberOfClass:[NSHTTPURLResponse class]]) {
            completion(data, (NSHTTPURLResponse *)response, nil);
        } else if (error) {
            completion(nil, nil, error);
        } else {
            completion(nil, nil, [self unexpectedRepresentationError]);
        }
    }];
    [task resume];
    
    return [[URLSessionHTTPClientTask alloc] initWithTask:task];
}

- (NSError *)unexpectedRepresentationError {
    return [[NSError alloc] initWithDomain:URLSessionHTTPClientDomain
                                      code:UnexpectedRepresentationErrorCode
                                  userInfo:nil];
}

@end
