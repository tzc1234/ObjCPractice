//
//  DispatchToMainQueueDecorator.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import "DispatchToMainQueueDecorator.h"

@implementation DispatchToMainQueueDecorator

@synthesize decoratee;

- (nullable instancetype)initWithDecoratee:(nonnull id)decoratee {
    self = [super init];
    if (self) {
        self.decoratee = decoratee;
    }
    return self;
}

- (void)dispatch:(nonnull void(^)(void))block {
    if (NSThread.isMainThread) {
        return block();
    }
    
    dispatch_async(dispatch_get_main_queue(), block);
}

@end

@implementation DispatchToMainQueueDecorator (PhotosLoader)

- (void)loadWithCompletion:(nonnull PhotosLoaderCompletion)completion {
    if (![decoratee conformsToProtocol:@protocol(PhotosLoader)]) {
        return;
    }
    
    id<PhotosLoader> photoLoader = (id<PhotosLoader>)decoratee;
    [photoLoader loadWithCompletion:^(NSArray<Photo *> * _Nullable photos, NSError * _Nullable error) {
        [self dispatch:^{ completion(photos, error); }];
    }];
}

@end
