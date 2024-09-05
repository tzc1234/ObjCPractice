//
//  ImageDataLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>

typedef void(^ImageDataLoaderCompletion)(NSData * _Nullable data, NSError * _Nullable error);

@protocol ImageDataLoaderTask

- (void)cancel;

@end

@protocol ImageDataLoader

- (nonnull id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url
                                            completion:(nonnull ImageDataLoaderCompletion)completion;

@end
