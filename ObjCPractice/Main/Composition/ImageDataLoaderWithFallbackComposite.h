//
//  ImageDataLoaderWithFallbackComposite.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataLoader.h"

@interface ImageDataLoaderWithFallbackComposite : NSObject <ImageDataLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithPrimary:(nonnull id<ImageDataLoader>)primary
                             andFallback:(nonnull id<ImageDataLoader>)fallback;

@end
