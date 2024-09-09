//
//  PhotoCellController.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import <UIKit/UIKit.h>
#import "PhotoImageDataViewModel.h"

@interface PhotoCellController : NSObject

@property (nonnull, readonly) NSString *author;

+ (void)registerCellFor:(nonnull UITableView *)tableView;

- (nullable instancetype)init __attribute__((unavailable("This method is unavailable.")));
- (nullable instancetype)initWithViewModel:(nonnull PhotoImageDataViewModel *)viewModel 
                                 andAuthor:(nonnull NSString *)author;
- (nullable UITableViewCell *)cellFor:(nonnull UITableView *)tableView;
- (void)configure:(nonnull UITableViewCell *)cell;
- (void)loadImageData;
- (void)cancelImageDataLoad;

@end
