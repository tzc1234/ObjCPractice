//
//  RemoteImageDataLoaderTask.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "RemoteImageDataLoaderTask.h"

@interface RemoteImageDataLoaderTask ()

@property (nonnull, nonatomic, copy) id<HTTPClientTask> task;

@end

@implementation RemoteImageDataLoaderTask

@synthesize task;

- (nonnull instancetype)initWithTask:(nonnull id<HTTPClientTask>)task {
    self = [super init];
    self.task = task;
    return self;
}

- (void)cancel { 
    [self.task cancel];
}

@end
