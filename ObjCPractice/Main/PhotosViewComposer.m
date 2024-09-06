//
//  PhotosViewComposer.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import "PhotosViewComposer.h"
#import "PhotosViewModel.h"
#import "PhotoCellController.h"
#import "RemoteImageDataLoader.h"

@implementation PhotosViewComposer

+ (PhotosViewController *)composeWithPhotoLoader:(id<PhotosLoader>)photoLoader 
                                 imageDataLoader:(id<ImageDataLoader>)imageDataLoader {
    PhotosViewModel *photosViewModel = [[PhotosViewModel alloc] initWithLoader:photoLoader];
    
    PhotosViewController *photosViewController = [[PhotosViewController alloc] initWithViewModel:photosViewModel];
    [PhotoCellController registerCellFor:photosViewController.tableView];
    
    photosViewModel.didLoad = ^(NSArray * _Nullable photos) {
        NSMutableArray *cellControllers = [NSMutableArray array];
        
        for (Photo *photo in photos) {
            PhotoImageDataViewModel *model = [[PhotoImageDataViewModel alloc] initWithLoader:imageDataLoader andPhoto:photo];
            PhotoCellController *controller = [[PhotoCellController alloc] initWithViewModel:model andAuthor:photo.author];
            [cellControllers addObject:controller];
        }
        
        [photosViewController display:cellControllers];
    };
    
    return photosViewController;
}

@end
