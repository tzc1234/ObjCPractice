//
//  RemoteImageDataLoaderTask.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "ImageDataLoader.h"
#import "HTTPClient.h"

@interface RemoteImageDataLoaderTask : NSObject <ImageDataLoaderTask>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithTask:(nonnull id<HTTPClientTask>)task;

@end
