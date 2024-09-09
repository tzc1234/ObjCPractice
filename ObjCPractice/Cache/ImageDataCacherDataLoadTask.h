//
//  ImageDataCacherDataLoadTask.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataLoader.h"
#import "ImageDataLoaderTask.h"

@interface ImageDataCacherDataLoadTask : NSObject <ImageDataLoaderTask>

@property (nullable, nonatomic, strong) ImageDataLoaderCompletion completion;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWith:(nonnull ImageDataLoaderCompletion)completion;

@end
