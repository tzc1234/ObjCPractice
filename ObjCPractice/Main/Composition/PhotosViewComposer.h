//
//  PhotosViewComposer.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import <UIKit/UIKit.h>
#import "PhotosViewController.h"
#import "PhotosLoader.h"
#import "ImageDataLoader.h"

@interface PhotosViewComposer : NSObject

+ (nullable PhotosViewController *)composeWithPhotoLoader:(nonnull id<PhotosLoader>)photoLoader
                                          imageDataLoader:(nonnull id<ImageDataLoader>)imageDataLoader;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));

@end

