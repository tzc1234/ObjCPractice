//
//  PhotosLoaderDispatchToMainDecorator.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 07/09/2024.
//

#import "PhotosLoaderDispatchToMainDecorator.h"

@interface PhotosLoaderDispatchToMainDecorator ()

@property (nonnull, nonatomic, strong) id<PhotosLoader> decoratee;

@end

@implementation PhotosLoaderDispatchToMainDecorator

- (nullable instancetype)initWithDecoratee:(nonnull id<PhotosLoader>)decoratee {
    self = [super init];
    if (self) {
        self.decoratee = decoratee;
    }
    return self;
}

- (void)loadWithCompletion:(nonnull PhotosLoaderCompletion)completion {
    [self.decoratee loadWithCompletion:^(NSArray<Photo *> * _Nullable photos, NSError * _Nullable error) {
        [self dispatchToMain:^{ completion(photos, error); }];
    }];
}

- (void)dispatchToMain:(nonnull void(^)(void))block {
    if (NSThread.isMainThread) {
        return block();
    }
    
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
