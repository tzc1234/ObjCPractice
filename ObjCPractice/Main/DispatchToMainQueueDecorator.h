//
//  DispatchToMainQueueDecorator.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import <Foundation/Foundation.h>
#import "PhotosLoader.h"
#import "ImageDataLoader.h"

@interface DispatchToMainQueueDecorator : NSObject

@property (nonnull, nonatomic, strong) id decoratee;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithDecoratee:(nonnull id)decoratee;
- (void)dispatch:(nonnull void(^)(void))block;

@end

@interface DispatchToMainQueueDecorator (PhotosLoader) <PhotosLoader>
@end

@interface DispatchToMainQueueDecorator (ImageDataLoader) <ImageDataLoader>
@end
