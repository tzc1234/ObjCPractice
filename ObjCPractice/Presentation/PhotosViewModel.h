//
//  PhotosViewModel.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>
#import "PhotosLoader.h"

@interface PhotosViewModel : NSObject

@property (nullable, nonatomic, copy) void(^onLoad)(BOOL isLoading);
@property (nullable, nonatomic, copy) void(^onError)(NSString * _Nullable errorMessage);
@property (nullable, nonatomic, copy) void(^didLoad)(NSArray * _Nonnull photos);

- (nonnull instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nonnull instancetype)initWithLoader:(nonnull id<PhotosLoader>)loader;
- (void)loadPhotos;

@end
