//
//  ImageDataStore.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 09/09/2024.
//

#import <Foundation/Foundation.h>

@protocol ImageDataStore

- (void)insert:(nonnull NSData *)data
        forURL:(nonnull NSURL *)url
    completion:(void(^ _Nonnull)(NSError * _Nullable error))completion;
- (void)retrieveDataFor:(nonnull NSURL *)url
             completion:(void(^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))completion;

@end
