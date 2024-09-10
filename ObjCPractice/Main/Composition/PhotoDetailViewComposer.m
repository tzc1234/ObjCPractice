//
//  PhotoDetailViewComposer.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 10/09/2024.
//

#import "PhotoDetailViewComposer.h"
#import "PhotoDetailViewModel.h"

@implementation PhotoDetailViewComposer

+ (nullable PhotoDetailViewController *)composeWithImageDataLoader:(nonnull id<ImageDataLoader>)imageDataLoader 
                                                          andPhoto:(nonnull Photo *)photo {
    PhotoDetailViewModel *viewModel = [[PhotoDetailViewModel alloc] initWithLoader:imageDataLoader andPhoto:photo];
    PhotoDetailViewController *viewController = [[PhotoDetailViewController alloc] initWithViewModel:viewModel];
    return viewController;
}

@end
