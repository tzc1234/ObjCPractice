//
//  Photo.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
    
@property (nonatomic, readonly, nonnull) NSString *ID, *author;
@property (nonatomic, readonly, nonnull) NSURL *webURL, *url;
@property (nonatomic, readonly) NSInteger width, height;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithID:(nonnull NSString *)ID author:(nonnull NSString *)author width:(NSInteger)width
                            height:(NSInteger)height webURL:(nonnull NSURL *)webURL url:(nonnull NSURL *)url;

@end
