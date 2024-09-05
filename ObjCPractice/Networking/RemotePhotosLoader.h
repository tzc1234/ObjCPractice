//
//  RemotePhotosLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"
#import "PhotosLoader.h"

extern NSString * _Nonnull const RemotePhotosLoaderDomain;
extern NSInteger const RemotePhotosLoaderConnectivityErrorErrorCode;
extern NSInteger const RemotePhotosLoaderInvalidDataErrorCode;

@interface RemotePhotosLoader : NSObject <PhotosLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithURL:(nonnull NSURL *)url client:(nonnull id<HTTPClient>) client;

@end
