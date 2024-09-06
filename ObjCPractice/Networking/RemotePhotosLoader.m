//
//  RemotePhotosLoader.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "RemotePhotosLoader.h"
#import "Photo.h"

NSString *const RemotePhotosLoaderDomain = @"ObjCPractice.RemotePhotosLoader";
NSInteger const RemotePhotosLoaderConnectivityErrorErrorCode = 41;
NSInteger const RemotePhotosLoaderInvalidDataErrorCode = 42;

@interface RemotePhotosLoader ()

@property (copy, nonatomic, nonnull) NSURL *url;
@property (strong, nonatomic, nonnull) id<HTTPClient> client;

@end

@implementation RemotePhotosLoader

- (nullable instancetype)initWithURL:(nonnull NSURL *)url client:(nonnull id<HTTPClient>) client {
    self = [super init];
    if (self) {
        self.url = url;
        self.client = client;
    }
    return self;
}

- (void)loadWithCompletion:(nonnull PhotosLoaderCompletion)completion {
    [self.client getFromURL:self.url
                 completion:^(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return completion(nil, [self connectivityError]);
        }
        
        if (response.statusCode != HTTPURLResponseOK || !data) {
            return completion(nil, [self invalidDataError]);
        }
        
        NSError *invalidDataError = nil;
        NSArray<Photo *> *photos = [self parsePhotosFromData:data withError:&invalidDataError];
        
        if (invalidDataError) {
            return completion(nil, invalidDataError);
        }
        
        return completion(photos, nil);
    }];
}

- (NSArray<Photo *> *)parsePhotosFromData:(NSData *)data withError:(NSError **)jsonError {
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:jsonError];
    if (jsonError && [json isKindOfClass:[NSArray class]] == NO) {
        *jsonError = [self invalidDataError];
        return [NSArray<Photo *> array];
    }
    
    NSMutableArray<Photo *> *photos = [NSMutableArray<Photo *> array];
    NSArray *results = json;
    
    for (NSDictionary *dict in results) {
        NSString *ID = dict[@"id"];
        NSString *author = dict[@"author"];
        NSString *webURLStr = dict[@"url"];
        NSString *urlStr = dict[@"download_url"];
        
        if (!ID || !author || !webURLStr || !urlStr) {
            *jsonError = [self invalidDataError];
            return [NSArray<Photo *> array];
        }
        
        NSURL *webURL = [[NSURL alloc] initWithString:webURLStr];
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        
        if (!webURL || !url) {
            *jsonError = [self invalidDataError];
            return [NSArray<Photo *> array];
        }
        
        NSInteger width = [dict[@"width"] integerValue];
        NSInteger height = [dict[@"height"] integerValue];
        
        Photo *photo = [[Photo alloc] initWithID:ID author:author width:width height:height webURL:webURL url:url];
        [photos addObject:photo];
    }
    
    return photos;
}

- (NSError *)connectivityError {
    return [[NSError alloc] initWithDomain:RemotePhotosLoaderDomain 
                                      code:RemotePhotosLoaderConnectivityErrorErrorCode
                                  userInfo:nil];
}

- (NSError *)invalidDataError {
    return [[NSError alloc] initWithDomain:RemotePhotosLoaderDomain 
                                      code:RemotePhotosLoaderInvalidDataErrorCode
                                  userInfo:nil];
}

@end
