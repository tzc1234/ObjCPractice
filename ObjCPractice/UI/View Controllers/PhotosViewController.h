//
//  PhotosViewController.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <UIKit/UIKit.h>
#import "PhotosViewModel.h"

@interface PhotosViewController : UITableViewController

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithViewModel:(nonnull PhotosViewModel *)viewModel;
- (void)display:(nonnull NSArray *)photoCellControllers;

@end
