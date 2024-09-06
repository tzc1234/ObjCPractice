//
//  PhotosLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

typedef void(^PhotosLoaderCompletion)(NSArray<Photo *> * _Nullable photos, NSError * _Nullable error);

@protocol PhotosLoader

- (void)loadWithCompletion:(nonnull PhotosLoaderCompletion)completion;

@end
