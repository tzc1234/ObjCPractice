//
//  PhotoCell.h
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UITableViewCell

@property (class, readonly, nonatomic) NSString *cellID;

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UILabel *titleLabel;

@end
