//
//  PhotosViewController.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <UIKit/UIKit.h>
#import "PhotosViewModel.h"

@interface PhotosViewController : UITableViewController

- (nonnull instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nonnull instancetype)initWithViewModel:(nonnull PhotosViewModel *)viewModel;

@end
