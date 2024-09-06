//
//  ImageDataLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>
#import "ImageDataLoaderTask.h"

typedef void(^ImageDataLoaderCompletion)(NSData * _Nullable data, NSError * _Nullable error);

@protocol ImageDataLoader

- (nonnull id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url
                                            completion:(nonnull ImageDataLoaderCompletion)completion;

@end
