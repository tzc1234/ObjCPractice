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
#import "ImageDataLoaderDispatchToMainDecorator.h"
#import "PhotosLoaderDispatchToMainDecorator.h"

@implementation PhotosViewComposer

+ (PhotosViewController *)composeWithPhotoLoader:(id<PhotosLoader>)photoLoader 
                                 imageDataLoader:(id<ImageDataLoader>)imageDataLoader {
    PhotosLoaderDispatchToMainDecorator *decoratedPhotoLoader = [[PhotosLoaderDispatchToMainDecorator alloc] 
                                                                 initWithDecoratee:photoLoader];
    PhotosViewModel *photosViewModel = [[PhotosViewModel alloc] initWithLoader:decoratedPhotoLoader];
    PhotosViewController *photosViewController = [[PhotosViewController alloc] initWithViewModel:photosViewModel];
    [PhotoCellController registerCellFor:photosViewController.tableView];
    
    ImageDataLoaderDispatchToMainDecorator *decoratedImageDataLoader = [[ImageDataLoaderDispatchToMainDecorator alloc]
                                                                        initWithDecoratee:imageDataLoader];
    
    photosViewModel.didLoad = ^(NSArray<Photo *> * _Nullable photos) {
        NSMutableArray<PhotoCellController *> *cellControllers = [NSMutableArray<PhotoCellController *> array];
        
        for (Photo *photo in photos) {
            PhotoImageDataViewModel *model = [[PhotoImageDataViewModel alloc] initWithLoader:decoratedImageDataLoader andPhoto:photo];
            PhotoCellController *controller = [[PhotoCellController alloc] initWithViewModel:model andAuthor:photo.author];
            [cellControllers addObject:controller];
        }
        
        [photosViewController display:cellControllers];
    };
    
    return photosViewController;
}

@end
