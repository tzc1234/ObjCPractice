//
//  HTTPClient.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>

@protocol HTTPClient

- (void)getFromURL:(nonnull NSURL *)url
        completion:(void (^ _Nonnull)(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error))completion;

@end
