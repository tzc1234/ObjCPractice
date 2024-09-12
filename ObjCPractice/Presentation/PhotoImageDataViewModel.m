//
//  PhotoImageDataViewModel.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "PhotoImageDataViewModel.h"

@interface PhotoImageDataViewModel ()

@property (nonnull, nonatomic, strong) id<ImageDataLoader> loader;
@property (nonnull, nonatomic, strong) Photo *photo;
@property (nullable, nonatomic, strong) id<ImageDataLoaderTask> task;

@end

@implementation PhotoImageDataViewModel

@synthesize onLoadImageData, didLoadImageData, loader, photo, task;

- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader andPhoto:(nonnull Photo *)photo {
    self = [super init];
    if (self) {
        self.loader = loader;
        self.photo = photo;
    }
    return self;
}

- (void)loadImageData {
    if (self.onLoadImageData) {
        self.onLoadImageData(YES);
    }
    
    __weak PhotoImageDataViewModel *weakSelf = self;
    
    self.task = [self.loader loadImageDataForURL:[self photoURL]
                                      completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (weakSelf.didLoadImageData) {
            weakSelf.didLoadImageData(data);
        }
        
        if (weakSelf.onLoadImageData) {
            weakSelf.onLoadImageData(NO);
        }
    }];
}

- (void)cancelImageDataLoad {
    [self.task cancel];
    self.task = nil;
}

- (NSURL *)photoURL {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = self.photo.url.scheme;
    components.host = self.photo.url.host;
    components.path = [NSString stringWithFormat:@"/id/%@/1280/720", self.photo.ID];
    return components.URL;
}

@end
