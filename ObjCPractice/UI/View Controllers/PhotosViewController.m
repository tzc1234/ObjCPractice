//
//  PhotosViewController.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "PhotosViewController.h"
#import "ImageCell.h"
#import "Photo.h"

@interface PhotosViewController ()

@property (nonnull, nonatomic, strong) PhotosViewModel *viewModel;
@property (nonnull, nonatomic, copy) UIRefreshControl *refreshControl;
@property (nonnull, nonatomic, copy) NSArray *photos;
@property (nonatomic) BOOL isInit;

@end

@implementation PhotosViewController

@synthesize viewModel, refreshControl;

- (nonnull instancetype)initWithViewModel:(nonnull PhotosViewModel *)viewModel {
    self = [self init];
    self.title = @"Photos";
    self.viewModel = viewModel;
    self.photos = [NSArray array];
    self.isInit = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.refreshControl = [self makeRefreshControl];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ImageCell class] forCellReuseIdentifier:ImageCell.cellID];
    [self setupBindings];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    if (self.isInit) {
        self.isInit = NO;
        [self reloadPhotos];
    }
}

- (UIRefreshControl *)makeRefreshControl {
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(reloadPhotos) forControlEvents:UIControlEventValueChanged];
    return refresh;
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
    
    viewModel.didLoad = ^(NSArray * _Nonnull photos) {
        weakSelf.photos = photos;
        [weakSelf.tableView reloadData];
    };
    
    viewModel.onError = ^(NSString * _Nullable errorMessage) {
        NSLog(@"error: %@", errorMessage);
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCell.cellID];
    Photo *photo = self.photos[indexPath.row];
    cell.titleLabel.text = photo.author;
    return cell;
}

@end
