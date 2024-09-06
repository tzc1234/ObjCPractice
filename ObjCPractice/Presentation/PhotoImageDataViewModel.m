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

@synthesize onLoadImageData, didLoadImageData;

- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader andPhoto:(nonnull Photo *)photo {
    self = [super init];
    if (self) {
        self.loader = loader;
        self.photo = photo;
    }
    return self;
}

- (void)loadImageData {
    self.onLoadImageData(YES);
    
    self.task = [self.loader loadImageDataForURL:self.photo.url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.didLoadImageData(data);
            self.onLoadImageData(NO);
        });
    }];
}

- (void)cancelImageDataLoad {
    [self.task cancel];
    self.task = nil;
}

@end
