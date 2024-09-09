//
//  NSCacheImageDataStore.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "NSCacheImageDataStore.h"

@interface NSCacheImageDataStore ()

@property (nonnull, nonatomic, strong) NSCache<NSURL *, NSData *> *cache;

@end

@implementation NSCacheImageDataStore

@synthesize cache;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)insert:(nonnull NSData *)data 
        forURL:(nonnull NSURL *)url
    completion:(void (^ _Nonnull)(NSError * _Nullable))completion {
    [cache setObject:data forKey:url];
    completion(nil);
}

- (void)retrieveDataFor:(nonnull NSURL *)url 
             completion:(void (^ _Nonnull)(NSData * _Nullable, NSError * _Nullable))completion {
    NSData *data = [cache objectForKey:url];
    completion(data, nil);
}

@end
