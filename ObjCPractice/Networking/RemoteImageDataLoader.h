//
//  RemoteImageDataLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "ImageDataLoader.h"
#import "HTTPClient.h"

extern NSString * _Nonnull const RemoteImageDataLoaderDomain;
extern NSInteger const RemoteImageDataLoaderInvalidDataErrorCode;

@interface RemoteImageDataLoader : NSObject <ImageDataLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithClient:(nonnull id<HTTPClient>)client;

@end
