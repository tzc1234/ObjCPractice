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

- (nonnull instancetype)initWithLoader:(nonnull id<PhotosLoader>)loader {
    self = [super init];
    self.loader = loader;
    return self;
}

- (void)loadPhotos {
    onLoad(YES);
    
    [self.loader loadWithCompletion:^(NSArray * _Nullable photos, NSError * _Nullable error) {
        if (error) {
            self.onError(@"Error occurred, please try again.");
        } else {
            self.didLoad(photos ?: [NSArray array]);
            self.onError(nil);
        }
        
        self.onLoad(NO);
    }];
}

@end
