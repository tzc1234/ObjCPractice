//
//  PhotoCellController.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 06/09/2024.
//

#import "PhotoCellController.h"
#import "PhotoCell.h"

@interface PhotoCellController ()

@property (nonnull, nonatomic, strong) PhotoImageDataViewModel *viewModel;
@property (nullable, nonatomic, strong) PhotoCell *cell;

@end

@implementation PhotoCellController

@synthesize viewModel, cell;

+ (void)registerCellFor:(nonnull UITableView *)tableView {
    [tableView registerClass:[PhotoCell class] forCellReuseIdentifier:PhotoCell.cellID];
}

- (nullable instancetype)initWithViewModel:(nonnull PhotoImageDataViewModel *)viewModel 
                                 andAuthor:(nonnull NSString *)author {
    self = [super init];
    self.viewModel = viewModel;
    _author = author;
    return self;
}

- (nullable UITableViewCell *)cellFor:(nonnull UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PhotoCell.cellID];
    if (![cell isKindOfClass:[PhotoCell class]]) {
        return nil;
    }
    
    PhotoCell *photoCell = (PhotoCell *)cell;
    self.cell = photoCell;
    [self configureCell];
    
    return cell;
}

- (void)configure:(nonnull UITableViewCell *)cell {
    if (![cell isKindOfClass:[PhotoCell class]]) {
        return;
    }
    
    self.cell = (PhotoCell *)cell;
    [self configureCell];
}

- (void)configureCell {
    cell.titleLabel.text = self.author;
    cell.photoView.image = nil;
    [self setupBindings];
    [self loadImageData];
}

- (void)setupBindings {
    __weak PhotoCellController *weakSelf = self;
    
    viewModel.onLoadImageData = ^(BOOL isLoading) {
        weakSelf.cell.containerView.isShimmering = isLoading;
    };
    
    viewModel.didLoadImageData = ^(NSData * _Nullable data) {
        weakSelf.cell.photoView.image = [[UIImage alloc] initWithData:data];
    };
}

- (void)loadImageData {
    [viewModel loadImageData];
}

- (void)cancelImageDataLoad {
    [self releaseCellForReuse];
    [viewModel cancelImageDataLoad];
}

- (void)releaseCellForReuse {
    self.cell = nil;
}

@end
