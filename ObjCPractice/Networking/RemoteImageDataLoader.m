//
//  RemoteImageDataLoader.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "RemoteImageDataLoader.h"
#import "RemoteImageDataLoaderTask.h"

NSString *const RemoteImageDataLoaderDomain = @"ObjCPractice.RemoteImageDataLoader";
NSInteger const RemoteImageDataLoaderInvalidDataErrorCode = 41;

@interface RemoteImageDataLoader ()

@property (nonnull, nonatomic, strong) id<HTTPClient> client;

@end

@implementation RemoteImageDataLoader

@synthesize client;

- (nonnull instancetype)initWithClient:(nonnull id<HTTPClient>)client {
    self = [super init];
    self.client = client;
    return self;
}

- (id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url 
                                    completion:(nonnull ImageDataLoaderCompletion)completion {
    id<HTTPClientTask> task = [self.client getFromURL:url
                                           completion:^(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return completion(nil, [self invalidError]);
        }
        
        if (data && response.statusCode == responseOK) {
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
