//
//  ImageDataCacherDataLoadTask.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import "ImageDataCacherDataLoadTask.h"

@implementation ImageDataCacherDataLoadTask

@synthesize completion;

- (nullable instancetype)initWith:(nonnull ImageDataLoaderCompletion)completion {
    self = [super init];
    if (self) {
        self.completion = completion;
    }
    return self;
}

- (void)cancel {
    completion = nil;
}

@end
