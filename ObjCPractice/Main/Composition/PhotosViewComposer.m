//
//  PhotosViewComposer.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import "PhotosViewComposer.h"

@implementation PhotosViewComposer

+ (PhotosViewController *)composeWithPhotoLoader:(id<PhotosLoader>)photoLoader 
                                 imageDataLoader:(id<ImageDataLoader>)imageDataLoader
                                       selection:(nullable void(^)(Photo * _Nullable photo))selection {
    PhotosViewModel *photosViewModel = [[PhotosViewModel alloc] initWithLoader:photoLoader];
    PhotosViewController *photosViewController = [[PhotosViewController alloc] initWithViewModel:photosViewModel];
    [PhotoCellController registerCellFor:photosViewController.tableView];
    
    photosViewModel.didLoad = ^(NSArray<Photo *> * _Nullable photos) {
        NSMutableArray<PhotoCellController *> *cellControllers = [NSMutableArray<PhotoCellController *> array];
        
        for (Photo *photo in photos) {
            PhotoImageDataViewModel *model = [[PhotoImageDataViewModel alloc] initWithLoader:imageDataLoader andPhoto:photo];
            PhotoCellController *controller = [[PhotoCellController alloc] initWithViewModel:model andAuthor:photo.author];
            controller.selection = ^{ selection(photo); };
            [cellControllers addObject:controller];
        }
        
        [photosViewController display:cellControllers];
    };
    
    return photosViewController;
}

@end
