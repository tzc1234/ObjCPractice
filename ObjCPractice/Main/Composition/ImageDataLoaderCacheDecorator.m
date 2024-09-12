//
//  ImageDataLoaderCacheDecorator.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataLoaderCacheDecorator.h"

@interface ImageDataLoaderCacheDecorator ()

@property (nonnull, nonatomic, strong) id<ImageDataLoader> loader;
@property (nonnull, nonatomic, strong) ImageDataCacher *cacher;

@end

@implementation ImageDataLoaderCacheDecorator

@synthesize loader, cacher;

- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader andCacher:(nonnull ImageDataCacher *)cacher {
    self = [super init];
    if (self) {
        self.loader = loader;
        self.cacher = cacher;
    }
    return self;
}

- (nullable id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url 
                                             completion:(nonnull ImageDataLoaderCompletion)completion {
    return [self.loader loadImageDataForURL:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error && data) {
            [self.cacher saveImageData:data forURL:url completion:^(NSError * _Nullable error) {}];
        }
        
        completion(data, error);
    }];
}

@end
