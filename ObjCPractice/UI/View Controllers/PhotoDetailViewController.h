//
//  PhotoDetailViewController.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 10/09/2024.
//

#import <UIKit/UIKit.h>
#import "PhotoDetailViewModel.h"

@interface PhotoDetailViewController : UIViewController

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithViewModel:(nonnull PhotoDetailViewModel *)viewModel;

@end
