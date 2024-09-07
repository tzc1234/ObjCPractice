//
//  PhotosLoaderDispatchToMainDecorator.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 07/09/2024.
//

#import <Foundation/Foundation.h>
#import "PhotosLoader.h"

@interface PhotosLoaderDispatchToMainDecorator : NSObject <PhotosLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithDecoratee:(nonnull id<PhotosLoader>)decoratee;

@end
