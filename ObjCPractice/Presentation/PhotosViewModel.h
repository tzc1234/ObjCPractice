//
//  PhotosViewModel.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>
#import "PhotosLoader.h"

@interface PhotosViewModel : NSObject

@property (nullable, nonatomic, strong) void(^onLoad)(BOOL isLoading);
@property (nullable, nonatomic, strong) void(^onError)(NSString * _Nullable errorMessage);
@property (nullable, nonatomic, strong) void(^didLoad)(NSArray<Photo *> * _Nullable photos);

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithLoader:(nonnull id<PhotosLoader>)loader;
- (void)loadPhotos;

@end
