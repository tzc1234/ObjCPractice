//
//  PhotosViewController.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "Photo.h"
#import "PhotoCellController.h"

@interface PhotosViewController ()

@property (nonnull, nonatomic, strong) PhotosViewModel *viewModel;
@property (nonnull, nonatomic, copy) NSArray *photoCellController;
@property (nonatomic) BOOL isInit;

@end

@implementation PhotosViewController

@synthesize viewModel, photoCellController, isInit;

- (nullable instancetype)initWithViewModel:(nonnull PhotosViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.title = @"Photos";
        self.viewModel = viewModel;
        self.photoCellController = [NSArray array];
        self.isInit = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [self makeRefreshControl];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupBindings];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    if (isInit) {
        isInit = NO;
        [self reloadPhotos];
    }
}

- (UIRefreshControl *)makeRefreshControl {
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reloadPhotos) forControlEvents:UIControlEventValueChanged];
    return refresh;
}

- (void)display:(nonnull NSArray *)photoCellControllers {
    self.photoCellController = photoCellControllers;
    [self.tableView reloadData];
}

- (void)reloadPhotos {
    [viewModel loadPhotos];
}

- (void)setupBindings {
    __weak PhotosViewController *weakSelf = self;
    
    viewModel.onLoad = ^(BOOL isLoading) {
        if (isLoading) {
            [weakSelf.tableView.refreshControl beginRefreshing];
        } else {
            [weakSelf.tableView.refreshControl endRefreshing];
        }
    };
    
// TODO: Error Handling
//    self.viewModel.onError = ^(NSString * _Nullable errorMessage) {
//        NSLog(@"error: %@", errorMessage);
//    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return photoCellController.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self cellControllerForRowAtIndexPath:indexPath] cellFor:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self cellControllerForRowAtIndexPath:indexPath] configure:cell];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self cellControllerForRowAtIndexPath:indexPath] cancelImageDataLoad];
}

- (PhotoCellController *)cellControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return photoCellController[indexPath.row];
}

@end
