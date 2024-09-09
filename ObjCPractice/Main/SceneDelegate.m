//
//  SceneDelegate.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "SceneDelegate.h"
#import "URLSessionHTTPClient.h"
#import "RemotePhotosLoader.h"
#import "RemoteImageDataLoader.h"
#import "PhotosViewComposer.h"
#import "NSCacheImageDataStore.h"
#import "ImageDataCacher.h"
#import "ImageDataLoaderCacheDecorator.h"
#import "ImageDataLoaderWithFallbackComposite.h"

@interface SceneDelegate ()

@property (strong, nonatomic) id<HTTPClient> httpClient;

@end

@implementation SceneDelegate

@synthesize window;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *) scene;
    if (!windowScene) {
        return;
    }
    
    window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://picsum.photos/v2/list"];
    RemotePhotosLoader *loader = [[RemotePhotosLoader alloc] initWithURL:url client:self.httpClient];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:
                                 [PhotosViewComposer composeWithPhotoLoader:loader
                                                            imageDataLoader:[self imageDataLoader]]];
    [window makeKeyAndVisible];
}

- (id<HTTPClient>)httpClient {
    if (!_httpClient) {
        _httpClient = [[URLSessionHTTPClient alloc] initWithSession:NSURLSession.sharedSession];
    }
    
    return _httpClient;
}

- (id<ImageDataLoader>)imageDataLoader {
    RemoteImageDataLoader *loader = [[RemoteImageDataLoader alloc] initWithClient:self.httpClient];
    NSCacheImageDataStore *store = [[NSCacheImageDataStore alloc] init];
    ImageDataCacher *cacher = [[ImageDataCacher alloc] initWith:store];
    
    ImageDataLoaderCacheDecorator *loaderWithCache = [[ImageDataLoaderCacheDecorator alloc]
                                                      initWithLoader:loader
                                                      andCacher:cacher];
    ImageDataLoaderWithFallbackComposite *loaderWithFallback = [[ImageDataLoaderWithFallbackComposite alloc]
                                                                initWithPrimary:cacher
                                                                andFallback:loaderWithCache];
    return loaderWithFallback;
}

@end
