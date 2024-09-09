//
//  ImageDataCacher.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataCacher.h"
#import "ImageDataCacherDataLoadTask.h"

NSString *const ImageDataCacherDomain = @"ObjCPractice.ImageDataCacher";
NSInteger const ImageDataCacherDataNotFoundErrorCode = 44;

@interface ImageDataCacher ()

@property (nonnull, nonatomic, strong) id<ImageDataStore> store;

@end

@implementation ImageDataCacher

@synthesize store;

- (nullable instancetype)initWith:(nonnull id<ImageDataStore>)store {
    self = [super init];
    if (self) {
        self.store = store;
    }
    return self;
}

- (void)saveImageData:(nonnull NSData *)data 
               forURL:(nonnull NSURL *)url
           completion:(void(^ _Nonnull)(NSError * _Nullable error))completion {
    [store insert:data forURL:url completion:completion];
}

- (nullable id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url 
                                             completion:(nonnull ImageDataLoaderCompletion)completion {
    ImageDataCacherDataLoadTask *task = [[ImageDataCacherDataLoadTask alloc] initWith:completion];
    [store retrieveDataFor:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error || !data) {
            return task.completion(nil, [self dataNotFoundError]);
        }
        
        task.completion(data, nil);
    }];
    return task;
}

- (NSError *)dataNotFoundError {
    return [[NSError alloc] initWithDomain:ImageDataCacherDomain
                                      code:ImageDataCacherDataNotFoundErrorCode
                                  userInfo:nil];
}

@end
