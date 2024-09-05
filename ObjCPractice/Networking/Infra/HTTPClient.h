//
//  HTTPClient.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>

extern NSInteger const responseOK;

typedef void(^HTTPClientCompletion)(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error);

@protocol HTTPClientTask

-(void)cancel;

@end

@protocol HTTPClient

- (nonnull id<HTTPClientTask>)getFromURL:(nonnull NSURL *)url completion:(nonnull HTTPClientCompletion)completion;

@end
