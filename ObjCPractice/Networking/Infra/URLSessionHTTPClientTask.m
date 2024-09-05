//
//  URLSessionHTTPClientTask.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 05/09/2024.
//

#import "URLSessionHTTPClientTask.h"

@interface URLSessionHTTPClientTask ()

@property (nonnull, nonatomic, strong) NSURLSessionTask *task;

@end

@implementation URLSessionHTTPClientTask

- (nonnull instancetype)initWithTask:(nonnull NSURLSessionTask *)task {
    self = [super init];
    self.task = task;
    return self;
}

- (void)cancel {
    [self.task cancel];
}

@end
