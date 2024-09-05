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
    PhotosViewController *controller = [[PhotosViewController alloc] initWithViewModel:photosViewModel];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    [window makeKeyAndVisible];
}

@end
