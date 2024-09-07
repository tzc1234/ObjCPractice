//
//  PhotoCell.m
//  ObjCPractice
//
//  Created by Tsz-Lung on 04/09/2024.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (strong, nonatomic) UIView *shadowBGView;
@property (strong, nonatomic) UIImageView *placeholderView;
@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation PhotoCell

@synthesize shadowBGView, containerView, photoView, placeholderView, blurView, titleLabel;

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureLayout];
    }
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
    [self setupConstraints];
}

- (void)setupConstraints {
    [self.contentView addSubview:shadowBGView];
    [shadowBGView addSubview:containerView];
    [containerView addSubview:placeholderView];
    [containerView addSubview:photoView];
    [containerView addSubview:blurView];
    [containerView addSubview:titleLabel];
    
    NSLayoutConstraint *bgBottomConstraint = [shadowBGView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor 
                                                                                       constant:-6];
    bgBottomConstraint.priority = 999;
    
    [NSLayoutConstraint activateConstraints:@[
        [shadowBGView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:6],
        [shadowBGView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:12],
        [shadowBGView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-12],
        bgBottomConstraint,
        [shadowBGView.heightAnchor constraintEqualToAnchor:shadowBGView.widthAnchor multiplier:0.56],
    
        [containerView.topAnchor constraintEqualToAnchor:shadowBGView.topAnchor],
        [containerView.leadingAnchor constraintEqualToAnchor:shadowBGView.leadingAnchor],
        [containerView.trailingAnchor constraintEqualToAnchor:shadowBGView.trailingAnchor],
        [containerView.bottomAnchor constraintEqualToAnchor:shadowBGView.bottomAnchor],
        
        [placeholderView.centerXAnchor constraintEqualToAnchor:containerView.centerXAnchor],
        [placeholderView.centerYAnchor constraintEqualToAnchor:containerView.centerYAnchor],
        
        [photoView.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [photoView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [photoView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [photoView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor],
        
        [blurView.topAnchor constraintEqualToAnchor:titleLabel.topAnchor constant:-8],
        [blurView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [blurView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [blurView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor],
        
        [titleLabel.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:8],
        [titleLabel.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-8],
        [titleLabel.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-8]
    ]];
}

- (void)setupShadowBGView {
    shadowBGView = [[UIView alloc] initWithFrame:CGRectZero];
    shadowBGView.backgroundColor = UIColor.systemBackgroundColor;
    shadowBGView.layer.cornerRadius = 6;
    shadowBGView.layer.shadowColor = UIColor.secondaryLabelColor.CGColor;
    shadowBGView.layer.shadowOpacity = 0.9;
    shadowBGView.layer.shadowRadius = 2;
    shadowBGView.layer.shadowOffset = CGSizeMake(0, 3);
    shadowBGView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupContainerView {
    containerView = [[ShimmeringView alloc] init];
    containerView.backgroundColor = UIColor.systemGray4Color;
    containerView.layer.cornerRadius = 6;
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
