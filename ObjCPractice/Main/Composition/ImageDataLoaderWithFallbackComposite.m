//
//  ImageDataLoaderWithFallbackComposite.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataLoaderWithFallbackComposite.h"

// MARK: - TaskWrapper
@interface TaskWrapper : NSObject <ImageDataLoaderTask>

@property (nullable, nonatomic, strong) id<ImageDataLoaderTask> task;

@end

@implementation TaskWrapper

- (void)cancel {
    [self.task cancel];
}

@end

// MARK: - ImageDataLoaderWithFallbackComposite
@interface ImageDataLoaderWithFallbackComposite ()

@property (nonnull, nonatomic, strong) id<ImageDataLoader> primary;
@property (nonnull, nonatomic, strong) id<ImageDataLoader> fallback;

@end

@implementation ImageDataLoaderWithFallbackComposite

@synthesize primary, fallback;

- (nullable instancetype)initWithPrimary:(nonnull id<ImageDataLoader>)primary 
                             andFallback:(nonnull id<ImageDataLoader>)fallback {
    self = [super init];
    if (self) {
        self.primary = primary;
        self.fallback = fallback;
    }
    return self;
}

- (nullable id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url 
                                             completion:(nonnull ImageDataLoaderCompletion)completion {
    TaskWrapper *wrapper = [[TaskWrapper alloc] init];
    wrapper.task = [primary loadImageDataForURL:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            wrapper.task = [self->fallback loadImageDataForURL:url completion:completion];
        }
        
        completion(data, error);
    }];
    return wrapper;
}

@end


