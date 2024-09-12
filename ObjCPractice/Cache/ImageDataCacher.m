//
//  ImageDataCacher.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataCacher.h"

NSString *const ImageDataCacherDomain = @"ObjCPractice.ImageDataCacher";
NSInteger const ImageDataCacherDataNotFoundErrorCode = 44;

// MARK: - CacherDataLoadTask

@interface CacherDataLoadTask : NSObject <ImageDataLoaderTask>

@property (nullable, nonatomic, strong) ImageDataLoaderCompletion completion;

- (nullable instancetype)initWith:(nonnull ImageDataLoaderCompletion)completion;

@end

@implementation CacherDataLoadTask

@synthesize completion;

- (nullable instancetype)initWith:(nonnull ImageDataLoaderCompletion)completion {
    self = [super init];
    if (self) {
        self.completion = completion;
    }
    return self;
}

- (void)cancel {
    completion = nil;
}

@end

// MARK: - ImageDataCacher

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
    [self.store insert:data forURL:url completion:completion];
}

- (nullable id<ImageDataLoaderTask>)loadImageDataForURL:(nonnull NSURL *)url 
                                             completion:(nonnull ImageDataLoaderCompletion)completion {
    CacherDataLoadTask *task = [[CacherDataLoadTask alloc] initWith:completion];
    [self.self.store retrieveDataFor:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
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
