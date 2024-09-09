//
//  ImageDataCacher.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataStore.h"
#import "ImageDataLoader.h"

extern NSString * _Nonnull const ImageDataCacherDomain;
extern NSInteger const ImageDataCacherDataNotFoundErrorCode;

@interface ImageDataCacher : NSObject <ImageDataLoader>

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWith:(nonnull id<ImageDataStore>)store;
- (void)saveImageData:(nonnull NSData *)data
               forURL:(nonnull NSURL *)url
           completion:(void(^ _Nonnull)(NSError * _Nullable error))completion;

@end
