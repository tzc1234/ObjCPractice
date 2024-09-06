//
//  RemoteImageDataLoaderTask.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "RemoteImageDataLoaderTask.h"

@interface RemoteImageDataLoaderTask ()

@property (nonnull, nonatomic, strong) id<HTTPClientTask> task;

@end

@implementation RemoteImageDataLoaderTask

@synthesize task;

- (nullable instancetype)initWithTask:(nonnull id<HTTPClientTask>)task {
    self = [super init];
    if (self) {
        self.task = task;
    }
    return self;
}

- (void)cancel { 
    [task cancel];
}

@end
