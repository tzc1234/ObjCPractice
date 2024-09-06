//
//  HTTPClient.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>
#import "HTTPClientTask.h"

extern NSInteger const HTTPURLResponseOK;

typedef void(^HTTPClientCompletion)(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error);

@protocol HTTPClient

- (nonnull id<HTTPClientTask>)getFromURL:(nonnull NSURL *)url completion:(nonnull HTTPClientCompletion)completion;

@end
