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
#import "PhotoDetailViewComposer.h"
#import "ImageDataLoaderDispatchToMainDecorator.h"
#import "PhotosLoaderDispatchToMainDecorator.h"

@interface SceneDelegate ()

@property (strong, nonatomic) id<HTTPClient> httpClient;
@property (strong, nonatomic) id<ImageDataLoader> imageDataLoader;
@property (strong, nonatomic, nullable) UINavigationController *navigationController;

@end

@implementation SceneDelegate

@synthesize window, navigationController;

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *) scene;
    if (!windowScene) {
        return;
    }
    
    window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://picsum.photos/v2/list"];
    RemotePhotosLoader *loader = [[RemotePhotosLoader alloc] initWithURL:url client:self.httpClient];
    PhotosLoaderDispatchToMainDecorator *decoratedLoader = [[PhotosLoaderDispatchToMainDecorator alloc]
                                                                 initWithDecoratee:loader];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:
                            [PhotosViewComposer composeWithPhotoLoader:decoratedLoader
                                                       imageDataLoader:[self imageDataLoader]
                                                             selection:
                             ^(Photo * _Nullable photo) { [self showPhotoDetail:photo]; }]];
    
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
}

- (id<HTTPClient>)httpClient {
    if (!_httpClient) {
        _httpClient = [[URLSessionHTTPClient alloc] initWithSession:NSURLSession.sharedSession];
    }
    
    return _httpClient;
}

- (id<ImageDataLoader>)imageDataLoader {
    if (!_imageDataLoader) {
        RemoteImageDataLoader *loader = [[RemoteImageDataLoader alloc] initWithClient:self.httpClient];
        NSCacheImageDataStore *store = [[NSCacheImageDataStore alloc] init];
        ImageDataCacher *cacher = [[ImageDataCacher alloc] initWith:store];
        
        ImageDataLoaderCacheDecorator *loaderWithCache = [[ImageDataLoaderCacheDecorator alloc]
                                                          initWithLoader:loader
                                                          andCacher:cacher];
        ImageDataLoaderWithFallbackComposite *loaderWithFallback = [[ImageDataLoaderWithFallbackComposite alloc]
                                                                    initWithPrimary:cacher
                                                                    andFallback:loaderWithCache];
        ImageDataLoaderDispatchToMainDecorator *decoratedLoader = [[ImageDataLoaderDispatchToMainDecorator alloc]
                                                                   initWithDecoratee:loaderWithFallback];
        _imageDataLoader = decoratedLoader;
    }
    
    return _imageDataLoader;
}

- (void)showPhotoDetail:(Photo *)photo {
    PhotoDetailViewController *controller = [PhotoDetailViewComposer composeWithImageDataLoader:[self imageDataLoader]
                                                                                       andPhoto:photo];
    [navigationController presentViewController:controller animated:YES completion:nil];
}

@end
