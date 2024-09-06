//
//  PhotosViewModel.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "PhotosViewModel.h"

@interface PhotosViewModel ()

@property (nonnull, nonatomic, strong) id<PhotosLoader> loader;

@end

@implementation PhotosViewModel

@synthesize onLoad, onError, didLoad;

- (nullable instancetype)initWithLoader:(nonnull id<PhotosLoader>)loader {
    self = [super init];
    if (self) {
        self.loader = loader;
    }
    return self;
}

- (void)loadPhotos {
    if (onLoad)
        onLoad(YES);
    
    [self.loader loadWithCompletion:^(NSArray<Photo *> * _Nullable photos, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (self->onError)
                    self.onError(@"Error occurred, please try again.");
            } else {
                if (self->didLoad)
                    self.didLoad(photos);
                
                if (self->onError)
                    self.onError(nil);
            }
            
            if (self->onLoad)
                self.onLoad(NO);
        });
    }];
}

@end
