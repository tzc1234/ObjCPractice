//
//  RemoteImageDataLoader.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "RemoteImageDataLoader.h"

NSString *const RemoteImageDataLoaderDomain = @"ObjCPractice.RemoteImageDataLoader";
NSInteger const RemoteImageDataLoaderInvalidDataErrorCode = 41;

// MARK: - RemoteImageDataLoaderTask

@interface RemoteImageDataLoaderTask : NSObject <ImageDataLoaderTask>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithTask:(nonnull id<HTTPClientTask>)task;

@end

@interface RemoteImageDataLoaderTask ()

@property (nonnull, nonatomic, strong) id<HTTPClientTask> task;

@end

@implementation RemoteImageDataLoaderTask

@synthesize task;

- (nullable instancetype)initWithTask:(nonnull id<HTTPClientTask>)task {
    self = [super init];
    if (self) {
        self.task = task;
    }
    return self;
}

- (void)cancel {
    [task cancel];
}

@end

// MARK: - RemoteImageDataLoader

@interface RemoteImageDataLoader ()

@property (nonnull, nonatomic, strong) id<HTTPClient> client;

@end

@implementation RemoteImageDataLoader

@synthesize client;

- (nullable instancetype)initWithClient:(nonnull id<HTTPClient>)client {
    self = [super init];
    if (self) {
        self.client = client;
    }
    return self;
}

- (id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url 
                                    completion:(nonnull ImageDataLoaderCompletion)completion {
    id<HTTPClientTask> task = [client getFromURL:url
                                      completion:^(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return completion(nil, [self invalidError]);
        }
        
        if (data && response.statusCode == HTTPURLResponseOK) {
            return completion(data, nil);
        }
        
        return completion(nil, [self invalidError]);
    }];
    return [[RemoteImageDataLoaderTask alloc] initWithTask:task];
}

- (nonnull NSError *)invalidError {
    return [[NSError alloc] initWithDomain:RemoteImageDataLoaderDomain 
                                      code:RemoteImageDataLoaderInvalidDataErrorCode
                                  userInfo:nil];
}

@end
