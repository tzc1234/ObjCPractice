//
//  ImagesViewController.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "ImagesViewController.h"
#import "ImageCell.h"

@interface ImagesViewController ()

@end

@implementation ImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ImageCell class] forCellReuseIdentifier:ImageCell.cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCell.cellID];
    cell.textLabel.text = @"Cell";
    
    return cell;
}

@end
