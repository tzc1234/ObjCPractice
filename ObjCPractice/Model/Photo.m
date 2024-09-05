//
//  Photo.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithID:(NSString *)ID author:(NSString *)author width:(NSInteger)width
                   height:(NSInteger)height webURL:(NSURL *)webURL url:(NSURL *)url {
    self = [super init];
    if (self) {
        _ID = [ID copy];
        _author = [author copy];
        _width = width;
        _height = height;
        _webURL = [webURL copy];
        _url = [url copy];
    }
    return self;
}

@end
