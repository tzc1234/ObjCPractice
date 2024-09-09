//
//  ImageDataLoaderCacheDecorator.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataCacher.h"

@interface ImageDataLoaderCacheDecorator : NSObject <ImageDataLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader 
                             andCacher:(nonnull ImageDataCacher *)cacher;

@end
