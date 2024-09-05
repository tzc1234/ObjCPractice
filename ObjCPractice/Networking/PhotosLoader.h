//
//  PhotosLoader.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>

typedef void(^PhotosLoaderCompletion)(NSArray * _Nullable photos, NSError * _Nullable error);

@protocol PhotosLoader

- (void)loadWithCompletion:(nonnull PhotosLoaderCompletion)completion;

@end
