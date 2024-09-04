//
//  SceneDelegate.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "SceneDelegate.h"
#import "ImagesViewController.h"

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
    
    ImagesViewController *controller = [[ImagesViewController alloc] init];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    [window makeKeyAndVisible];
}

@end
