//
//  SceneDelegate.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "SceneDelegate.h"
#import "URLSessionHTTPClient.h"
#import "RemotePhotosLoader.h"
#import "PhotosViewModel.h"
#import "PhotosViewController.h"
#import "RemoteImageDataLoader.h"
#import "PhotoImageDataViewModel.h"
#import "PhotoCellController.h"

@interface SceneDelegate ()

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
    URLSessionHTTPClient *client = [[URLSessionHTTPClient alloc] initWithSession:NSURLSession.sharedSession];
    RemotePhotosLoader *loader = [[RemotePhotosLoader alloc] initWithURL:url client:client];
    PhotosViewModel *photosViewModel = [[PhotosViewModel alloc] initWithLoader:loader];
    
    PhotosViewController *photoController = [[PhotosViewController alloc] initWithViewModel:photosViewModel];
    [PhotoCellController registerCellFor:photoController.tableView];
    
    RemoteImageDataLoader *imageDataLoader = [[RemoteImageDataLoader alloc] initWithClient:client];
    
    photosViewModel.didLoad = ^(NSArray * _Nullable photos) {
        NSMutableArray *cellControllers = [NSMutableArray array];
        
        for (Photo *photo in photos) {
            PhotoImageDataViewModel *model = [[PhotoImageDataViewModel alloc] initWithLoader:imageDataLoader andPhoto:photo];
            PhotoCellController *controller = [[PhotoCellController alloc] initWithViewModel:model andAuthor:photo.author];
            [cellControllers addObject:controller];
        }
        
        [photoController display:cellControllers];
    };
    
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:photoController];
    [window makeKeyAndVisible];
}

@end
