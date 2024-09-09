//
//  PhotoImageDataViewModel.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import <Foundation/Foundation.h>
#import "ImageDataLoader.h"
#import "Photo.h"

@interface PhotoImageDataViewModel : NSObject

@property (nullable, nonatomic, strong) void(^onLoadImageData)(BOOL isLoading);
@property (nullable, nonatomic, strong) void(^didLoadImageData)(NSData * _Nullable data);

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader andPhoto:(nonnull Photo *)photo;;
- (void)loadImageData;
- (void)cancelImageDataLoad;

@end
