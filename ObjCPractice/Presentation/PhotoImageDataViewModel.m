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
@property (nullable, nonatomic, strong) id<ImageDataLoaderTask> task;

@end

@implementation PhotoImageDataViewModel

@synthesize onLoadImageData, didLoadImageData;

- (nonnull instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader {
    self = [super init];
    self.loader = loader;
    return self;
}

- (void)loadImageDataForURL:(nonnull NSURL *)url {
    self.onLoadImageData(YES);
    
    self.task = [self.loader loadImageDataForURL:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        self.didLoadImageData(data);
        self.onLoadImageData(NO);
    }];
}

- (void)cancelImageDataLoad {
    [self.task cancel];
    self.task = nil;
}

@end
