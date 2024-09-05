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
extern NSInteger const ConnectivityErrorErrorCode;
extern NSInteger const InvalidDataErrorCode;

@interface RemotePhotosLoader : NSObject <PhotosLoader>

- (nonnull instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nonnull instancetype)initWithURL:(nonnull NSURL *)url client:(nonnull id<HTTPClient>) client;

@end
