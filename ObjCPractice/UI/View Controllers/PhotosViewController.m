//
//  PhotosViewController.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "PhotosViewController.h"
#import "ImageCell.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Images";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ImageCell class] forCellReuseIdentifier:ImageCell.cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCell.cellID];
    cell.titleLabel.text = @"Title";
    
    return cell;
}

@end
