//
//  ImageDataLoaderDispatchToMainQueueDecorator.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import "ImageDataLoaderDispatchToMainDecorator.h"

@interface ImageDataLoaderDispatchToMainDecorator ()

@property (nonnull, nonatomic, strong) id<ImageDataLoader> decoratee;

@end

@implementation ImageDataLoaderDispatchToMainDecorator

- (nullable instancetype)initWithDecoratee:(nonnull id<ImageDataLoader>)decoratee {
    self = [super init];
    if (self) {
        self.decoratee = decoratee;
    }
    return self;
}

- (nullable id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url completion:(nonnull ImageDataLoaderCompletion)completion {
    return [self.decoratee loadImageDataForURL:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        [self dispatchToMain:^{ completion(data, error); }];
    }];
}

- (void)dispatchToMain:(nonnull void(^)(void))block {
    if (NSThread.isMainThread) {
        return block();
    }
    
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
