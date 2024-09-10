//
//  PhotoDetailViewComposer.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 10/09/2024.
//

#import "ImageDataLoader.h"
#import "Photo.h"
#import "PhotoDetailViewController.h"

@interface PhotoDetailViewComposer : NSObject

+ (nullable PhotoDetailViewController *)composeWithImageDataLoader:(nonnull id<ImageDataLoader>)imageDataLoader
                                                     andPhoto: (nonnull Photo *)photo;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));

@end
