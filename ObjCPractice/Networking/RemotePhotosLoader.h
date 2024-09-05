//
//  RemotePhotosLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"

extern NSString * _Nonnull const RemotePhotosLoaderDomain;
extern NSInteger const ConnectivityErrorErrorCode;
extern NSInteger const InvalidDataErrorCode;

typedef void(^PhotosLoaderCompletion)(NSArray * _Nullable photos, NSError * _Nullable error);

@interface RemotePhotosLoader : NSObject

- (nonnull instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nonnull instancetype)initWithURL:(nonnull NSURL *)url client:(nonnull id<HTTPClient>) client;
- (void)loadWithCompletion:(nonnull PhotosLoaderCompletion)completion;

@end
