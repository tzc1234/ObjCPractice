//
//  ImageDataLoaderDispatchToMainDecorator.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import <Foundation/Foundation.h>
#import "ImageDataLoader.h"

@interface ImageDataLoaderDispatchToMainDecorator : NSObject <ImageDataLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithDecoratee:(nonnull id<ImageDataLoader>)decoratee;

@end
