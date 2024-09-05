//
//  RemoteImageDataLoaderTask.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "ImageDataLoader.h"
#import "HTTPClient.h"

@interface RemoteImageDataLoaderTask : NSObject <ImageDataLoaderTask>

- (nonnull instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nonnull instancetype)initWithTask:(nonnull id<HTTPClientTask>)task;

@end
