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

@synthesize onLoad, onError, didLoad, loader;

- (nullable instancetype)initWithLoader:(nonnull id<PhotosLoader>)loader {
    self = [super init];
    if (self) {
        self.loader = loader;
    }
    return self;
}

- (void)loadPhotos {
    if (onLoad) {
        onLoad(YES);
    }
    
    __weak PhotosViewModel *weakSelf = self;
    
    [loader loadWithCompletion:^(NSArray<Photo *> * _Nullable photos, NSError * _Nullable error) {
        if (error) {
            if (weakSelf.onError) {
                weakSelf.onError(@"Error occurred, please try again.");
            }
        } else {
            if (weakSelf.didLoad) {
                weakSelf.didLoad(photos);
            }
            
            if (weakSelf.onError) {
                weakSelf.onError(nil);
            }
        }
        
        if (weakSelf.onLoad) {
            weakSelf.onLoad(NO);
        }
    }];
}

@end
