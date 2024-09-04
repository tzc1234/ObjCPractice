//
//  ImageCell.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (strong, nonatomic) UIView *shadowBGView;
@property (strong, nonatomic) UIImageView *placeholderView;
@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation ImageCell

@synthesize shadowBGView, containerView, photoView, placeholderView, blurView, titleLabel;

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self configureLayout];
    return self;
}

- (void)configureLayout {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupShadowBGView];
    [self setupContainerView];
    [self setupPhotoView];
    [self setupPlaceholderView];
    [self setupBlurView];
    [self setupTitleLabel];
}

- (void)setupShadowBGView {
    shadowBGView = [[UIView alloc] initWithFrame:CGRectZero];
    shadowBGView.backgroundColor = UIColor.systemBackgroundColor;
    shadowBGView.layer.cornerRadius = 12;
    shadowBGView.layer.shadowColor = UIColor.secondaryLabelColor.CGColor;
    shadowBGView.layer.shadowOpacity = 0.9;
    shadowBGView.layer.shadowRadius = 2;
    shadowBGView.layer.shadowOffset = CGSizeMake(0, 3);
    shadowBGView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupContainerView {
    containerView = [[UIView alloc] init];
    containerView.backgroundColor = UIColor.systemGray3Color;
    containerView.layer.cornerRadius = 12;
    containerView.layer.borderWidth = 1;
    containerView.layer.borderColor = UIColor.tertiaryLabelColor.CGColor;
    containerView.clipsToBounds = YES;
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupPhotoView {
    photoView = [[UIImageView alloc] init];
    photoView.contentMode = UIViewContentModeScaleAspectFit;
    photoView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupPlaceholderView {
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:80];
    UIImage *placeholderImage = [UIImage systemImageNamed:@"photo" withConfiguration:configuration];
    placeholderView = [[UIImageView alloc] initWithImage:placeholderImage];
    placeholderView.tintColor = UIColor.secondaryLabelColor;
    placeholderView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupBlurView {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupTitleLabel {
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    titleLabel.numberOfLines = 0;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
