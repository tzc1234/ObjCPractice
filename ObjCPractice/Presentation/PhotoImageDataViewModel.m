//
//  PhotoImageDataViewModel.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "PhotoImageDataViewModel.h"
#import "ImageDataLoader.h"

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
    if (onLoadImageData)
        onLoadImageData(YES);
    
    self.task = [loader loadImageDataForURL:[self photoURL] completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self->didLoadImageData)
                self.didLoadImageData(data);
            
            if (self->onLoadImageData)
                self.onLoadImageData(NO);
        });
    }];
}

- (void)cancelImageDataLoad {
    [task cancel];
    task = nil;
}

- (NSURL *)photoURL {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = photo.url.scheme;
    components.host = photo.url.host;
    components.path = [NSString stringWithFormat:@"/id/%@/1280/720", self.photo.ID];
    return components.URL;
}

@end
