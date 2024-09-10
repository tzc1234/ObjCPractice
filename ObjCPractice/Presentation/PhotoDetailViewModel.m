//
//  PhotoDetailViewModel.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 10/09/2024.
//

#import "PhotoDetailViewModel.h"

@interface PhotoDetailViewModel ()

@property (nonnull, nonatomic, strong) id<ImageDataLoader> loader;
@property (nullable, nonatomic, strong) id<ImageDataLoaderTask> task;
@property (nonnull, nonatomic, strong) Photo *photo;

@end

@implementation PhotoDetailViewModel

@synthesize loader, task, photo, onLoad, didLoad, shouldReload;

- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader andPhoto:(nonnull Photo *)photo {
    self = [super init];
    if (self) {
        self.loader = loader;
        self.photo = photo;
    }
    return self;
}

- (NSString *)author {
    return photo.author;
}

- (NSURL *)webURL {
    return photo.webURL;
}

- (NSInteger)photoWidth {
    return photo.width;
}

- (NSInteger)photoHeight {
    return photo.height;
}

- (void)loadPhotoData {
    if (onLoad) {
        self.onLoad(YES);
    }
    
    __weak PhotoDetailViewModel *weakSelf = self;
    self.task = [loader loadImageDataForURL:photo.url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            if (weakSelf.shouldReload) {
                weakSelf.shouldReload(YES);
            }
            
            if (weakSelf.didLoad) {
                weakSelf.didLoad(nil);
            }
        } else {
            if (weakSelf.shouldReload) {
                weakSelf.shouldReload(NO);
            }
            
            if (weakSelf.didLoad) {
                weakSelf.didLoad(data);
            }
        }
        
        if (weakSelf.onLoad) {
            weakSelf.onLoad(NO);
        }
    }];
}

- (void)cancelPhotoDataLoad {
    [task cancel];
    self.task = nil;
}

@end
