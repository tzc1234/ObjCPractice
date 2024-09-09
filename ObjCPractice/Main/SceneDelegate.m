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

@implementation SceneDelegate

@synthesize window;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *) scene;
    if (!windowScene) {
        return;
    }
    
    window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://picsum.photos/v2/list"];
    URLSessionHTTPClient *client = [[URLSessionHTTPClient alloc] initWithSession:NSURLSession.sharedSession];
    RemotePhotosLoader *loader = [[RemotePhotosLoader alloc] initWithURL:url client:client];
    
    RemoteImageDataLoader *imageDataLoader = [[RemoteImageDataLoader alloc] initWithClient:client];
    NSCacheImageDataStore *imageDataStore = [[NSCacheImageDataStore alloc] init];
    ImageDataCacher *imageCacher = [[ImageDataCacher alloc] initWith:imageDataStore];
    
    ImageDataLoaderCacheDecorator *imageDataLoaderWithCache = [[ImageDataLoaderCacheDecorator alloc]
                                                               initWithLoader:imageDataLoader
                                                               andCacher:imageCacher];
    ImageDataLoaderWithFallbackComposite *imageDataLoaderWithFallback = [[ImageDataLoaderWithFallbackComposite alloc]
                                                                         initWithPrimary:imageCacher
                                                                         andFallback:imageDataLoaderWithCache];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:
                                 [PhotosViewComposer composeWithPhotoLoader:loader
                                                            imageDataLoader:imageDataLoaderWithFallback]];
    [window makeKeyAndVisible];
}

@end
