//
//  PhotoDetailViewModel.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 10/09/2024.
//

#import <Foundation/Foundation.h>
#import "ImageDataLoader.h"
#import "Photo.h"

@interface PhotoDetailViewModel : NSObject

@property (nullable, nonatomic, strong) void(^ onLoad)(BOOL isLoading);
@property (nullable, nonatomic, strong) void(^ didLoad)(NSData * _Nullable data);
@property (nullable, nonatomic, strong) void(^ shouldReload)(BOOL shouldReload);

@property (readonly, nonatomic, nullable) NSString *author;
@property (readonly, nonatomic, nullable) NSURL *webURL;
@property (readonly, nonatomic) NSInteger photoWidth;
@property (readonly, nonatomic) NSInteger photoHeight;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithLoader:(nonnull id<ImageDataLoader>)loader andPhoto:(nonnull Photo *)photo;
- (void)loadPhotoData;
- (void)cancelPhotoDataLoad;

@end
